<?php
require_once "../php/Database.php";
$conn = (new Database())->connect();

$query = "SELECT * FROM trajet WHERE id_chauffeur IS NULL ORDER BY RAND() LIMIT 1";
$res = $conn->query($query);
$trajet = $res->fetch_assoc();
?>
<link rel="stylesheet" href="../Login.css">
<div style="padding: 15px; border: 1px dashed #ccc; border-radius: 8px; text-align: center;">
    <?php if ($trajet): ?>
        <h4>Nouveau Trajet Détecté!</h4>
        <p>De: <strong><?php echo $trajet['point_depart']; ?></strong></p>
        <p>À: <strong><?php echo $trajet['point_arrivee']; ?></strong></p>
        <p>Distance: <?php echo $trajet['distance']; ?> KM</p>
        
        <form action="handle_trajet.php" method="POST">
            <input type="hidden" name="id_trajet" value="<?php echo $trajet['id_trajet']; ?>">
            <button name="choice" value="accept" class="btn-primary" style="background: #10b981;">Accepter</button>
            <button name="choice" value="refuse" class="btn-primary" style="background: #ef4444; margin-left: 10px;">Refuser</button>
        </form>
    <?php else: ?>
        <p>En attente de nouvelles demandes...</p>
        <button onclick="location.reload()" style="padding: 5px 10px; cursor:pointer;">Actualiser</button>
    <?php endif; ?>
</div>