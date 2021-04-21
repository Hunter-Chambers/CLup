<?php 
    // COMMENT OUT THESE LINES IN PRODUCTION
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    # state
    $state = $_POST['state'];
    $state = str_replace(" ", "-", $state);

    # city
    $city = $_POST['city'];
    $city = str_replace(" ", "-", $city);

    # store
    $store = $_POST['store'];
    $store = str_replace(" ", "-", $store);

    # address
    $address = $_POST['address'];
    $address = str_replace(" ", "-", $address);

    # startTime
    $startTime = $_POST['startTime'];
    $startTime = str_replace(" ", "-", $startTime);

    # endTime
    $endTime = $_POST['endTime'];
    $endTime = str_replace(" ", "-", $endTime);

    $command = escapeshellcmd('python /var/www/html/cs4391/le1010274/Schedule/ScheduleFileManager.py');


    $command = $command." ".$state;
    $command = $command." ".$city;
    $command = $command." ".$store;
    $command = $command." ".$address;
    $command = $command." ".$startTime;
    $command = $command." ".$endTime;


    //echo $command; 
    $output = shell_exec($command);
    echo $output;
?>
