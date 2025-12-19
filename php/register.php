<?php
// Include database connection
include "db.php";

// Get form data
$prenom = $_POST['prenom'];
$nom = $_POST['nom'];
$email = $_POST['email'];
$password = $_POST['password'];
$role = $_POST['role'];

// Hash the password for security
$password_hashed = password_hash($password, PASSWORD_DEFAULT);

// Insert into utilisateur table
mysqli_query($conn, "
    INSERT INTO utilisateur (prenom, nom, email, mot_de_passe)
    VALUES ('$prenom', '$nom', '$email', '$password_hashed')
");

// Get the last inserted user ID
$id_user = mysqli_insert_id($conn);

// Handle role-specific table
if ($role === 'chauffeur' || $role === 'bus' || $role === 'taxi') {
    mysqli_query($conn, "INSERT INTO chauffeur (id_user) VALUES ($id_user)");
    header("Location: LoginChauffeur.html");
} else {
    mysqli_query($conn, "INSERT INTO client (id_user) VALUES ($id_user)");
    header("Location: LoginPassenger.html");
}

exit();
?>
