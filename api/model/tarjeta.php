<?php
class Tarjeta {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function obtenerTodas() {
        $sql = "SELECT * FROM tarjetas ORDER BY id DESC";
        $result = $this->conn->query($sql);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function obtenerTarjetasUsuario($usuario_id) {
        $sql = "SELECT t.*, ut.fecha_obtencion
                FROM tarjetas t
                INNER JOIN usuario_tarjetas ut ON t.id = ut.tarjeta_id
                WHERE ut.usuario_id = ?
                ORDER BY ut.fecha_obtencion DESC";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $usuario_id);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_all(MYSQLI_ASSOC);
    }
}
