<?php
require_once __DIR__ . '/../../conexion.php';

class Tarjeta {
    public static function todas() {
        global $conn;
        $sql = "SELECT * FROM tarjetas ORDER BY nivel_poder DESC";
        $result = $conn->query($sql);
        $tarjetas = [];
        while ($row = $result->fetch_assoc()) {
            $tarjetas[] = $row;
        }
        return $tarjetas;
    }

    public static function porUsuario($usuario_id) {
        global $conn;
        $usuario_id = intval($usuario_id);
        $sql = "SELECT t.*, ut.nivel_carta, ut.experiencia_carta, ut.favorita
                FROM usuario_tarjetas ut
                INNER JOIN tarjetas t ON ut.tarjeta_id = t.id
                WHERE ut.usuario_id = $usuario_id
                ORDER BY ut.favorita DESC, ut.nivel_carta DESC";
        $result = $conn->query($sql);
        $tarjetas = [];
        while ($row = $result->fetch_assoc()) {
            $tarjetas[] = $row;
        }
        return $tarjetas;
    }
}
?>