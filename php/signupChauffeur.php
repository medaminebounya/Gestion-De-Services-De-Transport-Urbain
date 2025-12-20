<?php session_start(); ?>
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

        <form action="php/register.php" method="POST" class="form-grid" novalidate>
            
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
            <p>Already a driver? <a href="../LoginChauffeur.php">Sign in</a></p>
        </div>
    </div>

    <script>feather.replace();</script>
</body>
</html>