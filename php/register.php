<?php
session_start();
require_once "Database.php";
require_once "Chauffeur.php";

// Initialize OOP objects
$dbObj = new Database();
$conn = $dbObj->connect();
$chauffeurObj = new Chauffeur($conn);

// Prepare data array
$formData = [
    'prenom' => $_POST['prenom'],
    'nom' => $_POST['nom'],
    'email' => $_POST['email'],
    'password' => $_POST['password'],
    'dob' => $_POST['date_naissance'],
    'role' => $_POST['role'],
    'license_date' => $_POST['date_permis'],
    'car_year' => $_POST['annee_vehicule']
];

// 1. VALIDATION using the Class
$validationErrors = $chauffeurObj->validate($formData);

if (!empty($validationErrors)) {
    $_SESSION['errors'] = $validationErrors;
    header("Location: ../signupChauffeur.php");
    exit();
}

// 2. BUS LINE LOGIC using the Class
$assignedLine = null;
if ($formData['role'] === 'bus') {
    $assignedLine = $chauffeurObj->assignRandomLine();
    if (!$assignedLine) {
        $_SESSION['errors']['role'] = "No bus lines available.";
        header("Location: ../signupChauffeur.php");
        exit();
    }
}

// 3. DATABASE INSERTION
$passHashed = password_hash($formData['password'], PASSWORD_DEFAULT);
$sqlUser = "INSERT INTO utilisateur (prenom, nom, email, mot_de_passe, date_naissance) 
            VALUES ('".$formData['prenom']."', '".$formData['nom']."', '".$formData['email']."', '$passHashed', '".$formData['dob']."')";

if ($conn->query($sqlUser)) {
    $idUser = $conn->insert_id;
    $lineValue = $assignedLine ? $assignedLine : "NULL";
    
    $sqlChauffeur = "INSERT INTO chauffeur (id_user, type_vehicule, points, annee_vehicule, date_permis, id_ligne) 
                     VALUES ($idUser, '".$formData['role']."', 0, ".$formData['car_year'].", '".$formData['license_date']."', $lineValue)";
    
    if ($conn->query($sqlChauffeur)) {
        if ($assignedLine) {
            $conn->query("UPDATE lignes SET disponible = 0 WHERE id_ligne = $assignedLine");
        }
        unset($_SESSION['errors']);
        header("Location: ../LoginChauffeur.php");
    }
}
exit();