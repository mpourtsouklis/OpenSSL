<?php
// Predefined variables
$database = "GDPR"; 
$user = "<username>";
$password = "<password>";
$loginAttempts = 5;

// Connect to the database
try {
        $database = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
} catch (PDOException $e) {
        print "Error!: " . $e->getMessage() . "<br/>";
        die();
}

// Dissable emulated prepared statements
$database->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

// When user submits the login form
if (isset($_POST['username']) && isset($_POST['password'])) {
        // Cache form's data
        $username = $_POST['username'];
        $password = $_POST['password'];

        // Get database's user with the given username
        $sql = 'SELECT * FROM GDPR.users WHERE username=?';
        $query = $database->prepare($sql);
        $query->bindValue(1, $username, PDO::PARAM_STR);
        $query->execute();
        $user = $query->fetch(PDO::FETCH_ASSOC);

        // If the user's account is locked
        if ($user['locked'] == 1) {
                // Display error message
                header("Location: index.php?locked=yes");
                exit();
        } else {
                // Else, if the hash with salt of the given password matches with the database user's password
                if (password_verify($password, $user['password'])) {
                        // Set user's login attempts to 0
                        $sql = "UPDATE GDPR.logging SET tries=0 WHERE username='$username'";
                        $database->query($sql);

                        // Go to the ΗelloWorld page
                        header("Location: ΗelloWorld.php");
                        exit();
                } else {
                        // Else, increase user's login attempts by 1
                        $sql = "UPDATE GDPR.logging SET tries=tries+1 WHERE username='$username'";
                        $database->query($sql);

                        // Get user's login attempts
                        $sql = "SELECT * FROM GDPR.logging WHERE username=?";
                        $query = $database->prepare($sql);
                        $query->bindValue(1, $username, PDO::PARAM_STR);
                        $query->execute();
                        $user = $query->fetch(PDO::FETCH_ASSOC);

                        // If user's login attempts equal to the login attemps allowed
                        if ($user['tries'] == $loginAttempts) {
                                // Lock the user's account
                                $sql = "UPDATE GDPR.users SET locked=1 WHERE username='$username'";
                                $database->query($sql);
                        }

                        // Show error message
                        header("location: index.php?wrong=yes");
                }
        }
}
?>