<?php
require_once __DIR__ . '/../model/usuario.php';
session_start();

$accion = $_GET['accion'] ?? '';

if ($accion === 'login') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    $usuario = Usuario::login($username, $password);
    if ($usuario) {
        $_SESSION['usuario_id'] = $usuario['id'];
        header('Location: /DragonBallZ/tarjetas.html');
        exit;
    } else {
        header('Location: /DragonBallZ/index.html?error=credenciales_incorrectas');
        exit;
    }
}

if ($accion === 'verificar') {
    $response = ['success' => false, 'logueado' => false];
    if (isset($_SESSION['usuario_id'])) {
        $usuario = Usuario::getById($_SESSION['usuario_id']);
        if ($usuario) {
            $response = [
                'success' => true,
                'logueado' => true,
                'usuario' => $usuario
            ];
        }
    }
    header('Content-Type: application/json');
    echo json_encode($response);
    exit;
}

if ($accion === 'logout') {
    session_destroy();
    header('Location: /DragonBallZ/index.html');
    exit;
}
?>