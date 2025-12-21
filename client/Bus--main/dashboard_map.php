<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Bus Dashboard</title>
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css"/>
<style>
    #map { height: 90vh; width: 100%; }
    body { margin: 0; }
</style>
</head>
<body>
<div id="map"></div>

<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var map = L.map('map').setView([31.6295, -7.9811], 13);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors'
}).addTo(map);

// Marker colors based on status
var statusColors = {
    'en_service': 'green',
    'hors_service': 'red',
    'en_maintenance': 'orange'
};

var markers = {};

// Function to fetch bus positions
function updateBusPositions() {
    $.getJSON('fetch_positions.php', function(buses) {
        // Remove old markers
        for (var key in markers) {
            map.removeLayer(markers[key]);
        }
        markers = {};

        buses.forEach(bus => {
            var color = statusColors[bus.statut] || 'blue';
            var icon = L.icon({
                iconUrl: `https://maps.google.com/mapfiles/ms/icons/${color}-dot.png`,
                iconSize: [32,32],
                iconAnchor: [16,32],
                popupAnchor: [0,-32]
            });

            var marker = L.marker([bus.latitude, bus.longitude], {icon: icon}).addTo(map);
            marker.bindPopup(`
                <b>Bus:</b> ${bus.numero_bus}<br>
                <b>Line:</b> ${bus.nom_ligne}<br>
                <b>Status:</b> ${bus.statut}
            `);

            markers[bus.bus_id] = marker;
        });
    });
}

// Initial load
updateBusPositions();

// Refresh every 5 seconds
setInterval(updateBusPositions, 5000);
</script>
</body>
</html>
