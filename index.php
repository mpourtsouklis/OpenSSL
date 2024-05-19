<?php
// If username or password is wrong, display error message
if (isset($_GET['wrong']) && $_GET['wrong'] == "yes") {
        echo "<script>alert('Wrong username or password!');</script>";
}

// If the account is locked, display error message
if (isset($_GET['locked']) && $_GET['locked'] == "yes") {
        echo "<script>alert('Your account has been locked!');</script>";
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
        <title>Login | WebSec</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="style.css">
</head>

<body>
        <div class="background">
                <div class="shape"></div>
                <div class="shape"></div>
        </div>

        <form action="login.php" method="post">
                <h3>Login</h3>

                <label for="username">Username:</label>
                <input type="text" name="username" id="username" required>

                <label for="password">Password:</label>
                <input type="password" name="password" id="password" required>


                <input id="login-button" type="submit" value="Submit">
        </form>
</body>