<?php
require_once __DIR__ . '/../model/tarjeta.php';
session_start();

$accion = $_GET['accion'] ?? '';

if ($accion === 'todas') {
    $tarjetas = Tarjeta::todas();
    echo json_encode([
        'success' => true,
        'tarjetas' => $tarjetas,
        'total' => count($tarjetas)
    ]);
    exit;
}

if ($accion === 'mis_tarjetas') {
    if (!isset($_SESSION['usuario_id'])) {
        echo json_encode([
            'success' => false,
            'requiere_login' => true,
            'error' => 'Debes iniciar sesión para ver tus tarjetas'
        ]);
        exit;
    }
    $tarjetas = Tarjeta::porUsuario($_SESSION['usuario_id']);
    echo json_encode([
        'success' => true,
        'tarjetas' => $tarjetas,
        'total' => count($tarjetas)
    ]);
    exit;
}
?>