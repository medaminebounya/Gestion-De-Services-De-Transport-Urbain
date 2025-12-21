<?php

require_once "DatabaseCore.php";

class Connection extends DatabaseCore
{
    protected function connect(): void
    {
        if ($this->dbname === null) {
          
            $this->conn = new mysqli(
                $this->servername,
                $this->username,
                $this->password
            );
        } else {
           
            $this->conn = new mysqli(
                $this->servername,
                $this->username,
                $this->password,
                $this->dbname
            );
        }

        if ($this->conn->connect_error) {
            die("Connection failed: " . $this->conn->connect_error);
        }
    }
}
