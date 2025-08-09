<?php
session_start();
require_once "../conexion.php";
require_once "../model/usuario.php";

$db = conectarDB();
$usuarioModel = new Usuario($db);

if ($_GET['accion'] === 'login') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    $usuario = $usuarioModel->login($username, $password);

    if ($usuario) {
        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['username'] = $usuario['username'];
        header("Location: ../tarjetas.html");
        exit();
    } else {
        echo json_encode(["error" => "Credenciales inválidas"]);
    }
}
