<?php
include "connection.php";

// Get form data
$prenom = $_POST['prenom'];
$nom = $_POST['nom'];
$email = $_POST['email'];
$password = $_POST['password'];
$role = $_POST['role'];

// New fields from the aesthetic form
$date_naissance = $_POST['date_naissance'];
$date_permis = isset($_POST['date_permis']) ? $_POST['date_permis'] : null;
$annee_vehicule = isset($_POST['annee_vehicule']) ? intval($_POST['annee_vehicule']) : null;

// --- BUSINESS RULES VALIDATION --- 

$today = new DateTime('today');

// 1. Common Age Check: Must be > 18 for both Clients and Chauffeurs 
$birthDate = new DateTime($date_naissance);
$age = $birthDate->diff($today)->y;

if ($age < 18) {
    die("Registration Refused: You must be at least 18 years old.");
}

// 2. Specific Chauffeur Checks 
if ($role === 'chauffeur' || $role === 'bus' || $role === 'taxi') {
    
    // License Seniority Check: Must be > 2 years 
    $licenseDate = new DateTime($date_permis);
    $seniority = $licenseDate->diff($today)->y;

    if ($seniority < 2) {
        die("Registration Refused: Driver's license must be at least 2 years old.");
    }

    // Vehicle Year Check: Must be newer than 2015 
    if ($annee_vehicule <= 2015) {
        die("Registration Refused: The vehicle must be newer than 2015.");
    }
}

// --- DATABASE INSERTION ---

$password_hashed = password_hash($password, PASSWORD_DEFAULT);

// Insert into main utilisateur table
$sql_user = "INSERT INTO utilisateur (prenom, nom, email, mot_de_passe, date_naissance) 
             VALUES ('$prenom', '$nom', '$email', '$password_hashed', '$date_naissance')";

if (mysqli_query($conn, $sql_user)) {
    $id_user = mysqli_insert_id($conn);

    if ($role === 'chauffeur' || $role === 'bus' || $role === 'taxi') {
        // Insert into chauffeur table with new required fields and 0 points 
        $sql_chauffeur = "INSERT INTO chauffeur (id_user, type_vehicule, points, annee_vehicule, date_permis) 
                          VALUES ($id_user, '$role', 0, $annee_vehicule, '$date_permis')";
        mysqli_query($conn, $sql_chauffeur);
        header("Location: ../LoginChauffeur.php");
    } else {
        // Otherwise, they are a regular client
        mysqli_query($conn, "INSERT INTO client (id_user) VALUES ($id_user)");
        header("Location: ../LoginPassenger.php");
    }
} else {
    echo "Error: " . mysqli_error($conn);
}

exit();
?>