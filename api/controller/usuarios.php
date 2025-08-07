<?php
require_once __DIR__ . '/../model/usuario.php';
session_start();

function Login($username, $password) {
    $usuario = Usuario::login($username, $password);
    if ($usuario) {
        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['username'] = $usuario['username'];
        echo json_encode([
            "success" => true,
            "mensaje" => "Login exitoso",
            "usuario" => [
                "id" => $usuario['id'],
                "username" => $usuario['username'],
                "nombre_completo" => $usuario['nombre_completo']
            ]
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "error" => "Credenciales incorrectas"
        ]);
    }
}

function Logout() {
    session_destroy();
    echo json_encode([
        "success" => true,
        "mensaje" => "Sesión cerrada"
    ]);
}

function VerificarSesion() {
    if (isset($_SESSION['usuario_id'])) {
        echo json_encode([
            "success" => true,
            "logueado" => true,
            "usuario" => [
                "id" => $_SESSION['usuario_id'],
                "username" => $_SESSION['username']
            ]
        ]);
    } else {
        echo json_encode([
            "success" => true,
            "logueado" => false
        ]);
    }
}
?>