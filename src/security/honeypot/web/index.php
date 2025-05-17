<?php
// Secure path to store logs (outside of public_html, if possible)
$logFile = "logs/honeypot_log.txt";

// Getting visitor data
$ip = $_SERVER['REMOTE_ADDR'] ?? 'Unknown';
$userAgent = $_SERVER['HTTP_USER_AGENT'] ?? 'Unknown';
$headers = json_encode(getallheaders(), JSON_PRETTY_PRINT);

// Function to get IP geolocation
function getIPInfo($ip) {
$url = "http://ip-api.com/json/$ip";
$response = file_get_contents($url);
return json_decode($response, true);
}

// Get IP information
$info = getIPInfo($ip);
$country = $info['country'] ?? 'Unknown';
$city = $info['city'] ?? 'Unknown';
$isp = $info['isp'] ?? 'Unknown';
$isProxy = $info['proxy'] ?? false;
$isVPN = $info['hosting'] ?? false;

// Count how many times this IP has accessed the honeypot
$logContent = file_exists($logFile) ? file_get_contents($logFile) : "";
$attemptCount = substr_count($logContent, $ip);

// Create log string
$logEntry = "Page: /wp-admin.php " . date("Y-m-d H:i:s") . " - IP: $ip - Country: $country - City: $city - ISP: $isp - Proxy: " . ($isProxy ? "YES" : "NO") . " - VPN: " . ($isVPN ? "YES" : "NO") . " - Accesses: $attemptCount - Agent: $userAgent - Headers: $headers\n";

// Save log to file
file_put_contents($logFile, $logEntry, FILE_APPEND);

die("Access denied.");
?>