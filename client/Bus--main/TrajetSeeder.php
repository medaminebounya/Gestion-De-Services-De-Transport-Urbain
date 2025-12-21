<?php
require_once "Seeder.php";

class TrajetSeeder extends Seeder
{
    private function randomTime(int $startHour = 6, int $endHour = 22): string
    {
        $hour = rand($startHour, $endHour-1);
        $minute = rand(0, 59);
        return sprintf("%02d:%02d:00", $hour, $minute);
    }

    private function addMinutes(string $time, int $minutesToAdd): string
    {
        $date = new DateTime($time);
        $date->modify("+$minutesToAdd minutes");
        return $date->format('H:i:s');
    }

    public function run(): void
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

        $stmt = $this->db->prepare("
            INSERT IGNORE INTO trajet 
            (bus_id, arret_id, ordre_passage, horaire_theorique, temps_arret_min)
            VALUES (?, ?, ?, ?, ?)
        ");

        foreach ($busStops as $busNum => $stops) {
            $busId = $busIds[$busNum];
            $order = 1;
            $currentTime = $this->randomTime();

            foreach ($stops as $stopName) {
                $arretId = $arretIds[$stopName];
                $stopTime = $currentTime;
                $stopDuration = rand(1, 5); 

                $stmt->bind_param("iiisi", $busId, $arretId, $order, $stopTime, $stopDuration);
                $stmt->execute();

         
                $travelTime = rand(5, 15);
                $currentTime = $this->addMinutes($stopTime, $travelTime);

                $order++;
            }
        }

        echo "Trajets inserted successfully<br>";
    }
}
