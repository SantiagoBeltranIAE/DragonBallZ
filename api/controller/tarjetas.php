<?php
require_once __DIR__ . "/../../conexion.php";
require_once __DIR__ . "/../model/tarjeta.php";

function obtenerMisTarjetas() {
    session_start();
    if (!isset($_SESSION['usuario_id'])) {
        echo json_encode([
            "success" => false, 
            "error" => "🔒 No hay sesión activa",
            "requiere_login" => true
        ]);
        return;
    }
    $db = conectarDB();
    $tarjetaModel = new Tarjeta($db);  
    $tarjetas = $tarjetaModel->obtenerTarjetasUsuario($_SESSION['usuario_id']);
    echo json_encode([
        "success" => true,
        "tarjetas" => $tarjetas,
        "total" => count($tarjetas)
    ]);
}
function obtenerTodasTarjetas() {
    $db = conectarDB();
    $tarjetaModel = new Tarjeta($db);
    $tarjetas = $tarjetaModel->obtenerTodas();
    echo json_encode([
        "success" => true,
        "tarjetas" => $tarjetas,
        "total" => count($tarjetas)
    ]);
}


?>
