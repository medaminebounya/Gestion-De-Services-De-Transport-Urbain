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
    'password' => $_POST['password'],
    'dob'      => $_POST['date_naissance'],
    'role'     => $_POST['role'],
    'license_date' => $_POST['date_permis'] ?? null,
    'car_year'     => isset($_POST['annee_vehicule']) ? intval($_POST['annee_vehicule']) : null
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

// A. Insert into the 'utilisateur' table
$sqlUser = "INSERT INTO utilisateur (prenom, nom, email, mot_de_passe, date_naissance) 
            VALUES (?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sqlUser);
$stmt->bind_param("sssss", $formData['prenom'], $formData['nom'], $formData['email'], $passHashed, $formData['dob']);

if ($stmt->execute()) {
    $idUser = $conn->insert_id;

    // B. Handle Specific Roles (Chauffeur/Taxi/Bus vs Client)
    if ($formData['role'] !== 'client') {
        
        // Specialized Bus Logic: Assign a line if they are a bus driver
        $assignedLine = ($formData['role'] === 'bus') ? $chauffeurObj->assignRandomLine() : null;
        $lineValue = $assignedLine ? $assignedLine : null;

        $sqlChauffeur = "INSERT INTO chauffeur (id_user, type_vehicule, points, annee_vehicule, date_permis, id_ligne) 
                         VALUES (?, ?, 0, ?, ?, ?)";
        
        $stmtC = $conn->prepare($sqlChauffeur);
        $stmtC->bind_param("isssi", $idUser, $formData['role'], $formData['car_year'], $formData['license_date'], $lineValue);
        
        if ($stmtC->execute()) {
            unset($_SESSION['errors']);
            header("Location: ../LoginChauffeur.php?success=1");
        }
    } else {
        // Regular Client Path
        $sqlClient = "INSERT INTO client (id_user) VALUES (?)";
        $stmtCl = $conn->prepare($sqlClient);
        $stmtCl->bind_param("i", $idUser);
        
        if ($stmtCl->execute()) {
            unset($_SESSION['errors']);
            header("Location: ../LoginPassenger.php?success=1");
        }
    }
} else {
    // If SQL fails (e.g., duplicate email)
    $_SESSION['errors']['email'] = "Email already exists.";
    header("Location: " . $_SERVER['HTTP_REFERER']);
}
exit();
?>