<?php
require_once __DIR__ . '/../php/Database.php';
require_once __DIR__ . '/chauffeur_select.php';

$database = new Database();
$db = $database->connect();

if (!isset($_POST['chauffeur_id'])) {
    die("Aucun chauffeur sélectionné.");
}

$chauffeur_id = intval($_POST['chauffeur_id']);

$chauffeurObj = new Chauffeur($db);
$sql = "SELECT u.id_user, u.nom, u.prenom, u.email, u.telephone, u.date_naissance,
               c.date_permis, c.points, c.medaille, c.anciennete_permis, c.annee_vehicule
        FROM utilisateur u
        JOIN chauffeur c ON u.id_user = c.id_user
        WHERE u.id_user = ?";
$stmt = $db->prepare($sql);
$stmt->bind_param("i", $chauffeur_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    die("Chauffeur introuvable.");
}

$chauffeur = $result->fetch_assoc();

// Tarif aléatoire entre 20 et 50 dollars
$tarif = rand(20, 50);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Chauffeur</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 40px;
            color: #333;
        }
        .container {
            max-width: 700px;
            margin: 0 auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #2c3e50;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 8px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:hover {
            background-color: #f0f8ff;
        }
        .tarif {
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            color: #27ae60;
        }
        .buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 25px;
        }
        .buttons form button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .buttons form button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Détails du Chauffeur Sélectionné</h2>
        <table>
            <tr><th>Nom</th><td><?= htmlspecialchars($chauffeur['nom']) ?></td></tr>
            <tr><th>Prénom</th><td><?= htmlspecialchars($chauffeur['prenom']) ?></td></tr>
            <tr><th>Email</th><td><?= htmlspecialchars($chauffeur['email']) ?></td></tr>
            <tr><th>Téléphone</th><td><?= htmlspecialchars($chauffeur['telephone']) ?></td></tr>
            <tr><th>Date de naissance</th><td><?= htmlspecialchars($chauffeur['date_naissance']) ?></td></tr>
            <tr><th>Date permis</th><td><?= htmlspecialchars($chauffeur['date_permis']) ?></td></tr>
            <tr><th>Points</th><td><?= htmlspecialchars($chauffeur['points']) ?></td></tr>
            <tr><th>Médaille</th><td><?= htmlspecialchars($chauffeur['medaille']) ?></td></tr>
            <tr><th>Ancienneté permis</th><td><?= htmlspecialchars($chauffeur['anciennete_permis']) ?> ans</td></tr>
            <tr><th>Année véhicule</th><td><?= htmlspecialchars($chauffeur['annee_vehicule']) ?></td></tr>
        </table>

        <div class="tarif">
            Tarif estimé : $<?= $tarif ?>
        </div>

        <div class="buttons">
            <!-- Bouton pour confirmer la réservation -->
            <form action="confirmer_reservation.php" method="post">
                <input type="hidden" name="chauffeur_id" value="<?= htmlspecialchars($chauffeur['id_user']) ?>">
                <input type="hidden" name="tarif" value="<?= $tarif ?>">
                <button type="submit">Valider</button>
            </form>

            <!-- Bouton pour revenir à la sélection -->
            <form action="select.php">
                <button type="submit">Choisir un autre chauffeur</button>
            </form>
        </div>
    </div>
</body>
</html>
