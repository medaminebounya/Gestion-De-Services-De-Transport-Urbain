<?php
session_start();
require_once "Database.php";
require_once "Chauffeur.php";

// 1. Initialize OOP objects
$dbObj = new Database();
$conn = $dbObj->connect();
$chauffeurObj = new Chauffeur($conn);

// 2. Prepare data array from POST
// We group the data into an array to pass it easily to our Class methods
$formData = [
    'prenom'   => $_POST['prenom'],
    'nom'      => $_POST['nom'],
    'email'    => $_POST['email'],
    'telephone'=> isset($_POST['telephone']) && $_POST['telephone'] !== '' ? $_POST['telephone'] : null,
    'password' => $_POST['password'],
    'dob'      => $_POST['date_naissance'],
    'role'     => $_POST['role'],
    'license_date' => $_POST['date_permis'] ?? null,
    'car_year'     => isset($_POST['annee_vehicule']) ? intval($_POST['annee_vehicule']) : null,
    'id_ligne'     => isset($_POST['id_ligne']) && $_POST['id_ligne'] !== '' ? intval($_POST['id_ligne']) : null
];

// 3. VALIDATION (Using the "Brain" in Chauffeur.php)
// This one line replaces all those old "if" statements
$validationErrors = $chauffeurObj->validate($formData);

if (!empty($validationErrors)) {
    $_SESSION['errors'] = $validationErrors;
    // Redirect back to whichever page sent the request (signupClient or signupChauffeur)
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit();
}

// 4. DATABASE TRANSACTIONS
// Hash password for security (Chapter 4)
$passHashed = password_hash($formData['password'], PASSWORD_DEFAULT);

// A. Insert into the 'utilisateur' table (include telephone)
$sqlUser = "INSERT INTO utilisateur (prenom, nom, email, telephone, mot_de_passe, date_naissance) 
            VALUES (?, ?, ?, ?, ?, ?)";

// Start transaction so we don't leave partial data on failure
$conn->begin_transaction();

$stmt = $conn->prepare($sqlUser);
if (!$stmt) {
    $_SESSION['errors']['db'] = "Prepare failed (utilisateur): " . $conn->error;
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit();
}

$stmt->bind_param("ssssss", $formData['prenom'], $formData['nom'], $formData['email'], $formData['telephone'], $passHashed, $formData['dob']);

if ($stmt->execute()) {
    $idUser = $conn->insert_id;

    // B. Handle Specific Roles (Chauffeur/Taxi/Bus vs Client)
    if ($formData['role'] !== 'client') {
        // Differentiate between bus and other drivers (taxi / personnel)
        if ($formData['role'] === 'bus') {
            // If a line was selected in the form, validate it's available
            if ($formData['id_ligne'] !== null) {
                $chk = $conn->prepare("SELECT id_ligne FROM lignes WHERE id_ligne = ? AND disponible = 1");
                $chk->bind_param("i", $formData['id_ligne']);
                $chk->execute();
                $res = $chk->get_result();
                if ($res && $res->num_rows > 0) {
                    $lineValue = $formData['id_ligne'];
                } else {
                    $_SESSION['errors']['line'] = "La ligne sélectionnée n'est pas disponible.";
                    header("Location: " . $_SERVER['HTTP_REFERER']);
                    exit();
                }
            } else {
                // No selection: try to assign a random available line
                $assignedLine = $chauffeurObj->assignRandomLine();
                if ($assignedLine === null) {
                    $_SESSION['errors']['line'] = "Aucune ligne disponible pour le bus. Réessayez plus tard.";
                    header("Location: " . $_SERVER['HTTP_REFERER']);
                    exit();
                }
                $lineValue = $assignedLine;
            }
        } else {
            // taxi or personnel: no line required
            $lineValue = null;
        }


        // Check whether 'id_ligne' column exists in 'chauffeur' table
        $hasIdLigne = false;
        try {
            $colRes = $conn->query("SHOW COLUMNS FROM chauffeur LIKE 'id_ligne'");
            if ($colRes && $colRes->num_rows > 0) {
                $hasIdLigne = true;
            } else {
                // Try to add the column automatically (best-effort)
                try {
                    $alter = "ALTER TABLE chauffeur ADD COLUMN id_ligne INT NULL AFTER date_permis";
                    $conn->query($alter);
                    // re-check
                    $colRes2 = $conn->query("SHOW COLUMNS FROM chauffeur LIKE 'id_ligne'");
                    if ($colRes2 && $colRes2->num_rows > 0) $hasIdLigne = true;
                } catch (Exception $e) {
                    // ignore alter errors; leave hasIdLigne false
                    $hasIdLigne = false;
                }
            }
        } catch (Exception $e) {
            $hasIdLigne = false;
        }

        $typeVehicule = $formData['role'];
        $anneeVehicule = $formData['car_year'];
        $datePermis = $formData['license_date'];
        $idLigne = $lineValue;

        if ($hasIdLigne) {
            $sqlChauffeur = "INSERT INTO chauffeur (id_user, type_vehicule, points, annee_vehicule, date_permis, id_ligne) 
                             VALUES (?, ?, 0, ?, ?, ?)";
            $stmtC = $conn->prepare($sqlChauffeur);
            // types: i (id_user), s (type), i (annee), s (date_permis), i (id_ligne)
            $stmtC->bind_param("isisi", $idUser, $typeVehicule, $anneeVehicule, $datePermis, $idLigne);
        } else {
            $sqlChauffeur = "INSERT INTO chauffeur (id_user, type_vehicule, points, annee_vehicule, date_permis) 
                             VALUES (?, ?, 0, ?, ?)";
            $stmtC = $conn->prepare($sqlChauffeur);
            // types: i (id_user), s (type), i (annee), s (date_permis)
            $stmtC->bind_param("isis", $idUser, $typeVehicule, $anneeVehicule, $datePermis);
        }

        if ($stmtC === false) {
            $_SESSION['errors']['db'] = "Prepare failed (chauffeur insert).";
            $conn->rollback();
            header("Location: " . $_SERVER['HTTP_REFERER']);
            exit();
        }

        if ($stmtC->execute()) {
            // If we inserted with an id_ligne and the lignes table exists, mark it unavailable
            try {
                if (isset($hasIdLigne) && $hasIdLigne && isset($idLigne) && $idLigne !== null) {
                    $upd = $conn->prepare("UPDATE lignes SET disponible = 0 WHERE id_ligne = ?");
                    if ($upd) {
                        $upd->bind_param("i", $idLigne);
                        $upd->execute();
                    }
                }
            } catch (Exception $e) {
                // ignore update errors — we still consider registration successful
            }

            // commit transaction and redirect
            $conn->commit();
            unset($_SESSION['errors']);
            header("Location: ../LoginChauffeur.html?success=1");
        } else {
            $_SESSION['errors']['db'] = "Erreur lors de l'enregistrement du chauffeur: " . ($stmtC->error ?? $conn->error);
            $conn->rollback();
            header("Location: " . $_SERVER['HTTP_REFERER']);
            exit();
        }
    } else {
        // Regular Client Path
        $sqlClient = "INSERT INTO client (id_user) VALUES (?)";
        $stmtCl = $conn->prepare($sqlClient);
        $stmtCl->bind_param("i", $idUser);
        
        if ($stmtCl->execute()) {
            $conn->commit();
            unset($_SESSION['errors']);
            // Auto-login the new client and redirect to selection
            $_SESSION['id_user'] = $idUser;
            $_SESSION['prenom'] = $formData['prenom'];
            $_SESSION['role'] = 'client';
            header("Location: ../client_select.html");
        } else {
            $_SESSION['errors']['db'] = "Erreur lors de l'enregistrement du client: " . ($stmtCl->error ?? $conn->error);
            $conn->rollback();
            header("Location: " . $_SERVER['HTTP_REFERER']);
        }
    }
} else {
    // If SQL fails (e.g., duplicate email)
    $_SESSION['errors']['email'] = "Email already exists: " . ($stmt->error ?? $conn->error);
    $conn->rollback();
    header("Location: " . $_SERVER['HTTP_REFERER']);
}
exit();
?>