// Make sure that you fill in the empty fields for the reCAPTCHA secret key, your email address and the redirect URL
// If you do not know what these are, it might be better to use WordPress instead

// You can customize and add lines to the error message to your liking

<?php

    // CONTACT FORM - VERIFICATION & php.mail SEND SCRIPT
    // COPYRIGHT © JOERY ZEGERS
    // DO NOT DISTRIBUTE THIS SCRIPT WITHOUT APPROVAL FROM THE OWNER

    if (isset($_POST['g-recaptcha-response'])) {
        $captcha = $_POST['g-recaptcha-response'];
    }

    if (!$captcha) {
        echo '<title>Error while sending form</title>';
        echo 'The information you submitted does not appear to be correct<br/><br/>';
        echo 'The captcha you entered does not appear to be valid<br><br>';
        echo 'Please return and confirm you filled in the correct information<br><br>';
        exit;
    }

    $response = file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=__your secret key here__&response=" . $captcha . "&remoteip=" . $_SERVER['REMOTE_ADDR']);

    if ($response.success == false) {
        echo '<title>Error while sending form</title>';
        echo 'The information you submitted does not appear to be correct<br/><br/>';
        echo 'The captcha you entered does not appear to be valid<br><br>';
        echo 'Please return and confirm you filled in the correct information<br><br>';
        exit;
    }

    if ($response.success == true) {
        $email_to = "__your email address here__";
        $email_subject = "Contact Form";

        function died($error) {
            echo '<title>Error while sending form</title>';
            echo 'The information you submitted does not appear to be correct<br/><br/>';
            echo $error."";
            echo 'Please return and confirm you filled in the correct information<br><br>';
            die();
        }

        if (!isset($_POST['name']) || !isset($_POST['email']) || !isset($_POST['message'])) {
            died('');
        }

        $name = $_POST['name'];
        $email = $_POST['email'];
        $message = $_POST['message'];
        $error_message = "";
        $string_exp = "/^[A-Za-z .'-]+$/";

        if(!preg_match($string_exp,$name)) {
            $error_message .= 'The name you entered does not appear to be valid<br/>Do not use any numbers or special characters, only A-Z, a-z, spaces, dots and dashes are allowed<br/><br/>';
        }

        $email_exp = '/^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,18}$/';

        if(!preg_match($email_exp,$email)) {
            $error_message .= 'The email address you entered does not appear to be valid<br/>Make sure that you are using a correct email address (example@domain.com)<br/><br/>';
        }

        if(strlen($message) < 10) {
            $error_message .= 'The message you entered is too short, it has to be at least 10 characters long<br/><br/>';
        }

        if(strlen($error_message) > 0) {
            died($error_message);
        }

        $email_message = "The following message was received from the contact form on your website\n\n";

        function clean_string($string) {
            $bad = array("content-type","bcc:","to:","cc:","href");
            return str_replace($bad,"",$string);
        }

        $email_message .= "Name: ".clean_string($name)."\n";
        $email_message .= "Email: ".clean_string($email)."\n";
        $email_message .= "Message: \n\n".clean_string($message)."\n";
        $headers = 'From: ' .$email. "\r\n" . 'Reply-To: ' .$email. "\r\n" . 'X-Mailer: PHP/' . phpversion();
        @mail($email_to, $email_subject, $email_message, $headers);
        ?><meta http-equiv="refresh" content="0; url=__where to go after success__"><?php
    }

die();

?>
