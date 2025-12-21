<?php

abstract class DatabaseCore
{
    protected string $servername = "localhost";
    protected string $username = "root";
    protected string $password = "";
    protected ?string $dbname;
    protected mysqli $conn;

    public function __construct(?string $dbname = null)
    {
        $this->dbname = $dbname;
        $this->connect();
    }


    abstract protected function connect(): void;

    public function getConnection(): mysqli
    {
        return $this->conn;
    }
}
