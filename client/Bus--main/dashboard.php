<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "Connection.php";

$db = new Connection();
$conn = $db->getConnection();
$conn->select_db("transport_urbain");


$buses = [];
$res = $conn->query("SELECT * FROM Bus");
while ($row = $res->fetch_assoc()) {
    $buses[$row['bus_id']] = $row;
}

$positions = [];
$res = $conn->query("
    SELECT p.*
    FROM position_bus p
    WHERE p.timestamp_position IN (
        SELECT MAX(timestamp_position)
        FROM position_bus
        GROUP BY bus_id
    )
");
while ($row = $res->fetch_assoc()) {
    $positions[$row['bus_id']] = $row;
}

$stops = [];
$res = $conn->query("
    SELECT ba.bus_id, a.nom_arret, ba.ordre_passage
    FROM Bus_Arret ba
    JOIN Arret a ON ba.arret_id = a.arret_id
    ORDER BY ba.bus_id, ba.ordre_passage
");
while ($row = $res->fetch_assoc()) {
    $stops[$row['bus_id']][] = $row;
}

$incidents = [];
$res = $conn->query("SELECT * FROM avertissement WHERE est_actif = 1");
while ($row = $res->fetch_assoc()) {
    $incidents[$row['bus_id']][] = $row;
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>transport_urbain — Dashboard</title>
<style>
:root {
    --primary:#1f2937;
    --secondary:#2563eb;
    --bg:#f3f4f6;
    --card:#ffffff;
    --success:#16a34a;
    --warning:#f59e0b;
    --danger:#dc2626;
    --muted:#6b7280;
}

* { box-sizing:border-box; }

body {
    margin:0;
    font-family: "Segoe UI", system-ui, sans-serif;
    background:var(--bg);
    color:#111827;
}

header {
    background:var(--primary);
    color:#fff;
    padding:20px 40px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.header-actions{display:flex;align-items:center;gap:12px}
.map-btn{background:var(--secondary);color:white;padding:8px 12px;border-radius:8px;text-decoration:none;font-weight:700;border:0;box-shadow:0 8px 20px rgba(37,99,235,0.12)}
.map-btn:hover{opacity:0.95}

header h1 {
    margin:0;
    font-size:22px;
    letter-spacing:.5px;
}

.container {
    padding:30px;
    display:grid;
    grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
    gap:25px;
}

.card {
    background:var(--card);
    border-radius:14px;
    padding:22px;
    box-shadow:0 10px 25px rgba(0,0,0,.08);
    transition:.2s;
}

.card:hover {
    transform:translateY(-3px);
}

.card h2 {
    margin:0;
    font-size:18px;
    font-weight:600;
}

.sub {
    color:var(--muted);
    font-size:13px;
    margin-bottom:8px;
}

.badge {
    display:inline-block;
    padding:5px 12px;
    border-radius:999px;
    font-size:12px;
    font-weight:600;
    margin-top:8px;
}

.en_service { background:rgba(22,163,74,.15); color:var(--success); }
.hors_service { background:rgba(220,38,38,.15); color:var(--danger); }
.en_maintenance { background:rgba(245,158,11,.15); color:var(--warning); }

.section {
    margin-top:18px;
}

.section h3 {
    font-size:14px;
    margin-bottom:8px;
    color:var(--secondary);
}

ul {
    list-style:none;
    padding:0;
    margin:0;
}

ul li {
    font-size:14px;
    padding:6px 0;
    border-bottom:1px solid #e5e7eb;
}

ul li:last-child { border:none; }

small {
    color:var(--muted);
}
</style>
</head>

<body>

<header>
    <h1>🚌 transport_urbain – Monitoring Dashboard</h1>
    <div class="header-actions">
        <small>Real-time textual overview</small>
        <a class="map-btn" href="dashboard_map.php">Voir la carte</a>
    </div>
</header>

<div class="container">

<?php foreach ($buses as $id => $bus): ?>
<div class="card">
    <h2><?= $bus['numero_bus']; ?></h2>
    <div class="sub"><?= $bus['nom_ligne']; ?></div>

    <span class="badge <?= $bus['statut']; ?>">
        <?= strtoupper(str_replace('_',' ', $bus['statut'])); ?>
    </span>

    <div class="section">
        <h3>Position actuelle</h3>
        <?php if (isset($positions[$id])): ?>
            <small>
                Lat: <?= $positions[$id]['latitude']; ?> |
                Lon: <?= $positions[$id]['longitude']; ?> |
                <?= $positions[$id]['vitesse']; ?> km/h
            </small>
        <?php else: ?>
            <small>Aucune donnée GPS</small>
        <?php endif; ?>
    </div>

    <div class="section">
        <h3>Arrêts</h3>
        <ul>
        <?php if (isset($stops[$id])): ?>
            <?php foreach ($stops[$id] as $s): ?>
                <li><?= $s['ordre_passage']; ?> — <?= $s['nom_arret']; ?></li>
            <?php endforeach; ?>
        <?php else: ?>
            <li>Aucun arrêt</li>
        <?php endif; ?>
        </ul>
    </div>

    <div class="section">
        <h3>Avertissements</h3>
        <ul>
        <?php if (isset($incidents[$id])): ?>
            <?php foreach ($incidents[$id] as $i): ?>
                <li>
                    <strong><?= strtoupper($i['type_avertissement']); ?></strong>
                    <br><small><?= $i['message']; ?></small>
                </li>
            <?php endforeach; ?>
        <?php else: ?>
            <li>Aucun avertissement actif</li>
        <?php endif; ?>
        </ul>
    </div>
</div>
<?php endforeach; ?>

</div>

</body>
</html>

<?php $conn->close(); ?>
