<?php
include 'db.php';
header('Content-Type: application/json');

if (!isset($_POST['id_user'], $_POST['kode_buku'])) {
    echo json_encode(["success" => false, "message" => "Parameter tidak lengkap."]);
    exit;
}

$id_user = intval($_POST['id_user']);
$kode_buku = $_POST['kode_buku'];
$tanggal = date('Y-m-d'); // tgl_pinjam

$sql = "SELECT harga FROM buku WHERE kode_buku=$kode_buku";
$go = mysqli_query($conn, $sql);
$data = mysqli_fetch_assoc($go);

$hargabuku = $data['harga'];

$sql = "INSERT INTO peminjaman (id_user, kode_buku, tgl_pinjam, status, harga, tenggat_balik) VALUES (?, ?, ?, 'reservasi', '$hargabuku', '')";

$stmt = mysqli_prepare($conn, $sql);
if (!$stmt) {
    echo json_encode(["success" => false, "message" => "Query gagal: " . mysqli_error($conn)]);
    exit;
}

mysqli_stmt_bind_param($stmt, "iss", $id_user, $kode_buku, $tanggal);
$success = mysqli_stmt_execute($stmt);

if ($success) {
    // kurangi stock buku
    $updateStock = "UPDATE buku SET stock = stock - 1 WHERE kode_buku = ?";
    $stmt2 = mysqli_prepare($conn, $updateStock);
    mysqli_stmt_bind_param($stmt2, "s", $kode_buku);
    mysqli_stmt_execute($stmt2);

    echo json_encode(["success" => true, "message" => "Buku berhasil dipinjam!"]);
} else {
    echo json_encode(["success" => false, "message" => "Gagal meminjam buku."]);
}

?>
