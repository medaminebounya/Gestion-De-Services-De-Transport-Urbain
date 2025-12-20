<?php
/**
 * Class Chauffeur
 * Handles business logic, ranking, and validation for drivers.
 */
class Chauffeur {
    private $db;
    public function __construct($dbConnection) {
        $this->db = $dbConnection;
    }

    /**
     * RANKING SYSTEM
     */
    public function getRank($points) {
        // We define the thresholds in an array for cleaner maintenance
        if ($points < 100) {
            return [
                'level' => 'Aucun grade',
                'medal' => 'none',
                'color' => '#64748b',
                'next_level' => (100 - $points) . " points restants pour Bronze"
            ];
        } 
        
        if ($points < 200) {
            return [
                'level' => 'Bronze',
                'medal' => 'bronze',
                'color' => '#cd7f32',
                'next_level' => (200 - $points) . " points restants pour Silver"
            ];
        } 
        
        if ($points < 500) {
            return [
                'level' => 'Silver',
                'medal' => 'silver',
                'color' => '#c0c0c0',
                'next_level' => (500 - $points) . " points restants pour Gold"
            ];
        } 

        return [
            'level' => 'Gold',
            'medal' => 'gold',
            'color' => '#ffd700',
            'next_level' => "Niveau Maximum atteint!"
        ];
    }

    /**
     * BUS LINE ASSIGNMENT (Chapitre 4: CRUD/Read)
     */
    public function assignRandomLine() {
        $query = "SELECT id_ligne FROM lignes WHERE disponible = 1 ORDER BY RAND() LIMIT 1";
        $result = $this->db->query($query);
        
        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();
            return $row['id_ligne'];
        }
        return null;
    }

    /**
     * BUSINESS RULES VALIDATION
     */
    public function validate($data) {
        $errors = [];
        $today = new DateTime('today');

        // Rule 1: Security (Password Length)
        if (empty($data['password']) || strlen($data['password']) < 6) {
            $errors['password'] = "Minimum 6 characters required.";
        }

        // Rule 2: Legal Age (18+)
        if (!empty($data['dob'])) {
            $age = (new DateTime($data['dob']))->diff($today)->y;
            if ($age < 18) {
                $errors['age'] = "You must be at least 18 years old.";
            }
        }

        // Rule 3: License Seniority (Only for drivers)
        if (isset($data['license_date']) && $data['role'] !== 'client') {
            $seniority = (new DateTime($data['license_date']))->diff($today)->y;
            if ($seniority < 2) {
                $errors['license'] = "License must be at least 2 years old.";
            }
        }

        // Rule 4: Vehicle Quality Control (Post-2015)
        if (isset($data['car_year']) && $data['role'] !== 'client') {
            if (intval($data['car_year']) <= 2015) {
                $errors['vehicle'] = "The vehicle must be newer than 2015.";
            }
        }

        return $errors;
    }
}