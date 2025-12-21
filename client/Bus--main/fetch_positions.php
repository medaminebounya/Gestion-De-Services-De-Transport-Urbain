<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once "Connection.php";

$db = new Connection();
$db->getConnection()->select_db("transport_urbain"); 


$sql = "
    SELECT p.bus_id, b.numero_bus, b.nom_ligne, b.statut, p.latitude, p.longitude
    FROM position_bus p
    JOIN Bus b ON p.bus_id = b.bus_id
    WHERE p.timestamp_position IN (
        SELECT MAX(timestamp_position) 
        FROM position_bus 
        GROUP BY bus_id
    )
";

$result = $db->getConnection()->query($sql);
$busPositions = [];
while ($row = $result->fetch_assoc()) {
    $busPositions[] = $row;
}

// Output JSON
header('Content-Type: application/json');
echo json_encode($busPositions);


$db->getConnection()->close();
?>
