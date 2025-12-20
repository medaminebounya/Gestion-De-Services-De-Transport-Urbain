<?php
class User {
    private $db;

    public function __construct($dbConnection) {
        $this->db = $dbConnection;
    }

    public function login($email, $password, $role) {
        $stmt = $this->db->prepare("SELECT * FROM utilisateur WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 1) {
            $user = $result->fetch_assoc();

            if (password_verify($password, $user['mot_de_passe'])) {
                $table = ($role === 'chauffeur') ? 'chauffeur' : 'client';
                $checkStmt = $this->db->prepare("SELECT * FROM $table WHERE id_user = ?");
                $checkStmt->bind_param("i", $user['id_user']);
                $checkStmt->execute();
                
                if ($checkStmt->get_result()->num_rows > 0) {
                    return $user;
                }
                return "Role mismatch: No $role account found.";
            }
        }
        return "Invalid email or password.";
    }
}
?>