<?php
include 'db.php';
header('Content-Type: application/json');
error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    $hashed_password = MD5($password);

    if (empty($email) || empty($password)) {
        echo json_encode(value: ["message" => "Error", "error" => "Email dan password wajib diisi."]);
        exit;
    }

    $query = "SELECT user.id_user, user.username, user.status, profile.nama_lengkap
              FROM user 
              INNER JOIN profile ON user.id_profile = profile.id_profile 
              WHERE user.username = '$email' AND user.password = '$hashed_password'";

    $query2 = "SELECT registrasi.nama_lengkap
              FROM registrasi 
              WHERE registrasi.nama_lengkap = '$email' OR registrasi.email = '$email'";

    $result = mysqli_query($conn, $query);

    $result2 = mysqli_query($conn, $query2);

    if ($row = mysqli_fetch_assoc($result2)) {
        echo json_encode(["message" => "Error", "error" => "Akun belum diverifikasi admin."]);
    } else {
        if ($row = mysqli_fetch_assoc($result)) {
        if (isset($row['status']) && $row['status'] === 'aktif' ) {
            echo json_encode([
            "message" => "Success",
            "user" => $row
            ]);
        }
        else if (isset($row['status']) && $row['status'] === 'non-aktif')
        {
            echo json_encode(["message" => "Error", "error" => "Akun telah di non-aktifkan."]);
        }
    } else {
        echo json_encode(["message" => "Error", "error" => "Username atau password salah."]);
    }
    }
}
?>
