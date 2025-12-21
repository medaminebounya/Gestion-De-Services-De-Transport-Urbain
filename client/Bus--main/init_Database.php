<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "Connection.php";
require_once "DatabaseSetup.php";
require_once "BusSeeder.php";
require_once "TrajetSeeder.php";
require_once "GPSSeeder.php";
require_once "AvertissementSeeder.php";

$connection = new Connection("transport_urbain");


$setup = new DatabaseSetup();
$setup->createDatabase();
$setup->createTables();


$seeders = [
    new BusSeeder($connection),
    new TrajetSeeder($connection),
    new GPSSeeder($connection),
    new IncidentSeeder($connection)
];

foreach ($seeders as $seeder) {
    $seeder->run();
}


$connection->getConnection()->close();
echo "Database initialized successfully";
