<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'client.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    die("Méthode non autorisée");
}

if (
    empty($_POST['nom']) ||
    empty($_POST['prenom']) ||
    empty($_POST['telephone']) ||
    empty($_POST['email'])
) {
    die("Tous les champs sont obligatoires");
}

$client = new Client();
$client->nom = $_POST['nom'];
$client->prenom = $_POST['prenom'];
$client->telephone = $_POST['telephone'];
$client->email = $_POST['email'];

if ($client->create()) {
    echo "Client ajouté avec succès";
} else {
    echo "Erreur lors de l'ajout du client";
}