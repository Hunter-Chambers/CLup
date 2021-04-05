<?php

    $command = escapeshellcmd('python3 ReleaseCustomer.py');

    $command = $command.' TX';
    $command = $command.' Amarillo';
    $command = $command.' "Rando Mart"';
    $command = $command.' "3 Lancaster Road"';
    $command = $command.' store_345';
    $command = $command.' "{\"Hunter\": {\"contact_info\": \"email@place.com\", \"party_size\": 2, \"type\": \"walk_ins\", \"visit_length\": 3}}"';
    $command = $command.' 1700';
    $command = $command.' 2300';
    $command = $command.' 100';

    $output = shell_exec($command);

    echo($output);
?>