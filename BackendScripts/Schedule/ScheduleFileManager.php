<?php 
    // COMMENT OUT THESE LINES IN PRODUCTION
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    # state
    $state = $_POST['state'];
    //$state = "California";

    # city
    $city = $_POST['city'];
    //$city = "Sacramento";

    # store
    $store = $_POST['store'];
    //$store = "TraderJoes";

    # address
    $address = $_POST['address'];
    //$address = "321Somewhere";
    //
    # storeUsername
    $storeUsername = $_POST['storeUsername'];
    //$storeUsername = "store1";

    # startTime
    $startTime = $_POST['startTime'];
    //$startTime = "0500";

    # endTime
    $endTime = $_POST['endTime'];
    //$endTime = "1000";

    $command = escapeshellcmd('python /var/www/html/cs4391/hc998658/Schedule/ScheduleFileManager.py');

    $command = $command." ".$state;
    $command = $command." ".$city;
    $command = $command." ".$store;
    $command = $command." ".$address;
    $command = $command." ".$storeUsername;
    $command = $command." ".$startTime;
    $command = $command." ".$endTime;
    $output = shell_exec($command);
    echo $output;
?>
