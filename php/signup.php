<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link rel="stylesheet" href="../Login.css">
    <script src="https://unpkg.com/feather-icons"></script>
</head>
<body>
    <a href="index.html" class="back-button">
        <i data-feather="arrow-left"></i>
    </a>

    <div class="card">
        <header>
            <h1>Create Account</h1>
            <p>Join the CTM family</p>
        </header>

        <form action="register.php" method="POST">
            <label for="full-name">First Name</label>
            <input type="text" id="full-name" name="prenom" placeholder="El Maati" required >

            <label for="full-name">Last Name</label>
            <input type="text" id="full-name" name="nom" placeholder="Doukali" required >

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="name@company.com" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>

            <label for="role">Driver Type</label>
            <select id="role" name="role">
                <option value="taxi">Taxi</option>
                <option value="chauffeur">Personnel</option>
                <option value="bus">Bus</option>
            </select>

            <button type="submit" class="sign-in" style="width: 100%; padding: 14px;">Sign Up</button>
        </form>
    </div>

    <script>feather.replace();</script>
</body>
</html>