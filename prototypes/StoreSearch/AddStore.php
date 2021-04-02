<?php 
    # state
    //$state = _POST['state'];
    $state = "California";
    # city
    //$city = _POST['city'];
    $city = "Sacramento";
    # store
    //$store = _POST['store'];
    $store = "TraderJoes";
    # address
    //$address = _POST['address'];
    $address = "321Somewhere";
    # storeUsername

    /* USE THIS LINE ON THOR */
    //$command = escapeshellcmd('/var/www/html/cs4391/le1010274/StoreSearch/AddStore.py');
    $command = escapeshellcmd('C:\Users\easte\OneDrive\Documents\CLupProjectFiles\Code\prototypes\StoreSearch\AddStore.py');

    $command = $command." ".$state;
    $command = $command." ".$city;
    $command = $command." ".$store;
    $command = $command." ".$address;
    $output = shell_exec($command);
    echo $output;
?>