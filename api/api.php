<?php
// 🐉 DRAGON BALL Z - API PRINCIPAL 🐉

require_once __DIR__ . "/../conexion.php";

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

$requestMethod = $_SERVER["REQUEST_METHOD"];
$seccion = $_GET['seccion'] ?? '';
$accion = $_GET['accion'] ?? '';

try {
    if ($seccion === 'usuarios') {
        require_once __DIR__ . "/controller/usuarios.php";

        switch ($accion) {
            case 'login':
                if ($requestMethod === "POST") {
                    $username = $_POST['username'] ?? '';
                    $password = $_POST['password'] ?? '';
                    loginUsuario($username, $password);
                } else {
                    echo json_encode(["success" => false, "error" => "Método no permitido"]);
                }
                break;

            case 'logout':
                if ($requestMethod === "POST") {
                    session_start();
                    $_SESSION = [];
                    session_destroy();
                    echo json_encode(["success" => true, "message" => "👋 Sesión cerrada"]);
                } else {
                    echo json_encode(["success" => false, "error" => "Método no permitido"]);
                }
                break;

            case 'verificar':
                session_start();
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
                    echo json_encode(["success" => true, "logueado" => false]);
                }
                break;

            default:
                echo json_encode(["success" => false, "error" => "Acción de usuarios no válida"]);
        }
    }

    elseif ($seccion === 'tarjetas') {
        require_once __DIR__ . "/controller/tarjetas.php";

        switch ($accion) {
            case 'mis_tarjetas':
                if ($requestMethod === "GET") {
                    obtenerMisTarjetas();
                } else {
                    echo json_encode(["success" => false, "error" => "Método no permitido"]);
                }
                break;

            case 'todas':
                if ($requestMethod === "GET") {
                    obtenerTodasTarjetas();
                } else {
                    echo json_encode(["success" => false, "error" => "Método no permitido"]);
                }
                break;

            default:
                echo json_encode(["success" => false, "error" => "Acción de tarjetas no válida"]);
        }
    }

    elseif (empty($seccion)) {
        echo json_encode([
            "success" => true,
            "message" => "🐉 API Dragon Ball Z",
            "version" => "2.0.0"
        ]);
    }

    else {
        echo json_encode([
            "success" => false,
            "error" => "❌ Sección no encontrada"
        ]);
    }

} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "error" => "💥 Error interno del servidor",
        "debug" => $e->getMessage()
    ]);
}
