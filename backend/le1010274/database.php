<?php
    function getRec($sql) {
        require 'vars.php';

        $conn = new mysqli($host, $dbUsername, $dbPassword, $dbName);

        if ($conn->connect_error) {
            die("Connection Failed: " . $conn->connect_error);
            return "error";
        }

        $record = mysqli_fetch_assoc($conn->query($sql));

        $conn->close();

        return $record;
    }

    function addRec($sql) {
        require 'vars.php';

        $conn = new mysqli($host, $dbUsername, $dbPassword, $dbName);

        if ($conn->connect_error) {
            die("Connection Failed: " . $conn->connect_error);
            return "error";
        }

        $result = $conn->query($sql);

        $conn->close();

        if ($result === TRUE) {
            return "success";
        } else {
            return "error";
        }
    }
?>
