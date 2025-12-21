<?php
session_start();
require_once "Database.php";
require_once "User.php";

$dbObj = new Database();
$conn = $dbObj->connect();

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';
$role = $_POST['role'] ?? 'client'; // default to client

// Basic lookup in utilisateur
$stmt = $conn->prepare("SELECT * FROM utilisateur WHERE email = ?");
if (!$stmt) {
    $_SESSION['login_error'] = "DB error: " . $conn->error;
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit();
}
$stmt->bind_param('s', $email);
$stmt->execute();
$res = $stmt->get_result();
if (!$res || $res->num_rows !== 1) {
    $_SESSION['login_error'] = "Invalid email or password.";
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit();
}

$user = $res->fetch_assoc();

if (!password_verify($password, $user['mot_de_passe'])) {
    $_SESSION['login_error'] = "Invalid email or password.";
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit();
}

// Password correct — ensure role-specific record exists
if ($role === 'chauffeur') {
    $chk = $conn->prepare("SELECT id_user FROM chauffeur WHERE id_user = ?");
    $chk->bind_param('i', $user['id_user']);
    $chk->execute();
    $r = $chk->get_result();
    if (!$r || $r->num_rows === 0) {
        $_SESSION['login_error'] = "Role mismatch: No chauffeur account found.";
        header("Location: " . $_SERVER['HTTP_REFERER']);
        exit();
    }
    // success
    $_SESSION['id_user'] = $user['id_user'];
    $_SESSION['prenom'] = $user['prenom'];
    $_SESSION['role'] = 'chauffeur';
    header("Location: ../chauffeur/dashboard.php");
    exit();
}

// client role: create client row if missing, then redirect to selection
if ($role === 'client') {
    $chk = $conn->prepare("SELECT id_user FROM client WHERE id_user = ?");
    $chk->bind_param('i', $user['id_user']);
    $chk->execute();
    $r = $chk->get_result();
    if (!$r || $r->num_rows === 0) {
        // create client record
        $ins = $conn->prepare("INSERT INTO client (id_user, date_inscription, nb_trajets) VALUES (?, CURDATE(), 0)");
        if ($ins) {
            $ins->bind_param('i', $user['id_user']);
            $ins->execute();
        }
    }
    $_SESSION['id_user'] = $user['id_user'];
    $_SESSION['prenom'] = $user['prenom'];
    $_SESSION['role'] = 'client';
    header("Location: ../client_select.html");
    exit();
}

// fallback
$_SESSION['id_user'] = $user['id_user'];
$_SESSION['prenom'] = $user['prenom'];
$_SESSION['role'] = $role;
header("Location: ../client/dashboard.php");
exit();