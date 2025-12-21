<?php
session_start();
require_once "../client/Bus--main/connection.php"; 
$db = new Connection();
$conn = $db->getConnection();

// 1. Force use of the seeded database
$conn->select_db("transport_urbain"); 

if (!isset($_SESSION['id_user'])) { exit("Non autorisé"); }

$userId = $_SESSION['id_user'];

// 2. Identify the driver
$stmt = $conn->prepare("SELECT type_vehicule, id_ligne FROM chauffeur WHERE id_user = ?");
$stmt->bind_param("i", $userId);
$stmt->execute();
$driver = $stmt->get_result()->fetch_assoc();
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../Login.css">
</head>
<body>

<div class="info-card">
    <?php if ($driver['type_vehicule'] === 'bus'): ?>
        <h4 style="color: #2563eb; margin-top: 0;">Itinéraire de ma Ligne (Bus ID: <?= htmlspecialchars($driver['id_ligne']) ?>)</h4>
        
        <?php
        // DEFINE THE QUERY FIRST
        $sql = "SELECT a.nom_arret, ba.ordre_passage 
                FROM Bus_Arret ba 
                INNER JOIN Arret a ON ba.arret_id = a.arret_id 
                WHERE ba.bus_id = " . intval($driver['id_ligne']) . " 
                ORDER BY ba.ordre_passage";
        
        // RUN THE QUERY
        $res = $conn->query($sql);
        
        // CHECK RESULTS
        if ($res && $res->num_rows > 0):
            while ($stop = $res->fetch_assoc()): ?>
                <div class="bus-item">
                    <strong>Arrêt <?= $stop['ordre_passage'] ?>:</strong> <?= htmlspecialchars($stop['nom_arret']) ?>
                </div>
            <?php endwhile; ?>
            <a href="../dashboard_map.php" target="_parent" style="display:inline-block; margin-top:10px; color: #2563eb; font-weight: bold; text-decoration: none;">→ Voir sur la Carte Live</a>
        <?php else: ?>
            <p style="color: #666;">Aucun arrêt trouvé pour cette ligne.</p>
            <p style="font-size: 11px; color: #999;">Note: Vérifiez que id_ligne dans votre table chauffeur correspond à un bus_id dans la table Bus.</p>
        <?php endif; ?>

    <?php else: ?>
        <?php
        $taxiSql = "SELECT * FROM trajet WHERE id_chauffeur IS NULL ORDER BY RAND() LIMIT 1";
        $taxiRes = $conn->query($taxiSql);
        $trajet = ($taxiRes) ? $taxiRes->fetch_assoc() : null;

        if ($trajet): ?>
            <div class="taxi-box">
                <h4>Nouvelle Course</h4>
                <p>De: <strong><?= htmlspecialchars($trajet['point_depart']) ?></strong></p>
                <p>À: <strong><?= htmlspecialchars($trajet['point_arrivee']) ?></strong></p>
                <form action="handle_trajet.php" method="POST">
                    <input type="hidden" name="id_trajet" value="<?= $trajet['id_trajet'] ?>">
                    <button class="btn">Accepter la course</button>
                </form>
            </div>
        <?php else: ?>
            <p style="text-align:center; color:#888;">Aucune course disponible...</p>
            <button onclick="location.reload()" style="display:block; margin: 0 auto; font-size: 12px;">Rafraîchir</button>
        <?php endif; ?>
    <?php endif; ?>
</div>
</body>
</html>