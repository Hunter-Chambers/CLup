<?php
   header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
   header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

   # state
   $state = $_POST['state'];
   $state = str_replace(" ", "-", $state);
   //$state = 'OH';

   # city
   $city = $_POST['city'];
   $city = str_replace(" ", "-", $city);
   //$city = 'Cleveland';

   # store
   $store = $_POST['store'];
   $store = str_replace(" ", "-", $store);
   //$store = 'Amigos';

   # address
   $address = $_POST['address'];
   $address = str_replace(" ", "-", $address);
   //$address = '444 whatNow';



    
   $command = escapeshellcmd('python /var/www/html/cs4391/le1010274/StoreSearch/AddStore.py');
   $command = $command." ".$state;
   $command = $command." ".$city;
   $command = $command." ".$store;
   $command = $command." ".$address;

   //echo $command;

   $output = shell_exec($command);
   echo $output;


?>
