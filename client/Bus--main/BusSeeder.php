<?php
require_once "Seeder.php";

class BusSeeder extends Seeder
{
    public function run(): void
    {
        $marrakechBuses = [
            ['Bus 1',  'Guéliz – Médina'],
            ['Bus 2',  'Bab Doukkala – Sidi Youssef Ben Ali'],
            ['Bus 3',  'Massira – Jamaa El Fna'],
            ['Bus 4',  'Daoudiate – Guéliz'],
            ['Bus 5',  'Route de Casablanca – Centre'],
            ['Bus 6',  'Route de Safi – Guéliz'],
            ['Bus 7',  'Guéliz – Jamaa El Fna'],
            ['Bus 8',  'Sidi Ghanem – Guéliz'],
            ['Bus 10', 'Route d’Ourika – Jamaa El Fna'],
            ['Bus 11', 'Mhamid – Bab Doukkala'],
            ['Bus 12', 'Azzouzia – Centre'],
            ['Bus 14', 'Targa – Guéliz']
        ];

        $statuts = ['en_service', 'hors_service', 'en_maintenance'];
        $stmt = $this->db->prepare(
            "INSERT IGNORE INTO Bus (numero_bus, nom_ligne, statut, capacite)
             VALUES (?, ?, ?, ?)"
        );

        foreach ($marrakechBuses as $bus) {
            $numeroBus = $bus[0];
            $ligne     = $bus[1];
            $statut    = $statuts[array_rand($statuts)];
            $capacite  = rand(45, 80);
        
            $stmt->bind_param("sssi", $numeroBus, $ligne, $statut, $capacite);
            $stmt->execute();
        }

        echo " Marrakech buses inserted successfully<br>";
    }

    public function insertStops(): void
    {
        $stops = [
            'Guéliz','Avenue Mohammed V','Médina','Jamaa El Fna','Bab Doukkala',
            'Sidi Youssef Ben Ali','Place des Ferblantiers','Daoudiate','Route de Casablanca',
            'Route de Safi','Sidi Ghanem','Route d’Ourika','Mhamid','Azzouzia','Targa','Centre','Massira'
        ];

        $stmtStop = $this->db->prepare("INSERT IGNORE INTO Arret (nom_arret) VALUES (?)");

        foreach ($stops as $stop) {
            $stmtStop->bind_param("s", $stop);
            $stmtStop->execute();
        }

        echo "Arrets (bus stops) inserted successfully<br>";
    }

    public function linkBusStops(): void
    {
       
        $busIds = [];
        $result = $this->db->query("SELECT bus_id, numero_bus FROM Bus");
        while ($row = $result->fetch_assoc()) {
            $busIds[$row['numero_bus']] = $row['bus_id'];
        }


        $arretIds = [];
        $result = $this->db->query("SELECT arret_id, nom_arret FROM Arret");
        while ($row = $result->fetch_assoc()) {
            $arretIds[$row['nom_arret']] = $row['arret_id'];
        }


        $busStops = [
            'Bus 1' => ['Guéliz','Avenue Mohammed V','Médina','Jamaa El Fna'],
            'Bus 2' => ['Bab Doukkala','Sidi Youssef Ben Ali','Place des Ferblantiers','Guéliz'],
            'Bus 3' => ['Massira','Place des Ferblantiers','Jamaa El Fna'],
            'Bus 4' => ['Daoudiate','Guéliz'],
            'Bus 5' => ['Route de Casablanca','Centre'],
            'Bus 6' => ['Route de Safi','Guéliz'],
            'Bus 7' => ['Guéliz','Jamaa El Fna'],
            'Bus 8' => ['Sidi Ghanem','Guéliz'],
            'Bus 10'=> ['Route d’Ourika','Jamaa El Fna'],
            'Bus 11'=> ['Mhamid','Bab Doukkala'],
            'Bus 12'=> ['Azzouzia','Centre'],
            'Bus 14'=> ['Targa','Guéliz']
        ];

        $stmtLink = $this->db->prepare("
            INSERT IGNORE INTO Bus_Arret (bus_id, arret_id, ordre_passage)
            VALUES (?, ?, ?)
        ");

        foreach ($busStops as $busNum => $stops) {
            $busId = $busIds[$busNum];
            $order = 1;
            foreach ($stops as $stopName) {
                $stmtLink->bind_param("iii", $busId, $arretIds[$stopName], $order);
                $stmtLink->execute();
                $order++;
            }
        }

        echo "Bus ↔ Arrets linked successfully<br>";
    }
}
