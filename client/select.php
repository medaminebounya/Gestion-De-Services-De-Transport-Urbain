<?php
require_once __DIR__ . '/../php/Database.php';
require_once __DIR__ . '/chauffeur_select.php';

$database = new Database();
$db = $database->connect();

$chauffeurObj = new Chauffeur($db);
$result = $chauffeurObj->getChauffeursPersonnel();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Choisir un chauffeur</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
            color: #333;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        form {
            max-width: 1000px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
            font-size: 14px;
        }

        th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #dbeefb;
        }

        input[type="radio"] {
            transform: scale(1.2);
            cursor: pointer;
        }

        button {
            margin-top: 20px;
            padding: 10px 25px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<h2>Liste des chauffeurs personnels (triés par points)</h2>

<!-- Modification ici : action="traitement.php" -->
<form action="traitement.php" method="post">
    <table>
        <thead>
            <tr>
                <th>Sélection</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Email</th>
                <th>Téléphone</th>
                <th>Date Naissance</th>
                <th>Date Permis</th>
                <th>Points</th>
                <th>Médaille</th>
                <th>Ancienneté permis</th>
                <th>Année véhicule</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $result->fetch_assoc()) { ?>
                <tr>
                    <td>
                        <input type="radio" name="chauffeur_id" value="<?= htmlspecialchars($row['id']) ?>" required>
                    </td>
                    <td><?= htmlspecialchars($row['nom']) ?></td>
                    <td><?= htmlspecialchars($row['prenom']) ?></td>
                    <td><?= htmlspecialchars($row['email']) ?></td>
                    <td><?= htmlspecialchars($row['telephone']) ?></td>
                    <td><?= htmlspecialchars($row['date_naissance']) ?></td>
                    <td><?= htmlspecialchars($row['date_permis']) ?></td>
                    <td><?= htmlspecialchars($row['points']) ?></td>
                    <td><?= htmlspecialchars($row['medaille']) ?></td>
                    <td><?= htmlspecialchars($row['anciennete_permis']) ?></td>
                    <td><?= htmlspecialchars($row['annee_vehicule']) ?></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>

    <br>
    <button type="submit">Valider</button>
</form>

</body>
</html>
