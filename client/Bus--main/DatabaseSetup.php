<?php

require_once "Connection.php";

class DatabaseSetup
{
    private string $dbName = "TransportBus";

    public function createDatabase(): void
    {

        $conn = (new Connection())->getConnection();

        $conn->query(
            "CREATE DATABASE IF NOT EXISTS {$this->dbName}
             CHARACTER SET utf8mb4
             COLLATE utf8mb4_unicode_ci"
        );

        echo "Database '{$this->dbName}' created or already exists<br>";
        $conn->close();
    }

    public function createTables(): void
    {
        
        $db = (new Connection($this->dbName))->getConnection();



$db->query("
CREATE TABLE IF NOT EXISTS Bus (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    numero_bus VARCHAR(20) NOT NULL UNIQUE,
    nom_ligne VARCHAR(100) NOT NULL,
    statut ENUM('en_service','hors_service','en_maintenance') DEFAULT 'en_service',
    capacite INT DEFAULT 50
)
");



$db->query("
CREATE TABLE IF NOT EXISTS Arret (
    arret_id INT AUTO_INCREMENT PRIMARY KEY,
    nom_arret VARCHAR(100) NOT NULL UNIQUE
)
");


$db->query("
CREATE TABLE IF NOT EXISTS Bus_Arret (
    bus_id INT NOT NULL,
    arret_id INT NOT NULL,
    ordre_passage INT NOT NULL,
    PRIMARY KEY (bus_id, arret_id),
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id) ON DELETE CASCADE,
    FOREIGN KEY (arret_id) REFERENCES Arret(arret_id) ON DELETE CASCADE
)
");



$db->query("
CREATE TABLE IF NOT EXISTS trajet (
    trajet_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    arret_id INT NOT NULL,
    ordre_passage INT NOT NULL,
    horaire_theorique TIME,
    temps_arret_min INT DEFAULT 1,
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id) ON DELETE CASCADE,
    FOREIGN KEY (arret_id) REFERENCES Arret(arret_id) ON DELETE CASCADE,
    UNIQUE KEY unique_bus_ordre (bus_id, ordre_passage),
    UNIQUE KEY unique_bus_arret (bus_id, arret_id),
    INDEX idx_bus_ordre (bus_id, ordre_passage)
)
");




$db->query("
CREATE TABLE IF NOT EXISTS position_bus (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    vitesse INT DEFAULT 0,
    direction INT,
    precision_gps DECIMAL(5,2),
    batterie_level INT,
    timestamp_position TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id) ON DELETE CASCADE,
    INDEX idx_bus_timestamp (bus_id, timestamp_position),
    INDEX idx_timestamp (timestamp_position)
)
");



$db->query("
CREATE TABLE IF NOT EXISTS avertissement (
    avertissement_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    type_avertissement ENUM(
        'embouteillage','accident','travaux',
        'manifestation','panne','autre'
    ) NOT NULL,
    titre VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    position_lat DECIMAL(10,8),
    position_lon DECIMAL(11,8),
    rue_affectee VARCHAR(200),
    debut_avertissement DATETIME NOT NULL,
    fin_avertissement DATETIME NOT NULL,
    niveau ENUM('faible','moyen','eleve','critique') DEFAULT 'moyen',
    est_actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bus_id) REFERENCES Bus(bus_id) ON DELETE CASCADE,
    INDEX idx_bus_actif (bus_id, est_actif),
    INDEX idx_periode (debut_avertissement, fin_avertissement)
)
");


        echo "Tables created successfully<br>";
        $db->close();
    }
}
