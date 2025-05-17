<?php
date_default_timezone_set("UTC");
$logFile = __DIR__ . '/honeypot.log';
$ip = $_SERVER['REMOTE_ADDR'];
$uri = $_SERVER['REQUEST_URI'];
$time = date('Y-m-d H:i:s');
$data = "$ip - [$time] - $uri\n";

file_put_contents($logFile, $data, FILE_APPEND);
?>

<!DOCTYPE html>
<html>
<head>
  <title>Admin Panel</title>
</head>
<body>
  <h1>Admin Login</h1>
  <form action="login.php" method="post">
    <label>Username:</label><br>
    <input type="text" name="user"><br><br>
    <label>Password:</label><br>
    <input type="password" name="pass"><br><br>
    <input type="submit" value="Login">
  </form>
</body>
</html>
