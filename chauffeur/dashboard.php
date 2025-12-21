<?php
session_start();

if (!isset($_SESSION['id_user']) || $_SESSION['role'] !== 'chauffeur') {
    header("Location: ../LoginChauffeur.html");
    exit();
}
?>

<h1>Chauffeur dashboard</h1>
<p>If you see this, login worked.</p>

<a href="../index.html">Logout</a>
