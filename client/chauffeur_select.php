<?php
class Chauffeur {
    private mysqli $db;

    public function __construct(mysqli $db) {
        $this->db = $db;
    }

    public function getChauffeursPersonnel() {
        $sql = "SELECT u.id_user AS id, u.nom, u.prenom, u.email, u.telephone, u.date_naissance,
                       c.date_permis, c.points, c.medaille, c.anciennete_permis, c.annee_vehicule, c.type_vehicule
                FROM utilisateur u
                JOIN chauffeur c ON u.id_user = c.id_user
                WHERE c.type_vehicule = 'personnel'
                ORDER BY c.points DESC";
        return $this->db->query($sql);
    }
}
