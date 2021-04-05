<?php

    $command = escapeshellcmd('python3 MakeChoice.py');

    $command = $command.' TX';
    $command = $command.' Amarillo';
    $command = $command.' "Rando Mart"';
    $command = $command.' "3 Lancaster Road"';
    $command = $command.' store_345';
    $command = $command.' "{\"Hunter\": {\"contact_info\": \"email@place.com\", \"party_size\": 2, \"type\": \"walk_ins\", \"visit_length\": 3}}"';
    $command = $command.' B';
    $command = $command.' False';
    $command = $command.' 1530';
    $command = $command.' 1630';

    $output = shell_exec($command);

    echo($output);
?>