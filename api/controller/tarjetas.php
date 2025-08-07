<?php
require_once __DIR__ . '/../model/tarjeta.php';
session_start();

function obtenerMisTarjetas() {
    if (!isset($_SESSION['usuario_id'])) {
        echo json_encode([
            "success" => false,
            "requiere_login" => true,
            "error" => "Debes iniciar sesión para ver tus tarjetas"
        ]);
        return;
    }
    $tarjetas = Tarjeta::porUsuario($_SESSION['usuario_id']);
    echo json_encode([
        "success" => true,
        "tarjetas" => $tarjetas,
        "total" => count($tarjetas)
    ]);
}

function obtenerTodasTarjetas() {
    $tarjetas = Tarjeta::todas();
    echo json_encode([
        "success" => true,
        "tarjetas" => $tarjetas,
        "total" => count($tarjetas)
    ]);
}
?>