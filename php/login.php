<?php
session_start();
require_once "Database.php";
require_once "User.php";

$dbObj = new Database();
$conn = $dbObj->connect();
$userObj = new User($conn);

$email = $_POST['email'];
$password = $_POST['password'];
$role = $_POST['role']; // From the hidden input in your forms

$result = $userObj->login($email, $password, $role);

if (is_array($result)) {
    // Login successful
    $_SESSION['id_user'] = $result['id_user'];
    $_SESSION['prenom'] = $result['prenom'];
    $_SESSION['role'] = $role;

    // Redirect based on role
    if ($role === 'chauffeur') {
        header("Location: ../chauffeur/dashboard.php");
    } else {
        header("Location: ../client/dashboard.php");
    }
} else {
    // Login failed - result contains the error message
    $_SESSION['login_error'] = $result;
    header("Location: " . $_SERVER['HTTP_REFERER']);
}
exit();