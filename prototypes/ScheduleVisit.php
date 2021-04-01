<?php

    // params
    $customer = [];
    //$queue = ..;
    $limit = 60;
    $storeCapacity = 100;
    $shoppingCustomers = [];
    $choice = null;
    //$currentTime = now..;

    $command = escapeshellcmd('C:\Users\easte\OneDrive\Documents\CLupProjectFiles\Code\prototypes\ScheduleVisit.py');
    $command = $command." Layton";
    //c/Users/easte/OneDrive/Documents/CLupProjectFiles/Code/prototypes/ScheduleVisit.py');
    echo $command;
    $output = shell_exec($command);
    echo $output;
?>