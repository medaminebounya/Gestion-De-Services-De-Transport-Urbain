<?php
require_once __DIR__ . '/../php/Database.php';

$db = (new Database())->connect();

// Get all taxi drivers from the 'chauffeur' table
$drivers = [];
if ($db) {
  $sql = "SELECT u.id_user, u.prenom, u.nom, u.telephone, c.type_vehicule FROM utilisateur u 
      JOIN chauffeur c ON c.id_user = u.id_user 
      WHERE c.type_vehicule = 'taxi'";
  $res = $db->query($sql);
  if ($res && $res->num_rows > 0) {
    while ($r = $res->fetch_assoc()) $drivers[] = $r;
  }
}



// Max 2 taxis
if (count($drivers) > 2) {
  shuffle($drivers);
  $drivers = array_slice($drivers, 0, 2);
}
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Taxi — Z3ma CTM</title>
  <link rel="stylesheet" href="../css/common.css">
  <link rel="stylesheet" href="../css/taxis.css">
  <meta http-equiv="refresh" content="20">
</head>
<body>
  <div class="wrap">
    <div class="panel">
      <div class="topbar">
        <div class="brand">Z3ma CTM</div>
        <form action="../php/logout.php" method="POST" style="margin:0">
          <button type="submit" class="logout">Déconnexion</button>
        </form>
      </div>

      <h1>Taxi trouvé</h1>
      <p class="lead">Voici un chauffeur taxi aléatoire proche de vous</p>

      <div class="choices taxi-list">
      <?php foreach ($drivers as $d):
          $fare = number_format(rand(900, 2500) / 100, 2);
          $distance_km = rand(1, 30);
          $eta_min = rand(2, 6);
          $eta_max = $eta_min + rand(1, 8);
      ?>
        <div class="card taxi-card">
          <div style="display:flex;align-items:center;width:100%">
            <div class="icon avatar">
              <?php echo htmlspecialchars(substr($d['prenom'], 0, 1)); ?>
            </div>

            <div style="margin-left:12px;flex:1">
              <div class="title driver-name">
                <?php echo htmlspecialchars($d['prenom'].' '.$d['nom']); ?>
              </div>
              <div class="desc">
                Type: <?php echo htmlspecialchars($d['type_vehicule']); ?>
                • Tel: <?php echo htmlspecialchars($d['telephone']); ?>
              </div>
            </div>

            <div class="right-info">
              <div class="fare">$<?php echo $fare; ?></div>
              <div class="eta"><?php echo $eta_min.'-'.$eta_max; ?> min</div>
            </div>
          </div>

          <div class="actions">
            <form action="book_taxi.php" method="POST">
              <input type="hidden" name="driver_id" value="<?php echo (int)$d['id_user']; ?>">
              <input type="hidden" name="fare" value="<?php echo $fare; ?>">
              <input type="hidden" name="distance_km" value="<?php echo $distance_km; ?>">
              <button class="btn" type="submit">Réserver</button>
            </form>
            <a class="btn ghost" href="../client_select.html">Retour</a>
          </div>
        </div>
      <?php endforeach; ?>
      </div>

    </div>
  </div>
</body>
</html>
