<?php
require_once __DIR__ . "/../model/usuario.php";
require_once __DIR__ . "/../../conexion.php";

function loginUsuario($username, $password) {
    session_start();
    $db = conectarDB();
    $usuarioModel = new Usuario($db);

    $usuario = $usuarioModel->login($username, $password);

    if ($usuario) {
        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['username'] = $usuario['username'];

        echo json_encode([
            "success" => true,
            "message" => "🚀 Bienvenido",
            "usuario" => [
                "id" => $usuario['id'],
                "username" => $usuario['username']
            ]
        ]);
    } else {
        echo json_encode(["success" => false, "error" => "Credenciales inválidas"]);
    }
}

?>
