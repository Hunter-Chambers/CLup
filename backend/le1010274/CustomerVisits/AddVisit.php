<?php 

    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    # customer username
    $username = $_POST['username'];
    $username = str_replace(" ", "-", $username);

    # visit info
    $visitInfo = $_POST['visitInfo'];
    $visitInfo = str_replace(" ", "-", $visitInfo);

    

    /* USE THIS LINE ON THOR */
    $command = escapeshellcmd('python /var/www/html/cs4391/le1010274/CustomerVisits/AddVisit.py');

    $command = $command." ".$username;
    $command = $command." ".$visitInfo;

    //echo $command;

    $output = shell_exec($command);
    echo $output;
?>
