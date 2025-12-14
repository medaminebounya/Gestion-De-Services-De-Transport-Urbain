<?php
$conn = new mysqli("localhost", "root", "", "transport_urbain");
if ($conn->connect_error) {
    die("DB error");
}
?>