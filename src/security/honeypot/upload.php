<?php
$logFile = __DIR__ . '/honeypot.log';
$ip = $_SERVER['REMOTE_ADDR'];
$time = date('Y-m-d H:i:s');
$uri = $_SERVER['REQUEST_URI'];
file_put_contents($logFile, "$ip - [$time] - Fake page accessed: $uri\n", FILE_APPEND);
echo "<h1>403 Forbidden</h1>";
?>
