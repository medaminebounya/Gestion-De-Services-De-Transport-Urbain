<?php
session_start();
require_once "../php/Database.php";
$conn = (new Database())->connect();

if ($_POST['choice'] === 'accept') {
    $id_trajet = $_POST['id_trajet'];
    $id_user = $_SESSION['id_user'];

    // Update the trajet to assign this chauffeur
    $sql = "UPDATE trajet SET id_chauffeur = ? WHERE id_trajet = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $id_user, $id_trajet);
    
    if ($stmt->execute()) {
        echo "<script>alert('Trajet accepté !'); window.location='dashboard.php';</script>";
    }
} else {
    header("Location: requests.php");
}