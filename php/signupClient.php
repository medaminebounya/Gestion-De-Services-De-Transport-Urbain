<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passenger Sign Up - Z3ma CTM</title>
    <link rel="stylesheet" href="../Login.css">
    <script src="https://unpkg.com/feather-icons"></script>
</head>
<body>
    <a href="../LoginPassenger.html" class="back-button">
        <i data-feather="arrow-left"></i>
    </a>

    <div class="card">
        <header>
            <h1>Passenger Sign Up</h1>
            <p>Create an account to start riding</p>
        </header>
        <?php session_start(); ?>
            <form action="php/register.php" method="POST" novalidate>
                <label for="prenom">First Name</label>
                <input type="text" id="prenom" name="prenom" placeholder="El Maati" required>

                <label for="nom">Last Name</label>
                <input type="text" id="nom" name="nom" placeholder="Doukali" required>

                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="name@mail.com" required>

                <label for="password">P assword</label>
                <input type="password" id="password" name="password" placeholder="••••••••" 
                    class="<?php echo isset($_SESSION['errors']['password']) ? 'input-error' : ''; ?>" required>
                <?php if(isset($_SESSION['errors']['password'])): ?>
                    <span class="error-msg"><?php echo $_SESSION['errors']['password']; unset($_SESSION['errors']['password']); ?></span>
                <?php endif; ?>

                <input type="hidden" name="role" value="client">
                <input type="hidden" name="date_naissance" value="2000-01-01"> 
                
                <button type="submit">Create Account</button>
            </form>
        <div class="signup-link">
            <p>Already have an account? <a href="../LoginPassenger.html">Sign in</a></p>
        </div>
    </div>

    <script>
        feather.replace();
    </script>
</body>
</html>