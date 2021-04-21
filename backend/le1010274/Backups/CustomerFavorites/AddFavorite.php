<?php 

    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    # customer username
    $username = $_POST['username'];
    $username = str_replace(" ", "-", $username);

    # store Info
    $storeInfo = $_POST['storeInfo'];
    $storeInfo = str_replace(" ", "-", $storeInfo);

    

    /* USE THIS LINE ON THOR */
    $command = escapeshellcmd('python /var/www/html/cs4391/le1010274/CustomerFavorites/AddFavorite.py');

    $command = $command." ".$username;
    $command = $command." ".$storeInfo;

    $output = shell_exec($command);
    echo $output;
?>
