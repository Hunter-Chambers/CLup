<?php
   header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
   header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

   $fileName = $_POST['fileName'];
   $menu = $_POST['menu'];
   $needID = $_POST['needID'];

   //$fileName = 'Cities.json';
   //$menu = 'New Mexico';
   //$needID = 'true';
   $menu = str_replace(" ", ":", $menu);
    
   $command = escapeshellcmd('python /var/www/html/cs4391/le1010274/StoreSearch/GetStore.py');
   $command = $command." ".$fileName;
   $command = $command." ".$menu;
   $command = $command." ".$needID;

   $output = shell_exec($command);
   echo $output;


?>

