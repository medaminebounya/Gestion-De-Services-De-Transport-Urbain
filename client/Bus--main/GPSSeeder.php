<?php
require_once "Seeder.php";

class GPSSeeder extends Seeder
{
    private array $stopCoords = [
        'Guéliz' => [31.6300, -7.9850],
        'Avenue Mohammed V' => [31.6290, -7.9810],
        'Médina' => [31.6320, -7.9910],
        'Jamaa El Fna' => [31.6258, -7.9890],
  
    ];

    public function run(): void
    {
        $busStops = [];
        $result = $this->db->query("
            SELECT ba.bus_id, a.nom_arret
            FROM Bus_Arret ba
            JOIN Arret a ON ba.arret_id = a.arret_id
            ORDER BY ba.bus_id, ba.ordre_passage
        ");

        while ($row = $result->fetch_assoc()) {
            $busStops[$row['bus_id']][] = $row['nom_arret'];
        }

  
        $sql = $this->db->prepare("
            INSERT INTO position_bus 
            (bus_id, latitude, longitude, vitesse, direction, precision_gps, batterie_level)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ");


        foreach ($busStops as $busId => $stops) {
            foreach ($stops as $stopName) {
                if (!isset($this->stopCoords[$stopName])) continue;

      
                $latOffset = mt_rand(-50, 50) / 100000; 
                $lonOffset = mt_rand(-50, 50) / 100000;

                $latitude  = $this->stopCoords[$stopName][0] + $latOffset;
                $longitude = $this->stopCoords[$stopName][1] + $lonOffset;
                $vitesse   = rand(0, 50);      
                $direction = rand(0, 359);     
                $precision = rand(1, 10);       
                $batterie  = rand(20, 100);     

                $sql->bind_param("dddiiii", $busId, $latitude, $longitude, $vitesse, $direction, $precision, $batterie);
                $sql->execute();
            }
        }



        echo "GPS positions generated successfully<br>";
    }
}
