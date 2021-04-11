<?php
    // COMMENT OUT THESE LINES IN PRODUCTION
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    require 'database.php';
    require 'tokenization.php';

    $action = $_POST['action'];

    if ($action == 'ADD_PROFILE') {
        $username = $_POST['username'];
        $password = $_POST['password'];

        $password = password_hash($password, PASSWORD_DEFAULT);

        $tablename = $_POST['tablename'];

        if ($tablename == 'CustomerProfiles') {
            $fname = $_POST['fname'];
            $lname = $_POST['lname'];
            $email = $_POST['email'];
            $phone = $_POST['phone'];

            $sql = "INSERT INTO $tablename(username, password, fname, lname, email, phone)
                    VALUES('$username', '$password', '$fname', '$lname', '$email', '$phone')";
        } else {
            $store_name = $_POST['store_name'];
            $open_time = $_POST['open_time'];
            $close_time = $_POST['close_time'];
            $capacity = $_POST['capacity'];
            $address = $_POST['address'];
            $city = $_POST['city'];
            $state = $_POST['state'];
            $zipcode = $_POST['zipcode'];

            $sql = "INSERT INTO $tablename(username, password, store_name, open_time, close_time, capacity, address, city, state, zipcode)
                    VALUES('$username', '$password', '$store_name', '$open_time', '$close_time', $capacity, '$address', '$city', '$state', '$zipcode')";
        }

        echo addRec($sql);
    }

    if ($action == 'ATTEMPT_LOGIN') {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $accType = null;

        $sql = "SELECT * FROM CustomerProfiles WHERE username='$username'";
        $result = getRec($sql);

        if ($result) {
            $accType = "customer";
            $userPassword = $result['password'];
        } else {
            $sql = "SELECT * FROM StoreProfiles WHERE username='$username'";
            $result = getRec($sql);

            if ($result) {
                $accType = "store";
                $userPassword = $result['password'];
            }
        }

        echo attemptLogin($username, $password, $userPassword, $accType);
    }

    if ($action == 'ATTEMPT_LOAD_PROFILE') {
        $csrfToken = $_SERVER['HTTP_CSRF'];

        $sql = attemptLoadProfile($csrfToken);

        if ($sql != "error") {
            $record = getRec($sql);
            echo json_encode($record);
        } else {
            echo "error";
        }
    }

    if ($action == 'ADMIT_CUSTOMER') {
        $state = $_POST['state'];
        $city = $_POST['city'];
        $store = $_POST['store'];
        $address = $_POST['address'];
        $storeUsername = $_POST['storeUsername'];
        $customer = $_POST['customer'];
        $visitStartBlock = $_POST['visitStartBlock'];
        $trueAdmittance = $_POST['trueAdmittance'];

        $command = escapeshellcmd('python3 pythonScripts/AdmitCustomer.py');
        $command = $command.' '.$state;
        $command = $command.' '.$city;
        $command = $command.' '.$store;
        $command = $command.' '.$address;
        $command = $command.' '.$storeUsername;
        $command = $command.' '.$customer;
        $command = $command.' '.$visitStartBlock;
        $command = $command.' '.$trueAdmittance;

        $output = shell_exec($command);

        echo $output;
    }

    if ($action == 'MAKE_RESERVATION') {
        $state = $_POST['state'];
        $city = $_POST['city'];
        $store = $_POST['store'];
        $address = $_POST['address'];
        $storeUsername = $_POST['storeUsername'];
        $customer = $_POST['customer'];
        $visitStartBlock = $_POST['visitStartBlock'];
        $storeCloseTime = $_POST['storeCloseTime'];
        $maxCapacity = $_POST['maxCapacity'];

        $command = escapeshellcmd('python3 pythonScripts/MakeReservation.py');
        $command = $command.' '.$state;
        $command = $command.' '.$city;
        $command = $command.' '.$store;
        $command = $command.' '.$address;
        $command = $command.' '.$storeUsername;
        $command = $command.' '.$customer;
        $command = $command.' '.$visitStartBlock;
        $command = $command.' '.$storeCloseTime;
        $command = $command.' '.$maxCapacity;

        $output = shell_exec($command);

        echo $output;
    }

    if ($action == 'MAKE_CHOICE') {
        $state = $_POST['state'];
        $city = $_POST['city'];
        $store = $_POST['store'];
        $address = $_POST['address'];
        $storeUsername = $_POST['storeUsername'];
        $customer = $_POST['customer'];
        $option = $_POST['option'];
        $fullOrScheduledVisitStart = $_POST['fullOrScheduledVisitStart'];
        $nextTimeBlock = $_POST['nextTimeBlock'];
        $endTime = $_POST['endTime'];

        $command = escapeshellcmd('python3 pythonScripts/MakeChoice.py');
        $command = $command.' '.$state;
        $command = $command.' '.$city;
        $command = $command.' '.$store;
        $command = $command.' '.$address;
        $command = $command.' '.$storeUsername;
        $command = $command.' '.$customer;
        $command = $command.' '.$option;
        $command = $command.' '.$fullOrScheduledVisitStart;
        $command = $command.' '.$nextTimeBlock;
        $command = $command.' '.$endTime;

        $output = shell_exec($command);

        echo $output;
    }

    if ($action == 'CHECK_FOR_SHOPPING_CUSTOMER') {
        $state = $_POST['state'];
        $city = $_POST['city'];
        $store = $_POST['store'];
        $address = $_POST['address'];
        $storeUsername = $_POST['storeUsername'];
        $customer = $_POST['customer'];

        $command = escapeshellcmd('python3 pythonScripts/CustomerIsShopping.py');
        $command = $command.' '.$state;
        $command = $command.' '.$city;
        $command = $command.' '.$store;
        $command = $command.' '.$address;
        $command = $command.' '.$storeUsername;
        $command = $command.' '.$customer;
        $command = $command.' '.$visitStartBlock;

        $output = shell_exec($command);

        echo $output;
    }

    if ($action == 'RELEASE_CUSTOMER') {
        $state = $_POST['state'];
        $city = $_POST['city'];
        $store = $_POST['store'];
        $address = $_POST['address'];
        $storeUsername = $_POST['storeUsername'];
        $customer = $_POST['customer'];
        $visitStartBlock = $_POST['visitStartBlock'];
        $storeCloseTime = $_POST['storeCloseTime'];
        $maxCapacity = $_POST['maxCapacity'];

        $command = escapeshellcmd('python3 pythonScripts/ReleaseCustomer.py');
        $command = $command.' '.$state;
        $command = $command.' '.$city;
        $command = $command.' '.$store;
        $command = $command.' '.$address;
        $command = $command.' '.$storeUsername;
        $command = $command.' '.$customer;
        $command = $command.' '.$visitStartBlock;
        $command = $command.' '.$storeCloseTime;
        $command = $command.' '.$maxCapacity;

        $output = shell_exec($command);

        echo $output;
    }

    if ($action == 'CHECK_TEMP_STORAGE') {
        $state = $_POST['state'];
        $city = $_POST['city'];
        $store = $_POST['store'];
        $address = $_POST['address'];
        $storeUsername = $_POST['storeUsername'];
        $customer = $_POST['customer'];

        $command = escapeshellcmd('python3 pythonScripts/CheckTempStorage.py');
        $command = $command.' '.$state;
        $command = $command.' '.$city;
        $command = $command.' '.$store;
        $command = $command.' '.$address;
        $command = $command.' '.$storeUsername;
        $command = $command.' '.$customer;

        $output = shell_exec($command);

        echo $output;
    }
?>