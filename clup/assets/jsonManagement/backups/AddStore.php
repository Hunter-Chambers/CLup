<?php

    // Get Post info
    $state = "California";
    //$state = "Texas";
    $city = "Los Angeles";
    //$city = "Lubbock";
    //$city = "El Paso";
    $store = "Trader Joes";
    //$store = "HEB";
    $address = "321 someWhere";
    //$address = "333 somePlace";

    // ID"s
    $stateID = null;
    $cityID = null;
    
    // file locations
    $statesJson = ".\States.json";
    $citiesJson = ".\Cities.json";
    $storesJson = ".\Stores.json";
    $addressesJson = ".\Addresses.json";

    // flags
    $statesUpdated = false;
    $citiessUpdated = false;
    $storesUpdated = false;

    // variable to hold json info
    $data = null;

    /*********************** STATES **********************/

    // load json into a dictionary
    $data = file_get_contents($statesJson); 
    $data = json_decode($data, true);


    // check to see if state already exisits
    // if not, add the state to the list
    // and increment the state ID

    // check to see if city exits
    if ( $data["states"][0] == $state ) {
        $stateExists = true;
    }
    else {
        $stateExists = array_search($state, $data["states"]);
    }


    if ( !$stateExists) {

        $statesUpdated = true;
        $data["states"][] = $state;

        $stateID = file_get_contents("StateID.txt");
        $stateID += 1;

        // write new stateID back to the file
        $stateIDfile = fopen("StateID.txt", "w") or die("Unable to open file.");
        fwrite($stateIDfile, $stateID);
        fclose($stateIDfile);

        // update States.json with new list
        $data = json_encode($data, JSON_PRETTY_PRINT);
        if(file_put_contents($statesJson, $data)) {

            print "File: ".$statesJson." Updated Successfully.";
        }
        else {
            print "ERROR: File: ".$statesJson." could not be updated.";
        }

    }

    /*********************** CITIES **********************/

    // load Cities.json
    $data = file_get_contents($citiesJson); 
    $data = json_decode($data, true);


    // set key
    $key = $state;

    // new state was added, update keys
    if( $statesUpdated ) {
        
        $citiesUpdated = true;

        // add new city

        $data[$key]["id"] = $stateID;
        $data[$key]["cities"] = array($city);

        // retrieve and update city ID
        $cityID = file_get_contents('CityID.txt');
        $cityID += 1;

        // write new cityID back to the file
        $cityIDfile = fopen("CityID.txt", "w") or die("Unable to open file.");
        fwrite($cityIDfile, $cityID);
        fclose($cityIDfile);


    }
    else {
        print "\nState already exisits\n";


        // check to see if city exits
        if ( $data[$key]["cities"][0] == $city) {
            $cityExists = true;
        }
        else {
            $cityExists = array_search($city, $data[$key]["cities"]);
        }

        
        if( $cityExists ) {
            print "\nCity already exists\n";
        }
        else{
            // if city didn't exist, add it to the list
            // and increment cityID

            $citiesUpdated = true;

            // update list
            $data[$key]["cities"][] = $city;

            // retrieve and update city ID
            $cityID = file_get_contents("CityID.txt");
            $cityID += 1;

            // write new cityID back to the file
            $cityIDfile = fopen("CityID.txt", "w") or die("Unable to open file.");
            fwrite($cityIDfile, $cityID);
            fclose($cityIDfile);

        }
    }

    // get state ID
    $stateID = $data[$key]["id"];

    // update Cities.json with new info
    $data = json_encode($data, JSON_PRETTY_PRINT);
    if(file_put_contents($citiesJson, $data)) {

        print "File: ".$citiesJson." Updated Successfully.";
    }
    else {
        print "ERROR: File: ".$citiesJson." could not be updated.";
    }



    /* ***************** STORES ****************** */


    // load Stores.json
    $data = file_get_contents($storesJson); 
    $data = json_decode($data, true);


    // assemble key
    $key = $city."-".$stateID;


    // new city was added, update keys
    if( $citiesUpdated ) {

        $storesUpdated = true;

        // add new store

        $data[$key]["id"] = $cityID;
        $data[$key]["stores"] = array($store);

    }
    else {
        print "\nCity already exisited\n";


        // check to see if store exits
        
        if ($data[$key]["stores"][0] == $store) {
            $storeExists = true;
        }
        else {
            $storeExists = array_search($store, $data[$key]["stores"]);
        }
        print "\nStore Exists: ".$storeExists."\n";
        if( $storeExists ) {
            print "\nStore already exists\n";
        }
        else{
            // if store didn't exist, add it to the list

            $storesUpdated = true;

            // update list
            $data[$key]["stores"][] = $store;

        }
    }

    // get city ID
    $cityID = $data[$key]["id"];

    // update Stores.json with new info
    $data = json_encode($data, JSON_PRETTY_PRINT);
    if(file_put_contents($storesJson, $data)) {

        print "File: ".$storesJson." Updated Successfully.";
    }
    else {
        print "ERROR: File: ".$storesJson." could not be updated.";
    }


    /* ***************** ADDRESSES ****************** */

    // load Addresses.json
    $data = file_get_contents($addressesJson); 
    $data = json_decode($data, true);


    // assemble key
    $key = $store."-".$cityID;

    // new city was added, update keys
    if( $storesUpdated ) {

        // add new address

        $data[$key]["addresses"] = array($address);

    }
    else {
        print "\nStore already exisited\n";


        // check to see if address exits
        
        if ($data[$key]["addresses"][0] == $address) {
            $addressExists = true;
        }
        else {
            $addressExists = array_search($address, $data[$key]["addresses"]);
        }
        if( $addressExists ){
            print "\nStore already exists\n";
        }
        else{
            // if address didn't exist, add it to the list

            // update list
            $data[$key]["addresses"][] = $address;

        }
    }


    // update Addresses.json with new info
    $data = json_encode($data, JSON_PRETTY_PRINT);
    if(file_put_contents($addressesJson, $data)) {

        print "File: ".$addressesJson." Updated Successfully.";
    }
    else {
        print "ERROR: File: ".$addressesJson." could not be updated.";
    }






    
?>