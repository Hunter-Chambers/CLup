<?php
    require 'vars.php';

    function base64UrlEncode($text) {
        return str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($text));
    }

    function verifyJWT($jwtToken, $key) {
        $tokenParts = explode('.', $jwtToken);
        $tokenPayload = json_decode(base64_decode($tokenParts[1]), true);
        $providedSignature = $tokenParts[2];

        $expiration = $tokenPayload['exp'];
        $expectedSignature = hash_hmac('sha256', $tokenParts[0] . '.' . $tokenParts[1], $key, true);
        $expectedSignature = base64UrlEncode($expectedSignature);

        if ($expiration < time()) {
            return "Token has expired";
        }

        if ($providedSignature !== $expectedSignature) {
            return "Bad token";
        }

        return $tokenPayload;
    }

    function attemptLogin($username, $password, $userPassword, $accType) {
        if ($accType && password_verify($password, $userPassword)) {
            $header = json_encode(['typ' => 'JWT', 'alg' => 'HS256']);
            $header = base64UrlEncode($header);

            $payload = json_encode(['username' => $username, 'accType' => $accType, 'type' => 'access', 'exp' => time() + 691200]);
            $payload = base64UrlEncode($payload);

            $signature = hash_hmac('sha256', $header . '.' . $payload, $key, true);
            $signature = base64UrlEncode($signature);

            $token = $header . '.' . $payload . '.' . $signature;

            //$csrfPayload = json_encode(['username' => $username, 'accType' => $accType, 'type' => 'csrf', 'exp' => time() + 5]);
            $csrfPayload = json_encode(['username' => $username, 'accType' => $accType, 'type' => 'csrf', 'exp' => time() + 691200]);
            $csrfPayload = base64UrlEncode($csrfPayload);

            $signature = hash_hmac('sha256', $header . '.' . $csrfPayload, $key, true);
            $signature = base64UrlEncode($signature);

            $csrfToken = $header . '.' . $csrfPayload . '.' . $signature;

            setcookie('jwt', $token, time() + 691200, '', '', false, true);

            return $csrfToken;
        } else {
            return "error";
        }
    }

    function attemptLoadProfile($csrfToken) {
        $token = $_COOKIE['jwt'];
        $payload = verifyJWT($token, $key);

        $csrfPayload = verifyJWT($csrfToken, $key);

        // UNCOMMENT THE FOLLOWING LINE WHEN IN PRODUCTION
        //if ($payload['type'] === 'access' and $csrfPayload['type'] === 'csrf') {
        if ($csrfPayload['type'] === 'csrf') {
            $username = $csrfPayload['username'];
            $accType = $csrfPayload['accType'];

            if ($accType === 'customer') {
                $sql = "SELECT username, fname, lname, email, phone FROM CustomerProfiles WHERE username='$username'";
            } else {
                $sql = "SELECT username, store_name, open_time, close_time, capacity, address, city, state, zipcode
                    FROM StoreProfiles WHERE username='$username'";
            }

            return $sql;
        } else {
            return "error";
        }
    }
?>
