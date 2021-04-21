<?php
   header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
   header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

   $fileName = $_POST['fileName'];
   //$fileName = 'monday.json';
   $state = $_POST['state'];
   //$state = 'Texas';
   $city = $_POST['city'];
   //$city = 'Amarillo';
   $store = $_POST['store'];
   //$store = 'Rando Mart';
   $address = $_POST['address'];
   //$address = '3 Lancaster Road';

   $state = str_replace(" ", ":", $state);
   $city = str_replace(" ", ":", $city);
   $store = str_replace(" ", ":", $store);
   $address = str_replace(" ", ":", $address);
    
   $command = escapeshellcmd('python /var/www/html/cs4391/le1010274/Schedule/GetSchedule.py');
   $command = $command." ".$fileName;
   $command = $command." ".$state;
   $command = $command." ".$city;
   $command = $command." ".$store;
   $command = $command." ".$address;

   //echo $command;


   $output = shell_exec($command);
   echo $output;


?>

