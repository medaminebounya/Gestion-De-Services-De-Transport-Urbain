<?php
class Chauffeur {
    private $db;

    public function __construct($dbConnection) {
        $this->db = $dbConnection;
    }

    /**
     * Ranking Logic (Reference: friend's logic & Chapter 2 Associative Arrays)
     * This method converts raw points into a readable Rank Object
     */
    public function getRank($points) {
        if ($points < 100) {
            return [
                'level' => 'Aucun grade',
                'medal' => 'none',
                'color' => '#64748b',
                'next_level' => (100 - $points) . " points restants pour Bronze"
            ];
        } elseif ($points >= 100 && $points < 200) {
            return [
                'level' => 'Bronze',
                'medal' => 'bronze',
                'color' => '#cd7f32',
                'next_level' => (200 - $points) . " points restants pour Silver"
            ];
        } elseif ($points >= 200 && $points < 500) {
            return [
                'level' => 'Silver',
                'medal' => 'silver',
                'color' => '#c0c0c0',
                'next_level' => (500 - $points) . " points restants pour Gold"
            ];
        } else {
            return [
                'level' => 'Gold',
                'medal' => 'gold',
                'color' => '#ffd700',
                'next_level' => "Niveau Maximum atteint!"
            ];
        }
    }

    // This handles the random and unique bus line assignment (Chapter 4: CRUD)
    public function assignRandomLine() {
        $query = "SELECT id_ligne FROM lignes WHERE disponible = 1 ORDER BY RAND() LIMIT 1";
        $result = $this->db->query($query);
        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();
            return $row['id_ligne'];
        }
        return null;
    }

    // Business Rules Validation (Chapter 1 & 3: Logic & Forms)
    public function validate($data) {
        $errors = [];
        $today = new DateTime('today');

        if (strlen($data['password']) < 6) {
            $errors['password'] = "Minimum 6 characters required.";
        }

        $age = (new DateTime($data['dob']))->diff($today)->y;
        if ($age < 18) {
            $errors['age'] = "You must be at least 18 years old.";
        }

        if (isset($data['license_date'])) {
            $seniority = (new DateTime($data['license_date']))->diff($today)->y;
            if ($seniority < 2) {
                $errors['license'] = "License must be at least 2 years old.";
            }
        }

        if (isset($data['car_year']) && intval($data['car_year']) <= 2015) {
            $errors['vehicle'] = "The vehicle must be newer than 2015.";
        }

        return $errors;
    }
}
?>