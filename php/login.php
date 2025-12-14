<?php

// error_reporting(E_ALL);
// ini_set('display_errors', 1);

// // Debug: show all POST data
// var_dump($_POST);
// exit();

session_start();
include "connection.php";

$email = $_POST['email'];
$password = $_POST['password'];
$role = $_POST['role']; // "chauffeur" or "client"

$sql = "SELECT * FROM utilisateur WHERE email='$email'";
$result = mysqli_query($conn, $sql);

if ($user = mysqli_fetch_assoc($result)) {

    if ($password === $user['mot_de_passe']) {

        $_SESSION['id_user'] = $user['id_user'];
        $_SESSION['role'] = $role;

        if ($role === "chauffeur") {

            $check = mysqli_query(
                $conn,
                "SELECT * FROM chauffeur WHERE id_user=" . $user['id_user']
            );

            if (mysqli_num_rows($check) > 0) {
                header("Location: ../chauffeur/dashboard.php");
                exit();
            } else {
                echo "No chauffeur account found for this user";
            }

        } elseif ($role === "client") {

            $check = mysqli_query(
                $conn,
                "SELECT * FROM client WHERE id_user=" . $user['id_user']
            );

            if (mysqli_num_rows($check) > 0) {
                header("Location: ../client/dashboard.php");
                exit();
            } else {
                echo "No client account found for this user";
            }

        } else {
            echo "Unknown role selected";
        }

    } else {
        echo "Wrong password";
    }

} else {
    echo "User not found";
}
