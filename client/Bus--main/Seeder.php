<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once "Connection.php";

abstract class Seeder
{
    protected mysqli $db;
    protected string $dbName = "transport_urbain";

    public function __construct(Connection $connection)
    {
        $this->db = $connection->getConnection();
        $this->db->select_db($this->dbName);
    }


    abstract public function run(): void;


    protected function randomOffset(float $min, float $max): float
    {
        return mt_rand((int)($min*100000), (int)($max*100000)) / 100000;
    }
}
