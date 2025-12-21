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
        // Try to pick a random available 'lignes' entry if the table exists
        try {
            $query = "SELECT id_ligne FROM lignes WHERE disponible = 1 ORDER BY RAND() LIMIT 1";
            $result = $this->db->query($query);
            if ($result && $result->num_rows > 0) {
                $row = $result->fetch_assoc();
                return intval($row['id_ligne']);
            }
        } catch (Exception $e) {
            // Table might not exist — fall through to fallback logic
        }

        // Fallback when there is no 'lignes' table or no available rows:
        // Use line IDs from 0 to 10 inclusive.
        try {
            $lines = range(0, 10);
            $counts = [];
            foreach ($lines as $ln) $counts[$ln] = 0;

            // Count existing buses per line (0..10)
            $sql = "SELECT id_ligne, COUNT(*) as cnt FROM chauffeur WHERE type_vehicule = 'bus' AND id_ligne BETWEEN 0 AND 10 GROUP BY id_ligne";
            $res = $this->db->query($sql);
            $total = 0;
            if ($res && $res->num_rows > 0) {
                while ($r = $res->fetch_assoc()) {
                    $id = intval($r['id_ligne']);
                    if ($id >= 0 && $id <= 10) {
                        $counts[$id] = intval($r['cnt']);
                        $total += intval($r['cnt']);
                    }
                }
            }

            // If there are no buses at all, assign the first missing line in order (0,1,2...)
            foreach ($lines as $ln) {
                if ($counts[$ln] === 0) return intval($ln);
            }

            // If all lines already used at least once, return a random line between 0 and 10
            return rand(0, 10);
        } catch (Exception $e) {
            // As a last resort, random 0..10
            return rand(0, 10);
        }
    }

    /**
     * BUSINESS RULES VALIDATION
     */
    public function validate($data) {
        $errors = [];
        $today = new DateTime('today');

        // Password length
        if (empty($data['password']) || strlen($data['password']) < 6) {
            $errors['password'] = "Minimum 6 caractères requis.";
        }

        // Simple date parser: accept YYYY or YYYY-MM-DD
        $parseDate = function($v) {
            if (empty($v)) return null;
            $v = trim($v);
            if (preg_match('/^\d{4}$/', $v)) $v .= '-01-01';
            try { return new DateTime($v); } catch (Exception $e) { return null; }
        };

        $role = isset($data['role']) ? $data['role'] : 'client';

        if ($role !== 'client') {
            // DOB: must be >= 18
            $dob = $parseDate($data['dob'] ?? null);
            if (!$dob || $dob->diff($today)->y < 18) {
                $errors['age'] = "Vous devez avoir au moins 18 ans.";
            }

            // License: must be >= 2 years
            $lic = $parseDate($data['license_date'] ?? null);
            if (!$lic || $lic->diff($today)->y < 2) {
                $errors['license'] = "Le permis doit dater d'au moins 2 ans.";
            }

            // Car year: numeric and > 2015
            $carYearVal = $data['car_year'] ?? '';
            if ($carYearVal === '' || !ctype_digit(strval($carYearVal))) {
                $errors['vehicle'] = "Année véhicule invalide.";
            } else {
                $carYear = intval($carYearVal);
                if ($carYear <= 2015) {
                    $errors['vehicle'] = "Le véhicule doit être postérieur à 2015.";
                }
            }
        }

        return $errors;
    }
}