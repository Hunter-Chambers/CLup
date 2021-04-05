<?php

    //$command = $command.' "{\"Hunter\": {\"contact_info\": \"email@place.com\", \"party_size\": 2, \"type\": \"scheduled\", \"visit_length\": 3}}"';
    //$command = $command.' 2045';
    //$command = $command.' True';

    $customer = $_POST['customer'];
    $visitStartBlock = $_POST['visitStartBlock'];
    $trueAdmittance = $_POST['trueAdmittance'];

    $command = escapeshellcmd('python AdmitCustomer.py');
    $command = $command.' '.$customer;
    $command = $command.' '.$visitStartBlock;
    $command = $command.' '.$trueAdmittance;

    $output = shell_exec($command);

    echo $output;

?>