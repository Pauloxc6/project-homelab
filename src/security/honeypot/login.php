<?php
$logFile = __DIR__ . '/honeypot.log';
$ip = $_SERVER['REMOTE_ADDR'];
$time = date('Y-m-d H:i:s');
$user = $_POST['user'] ?? 'empty';
$pass = $_POST['pass'] ?? 'empty';

$log = "$ip - [$time] - LOGIN attempt - user: $user, pass: $pass\n";
file_put_contents($logFile, $log, FILE_APPEND);

echo "<h1>Access Denied</h1>";
?>
