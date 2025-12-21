<?php
session_start();
require_once "../php/Database.php";
require_once "../php/Chauffeur.php";

/* Hadchi Prod

if (!isset($_SESSION['id_user']) || $_SESSION['role'] !== 'chauffeur') {
    header("Location: ../LoginChauffeur.php");
    exit();
}

$dbObj = new Database();
$conn = $dbObj->connect();
$chauffeurObj = new Chauffeur($conn);

$sql = "SELECT u.prenom, u.nom, u.email, c.points, c.date_permis, c.type_vehicule 
        FROM utilisateur u 
        JOIN chauffeur c ON u.id_user = c.id_user 
        WHERE u.id_user = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $_SESSION['id_user']);
$stmt->execute();
$data = $stmt->get_result()->fetch_assoc();
$rank = $chauffeurObj->getRank($data['points']);
*/

// Hadchi Test

$data = [
    'prenom' => "Ahmed",
    'nom' => "Alami",
    'email' => "ahmed.driver@emsi.ma",
    'points' => 250, 
    'date_permis' => "2020-05-15",
    'type_vehicule' => "taxi"
];
$chauffeurObj = new Chauffeur(null); 
$rank = $chauffeurObj->getRank($data['points']);

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Z3ma Transport - Chauffeur</title>
    <link rel="stylesheet" href="../dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <nav class="sidebar">
        <div class="logo">My Dashboard</div>
        <a href="#" class="nav-item active">Analytics</a>
         <!--<a href="#" class="nav-item">Historique</a>
        <a href="#" class="nav-item">Messages</a>
        <a href="#" class="nav-item">Paramètres</a>-->
        
        <div style="margin-top: auto;">
            <a href="../logout.php" class="nav-item" style="color: var(--danger);">Sign Out</a>
        </div>
    </nav>

    <main class="main-content">
        <div class="header">
            <h2>Analytics</h2>
            <div style="display: flex; align-items: center; gap: 12px;">
                <span style="font-weight: 500;"><?php echo $data['prenom'] . " " . $data['nom']; ?></span>
                <div style="width: 40px; height: 40px; background: #e5e7eb; border-radius: 12px;"></div>
            </div>
        </div>

        <div class="stats-grid">
            <div class="card">
                <div class="card-title">Points Fidélité</div>
                <div class="card-value"><?php echo $data['points']; ?></div>
                <div class="badge" style="background-color: <?php echo $rank['color']; ?>;">
                    <?php echo $rank['level']; ?>
                </div>
            </div>

            <div class="card">
                <div class="card-title">Type de Transport</div>
                <div class="card-value"><?php echo ucfirst($data['type_vehicule']); ?></div>
                <div style="margin-top: 12px; font-size: 13px; color: var(--text-muted);">
                    Permis: <?php echo $data['date_permis']; ?>
                </div>
            </div>

            <div class="card">
                <div class="card-title">Progression</div>
                <div style="font-size: 14px; margin-top: 8px; line-height: 1.5;">
                    <?php echo $rank['next_level']; ?>
                </div>
            </div>
        </div>

        <div class="requests-container">
            <div class="card">
                <h3 style="margin-top: 0; margin-bottom: 20px;">Courses Disponibles</h3>
                <iframe src="requests.php"></iframe>
            </div>
        </div>
    </main>

</body>
</html>
