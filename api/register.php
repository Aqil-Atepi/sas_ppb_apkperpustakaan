<?php
include 'db.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = $_POST['nama_lengkap'] ?? '';
    $alamat = $_POST['alamat'] ?? '';
    $tptlahir = $_POST['tpt_lahir'] ?? '';
    $tgllahir = $_POST['tgl_lahir'] ?? '';
    $notlp = $_POST['no_tlp'] ?? '';
    $email = $_POST['email'] ?? '';
    $pass = $_POST['pass'] ?? '';

    if (empty($nama) || empty($email)) {
        echo json_encode(["message" => "Error", "error" => "Nama dan email wajib diisi"]);
        exit;
    }

    $query = "INSERT INTO registrasi (nama_lengkap, alamat, tpt_lahir, tgl_lahir, no_tlp, email, password)
              VALUES ('$nama', '$alamat', '$tptlahir', '$tgllahir', '$notlp', '$email', '$pass')";

    $go = mysqli_query($conn, $query);

    if ($go) {
        echo json_encode(["message" => "Success"]);
    } else {
        echo json_encode(["message" => "Error", "error" => mysqli_error($conn)]);
    }
} else {
    echo json_encode(["message" => "Error", "error" => "Request harus POST"]);
}
?>
