<?php
require_once __DIR__ . '/Database.php';

class Client {
    private $conn;

    public $id;
    public $nom;
    public $prenom;
    public $telephone;
    public $email;
    public $password; 
    public $date_naissance;

    public function __construct() {
        $database = new Database();
        $this->conn = $database->connect(); 
    }

    public function create() {
        if (!$this->conn) return false;

        $this->conn->begin_transaction();

        try {
            $sqlUser = "INSERT INTO utilisateur (nom, prenom, email, telephone, mot_de_passe, date_naissance) VALUES (?, ?, ?, ?, ?, ?)";
            $stmt = $this->conn->prepare($sqlUser);
            if (!$stmt) throw new Exception('Prepare utilisateur failed: ' . $this->conn->error);

            $hashed = password_hash($this->password, PASSWORD_DEFAULT);
            $stmt->bind_param('ssssss', $this->nom, $this->prenom, $this->email, $this->telephone, $hashed, $this->date_naissance);
            if (!$stmt->execute()) throw new Exception('Execute utilisateur failed: ' . $stmt->error);

            $userId = $this->conn->insert_id;

            $sqlClient = "INSERT INTO client (id_user, date_inscription, nb_trajets) VALUES (?, CURDATE(), 0)";
            $stmt2 = $this->conn->prepare($sqlClient);
            if (!$stmt2) throw new Exception('Prepare client failed: ' . $this->conn->error);
            $stmt2->bind_param('i', $userId);
            if (!$stmt2->execute()) throw new Exception('Execute client failed: ' . $stmt2->error);

            $this->conn->commit();
            $this->id = $userId;
            return $userId;
        } catch (Exception $e) {
            $this->conn->rollback();
            error_log('Client::create error: ' . $e->getMessage());
            return false;
        }
    }
}
