<?php

    $command = escapeshellcmd('python AdmitCustomer.py');
    $command = $command.' "{\"Hunter\": {\"contact_info\": \"email@place.com\", \"party_size\": 2, \"type\": \"scheduled\", \"visit_length\": 3}}"';
    $command = $command.' 2045';
    $command = $command.' True';

    $output = shell_exec($command);

    echo $output;

?>