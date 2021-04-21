<?php 

    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    # customer username
    $username = $_POST['username'];
    $username = str_replace(" ", "", $username);


    /* USE THIS LINE ON THOR */
    $command = escapeshellcmd('python /var/www/html/cs4391/le1010274/CustomerVisits/GetVisits.py');

    $command = $command." ".$username;

    $output = shell_exec($command);
    echo $output;
?>
