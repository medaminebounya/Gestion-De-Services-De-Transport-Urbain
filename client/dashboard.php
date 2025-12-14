<?php
session_start();

if (!isset($_SESSION['id_user']) || $_SESSION['role'] !== 'client') {
    header("Location: ../LoginPassenger.html");
    exit();
}
?>

<h1>Client dashboard</h1>
<p>If you see this, login worked.</p>

<a href="../php/logout.php">Logout</a>
