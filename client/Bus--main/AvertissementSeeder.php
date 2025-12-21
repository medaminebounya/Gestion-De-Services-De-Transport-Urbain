<?php
require_once "Seeder.php";

class IncidentSeeder extends Seeder
{
    private array $types = ['embouteillage','accident','travaux','manifestation','panne','autre'];
    private array $levels = ['faible','moyen','eleve','critique'];
    private array $streets = ['Avenue Mohammed V','Jamaa El Fna','Route de Casablanca','Bab Doukkala','Guéliz','Route d’Ourika','Sidi Ghanem'];

    public function run(): void
    {
        $busIds = [];
        $result = $this->db->query("SELECT bus_id FROM Bus");
        while ($row = $result->fetch_assoc()) {
            $busIds[] = $row['bus_id'];
        }
        if (empty($busIds)) {
            echo "No buses found. Cannot generate incidents.<br>";
            return;
        }

        $stmt = $this->db->prepare("
            INSERT INTO avertissement
            (bus_id, type_avertissement, titre, message, position_lat, position_lon, rue_affectee, debut_avertissement, fin_avertissement, niveau, est_actif)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");

        for ($i=0; $i<15; $i++) {
            $busId = $busIds[array_rand($busIds)];
            $type = $this->types[array_rand($this->types)];
            $level = $this->levels[array_rand($this->levels)];
            $titre = ucfirst($type)." sur la ligne";
            $message = "Un $type est signalé, veuillez faire attention.";
            $latitude = 31.625 + mt_rand(-5000,5000)/100000;
            $longitude = -7.989 + mt_rand(-5000,5000)/100000;
            $rue = $this->streets[array_rand($this->streets)];
            $debut = date('Y-m-d H:i:s', strtotime('+'.rand(0,360).' minutes'));
            $fin = date('Y-m-d H:i:s', strtotime($debut.' + '.rand(10,60).' minutes'));
            $estActif = rand(0,1);

            $stmt->bind_param("isssddssssi",$busId,$type,$titre,$message,$latitude,$longitude,$rue,$debut,$fin,$level,$estActif);
            $stmt->execute();
        }

        echo "incidents inserted successfully<br>";
    }
}
