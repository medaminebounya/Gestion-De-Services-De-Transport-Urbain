<?php
session_start();
require_once "Database.php";
$lines = [];
try {
    $db = (new Database())->connect();
    if ($db) {
        $has = $db->query("SHOW TABLES LIKE 'lignes'");
        if ($has && $has->num_rows > 0) {
            $res = $db->query("SELECT id_ligne, nom_ligne FROM lignes WHERE disponible = 1");
            if ($res && $res->num_rows > 0) {
                while ($r = $res->fetch_assoc()) {
                    $lines[] = $r;
                }
            }
        }
    }
} catch (mysqli_sql_exception $e) {
    // Table might not exist or another DB error occurred — leave $lines empty
    $lines = [];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chauffeur Sign Up - Z3ma CTM</title>
    <link rel="stylesheet" href="../Login.css">
    <script src="https://unpkg.com/feather-icons"></script>
</head>
<body>
    <a href="../LoginChauffeur.html" class="back-button">
        <i data-feather="arrow-left"></i>
    </a>

    <div class="card" style="width: 500px;"> 
        <header>
            <h1>Chauffeur Sign Up</h1>
            <p>Join the professional driver network</p>
        </header>

        <?php if(!empty($_SESSION['errors'])): ?>
            <div class="form-errors">
                <?php foreach($_SESSION['errors'] as $k => $msg): ?>
                    <div class="error-msg"><?php echo htmlspecialchars($msg); ?></div>
                <?php endforeach; unset($_SESSION['errors']); ?>
            </div>
        <?php endif; ?>

        <form action="register.php" method="POST" class="form-grid" novalidate>
            
            <div class="form-group">
                <label for="prenom">First Name</label>
                <input type="text" id="prenom" name="prenom" placeholder="Ahmed" required>
            </div>

            <div class="form-group">
                <label for="nom">Last Name</label>
                <input type="text" id="nom" name="nom" placeholder="Alami" required>
            </div>

            <div class="form-group full-width">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="driver@mail.com" required>
            </div>

            <div class="form-group full-width">
                <label for="telephone">Téléphone</label>
                <input type="telephone" id="telephone" name="telephone" placeholder="0612345678" 
                       class="<?php echo isset($_SESSION['errors']['telephone']) ? 'input-error' : ''; ?>">
                <?php if(isset($_SESSION['errors']['telephone'])): ?>
                    <span class="error-msg"><?php echo $_SESSION['errors']['telephone']; unset($_SESSION['errors']['telephone']); ?></span>
                <?php endif; ?>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="••••••••" 
                       class="<?php echo isset($_SESSION['errors']['password']) ? 'input-error' : ''; ?>" required>
                <?php if(isset($_SESSION['errors']['password'])): ?>
                    <span class="error-msg"><?php echo $_SESSION['errors']['password']; unset($_SESSION['errors']['password']); ?></span>
                <?php endif; ?>
            </div>

            <div class="form-group">
                <label for="role">Vehicle Type</label>
                <select name="role" id="role">
                    <option value="taxi">Taxi</option>
                    <option value="bus">Bus</option>
                    <option value="chauffeur">Personnel</option>
                </select>
                <?php if(isset($_SESSION['errors']['role'])): ?>
                    <span class="error-msg"><?php echo $_SESSION['errors']['role']; unset($_SESSION['errors']['role']); ?></span>
                <?php endif; ?>
            </div>

          
            <div class="form-group">
                <label for="date_naissance">Date of Birth</label>
                <input type="date" id="date_naissance" name="date_naissance" 
                       class="<?php echo isset($_SESSION['errors']['age']) ? 'input-error' : ''; ?>" required>
                <?php if(isset($_SESSION['errors']['age'])): ?>
                    <span class="error-msg"><?php echo $_SESSION['errors']['age']; unset($_SESSION['errors']['age']); ?></span>
                <?php endif; ?>
            </div>

            <div class="form-group">
                <label for="annee_vehicule">Vehicle Year</label>
                <input type="number" id="annee_vehicule" name="annee_vehicule" placeholder="2024" 
                       class="<?php echo isset($_SESSION['errors']['vehicle']) ? 'input-error' : ''; ?>" required>
                <?php if(isset($_SESSION['errors']['vehicle'])): ?>
                    <span class="error-msg"><?php echo $_SESSION['errors']['vehicle']; unset($_SESSION['errors']['vehicle']); ?></span>
                <?php endif; ?>
            </div>

            <div class="form-group full-width">
                <label for="date_permis">Driver's License Date</label>
                <input type="date" id="date_permis" name="date_permis" 
                       class="<?php echo isset($_SESSION['errors']['license']) ? 'input-error' : ''; ?>" required>
                <?php if(isset($_SESSION['errors']['license'])): ?>
                    <span class="error-msg"><?php echo $_SESSION['errors']['license']; unset($_SESSION['errors']['license']); ?></span>
                <?php endif; ?>
            </div>

            <button type="submit" class="full-width">Register as Driver</button>
        </form>

        <div class="signup-link">
            <p>Already a driver? <a href="../LoginChauffeur.html">Sign in</a></p>
        </div>
    </div>

    <script>feather.replace();</script>
    <script>
        (function(){
            var role = document.getElementById('role');
            var lineGroup = document.getElementById('line-group');
            var lineSelect = document.getElementById('id_ligne');
            function toggle() {
                if (!role) return;
                if (role.value === 'bus') {
                    lineGroup.style.display = 'block';
                    if (lineSelect) lineSelect.setAttribute('required','required');
                } else {
                    lineGroup.style.display = 'none';
                    if (lineSelect) lineSelect.removeAttribute('required');
                }
            }
            if (role) {
                role.addEventListener('change', toggle);
                toggle();
            }
        })();
    </script>
</body>
</html>