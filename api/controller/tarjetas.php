<?php
session_start();
require_once "/../../conexion.php";
require_once "/../model/tarjeta.php";

$db = conectarDB();
$tarjetaModel = new Tarjeta($db);

if ($_GET['accion'] === 'mis_tarjetas') {
    if (!isset($_SESSION['usuario_id'])) {
        echo json_encode(["error" => "No hay sesión activa"]);
        exit();
    }
    $tarjetas = $tarjetaModel->obtenerTarjetasUsuario($_SESSION['usuario_id']);
    echo json_encode($tarjetas);
}

if ($_GET['accion'] === 'todas') {
    $tarjetas = $tarjetaModel->obtenerTodas();
    echo json_encode($tarjetas);
}
