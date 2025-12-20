<?php
class User {
    private $db;

    public function __construct($dbConnection) {
        $this->db = $dbConnection;
    }

    public function login($email, $password, $role) {
        // Use Prepared Statements for security (Standard in OOP)
        $stmt = $this->db->prepare("SELECT * FROM utilisateur WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 1) {
            $user = $result->fetch_assoc();

            // Verify password hash
            if (password_verify($password, $user['mot_de_passe'])) {
                // Now check if they actually have a record in the specific role table
                $table = ($role === 'chauffeur') ? 'chauffeur' : 'client';
                $checkStmt = $this->db->prepare("SELECT * FROM $table WHERE id_user = ?");
                $checkStmt->bind_param("i", $user['id_user']);
                $checkStmt->execute();
                
                if ($checkStmt->get_result()->num_rows > 0) {
                    return $user; // Success!
                } else {
                    return "Role mismatch: No $role account found.";
                }
            }
        }
        return "Invalid email or password.";
    }
}
?>