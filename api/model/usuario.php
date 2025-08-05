<?php
require_once __DIR__ . '/../conexion.php';

class Usuario {
    public static function login($username, $password) {
        global $conn;
        $username = $conn->real_escape_string($username);
        $password_md5 = md5($password);
        $sql = "SELECT * FROM usuarios WHERE username='$username' AND password='$password_md5' LIMIT 1";
        $result = $conn->query($sql);
        if ($result && $result->num_rows === 1) {
            return $result->fetch_assoc();
        }
        return false;
    }

    public static function getById($id) {
        global $conn;
        $id = intval($id);
        $sql = "SELECT id, username, email, nombre_completo, nivel_poder, raza, planeta_origen FROM usuarios WHERE id=$id LIMIT 1";
        $result = $conn->query($sql);
        if ($result && $result->num_rows === 1) {
            return $result->fetch_assoc();
        }
        return false;
    }
}
?>