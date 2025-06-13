<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include 'db.php';
header('Content-Type: application/json');

if (!isset($_GET['id_user'])) {
    echo json_encode(["error" => "Parameter id_user wajib ada"]);
    exit;
}

$id_user = intval($_GET['id_user']);

$sql = "SELECT
          p.id_peminjaman,
          p.tgl_pinjam,
          b.kode_buku,
          b.cover,
          b.judul,
          b.penulis,
          b.penerbit,
          b.katalog,
          b.stock
        FROM peminjaman p
        JOIN buku b ON p.kode_buku = b.kode_buku
        LEFT JOIN pengembalian r ON r.id_peminjaman = p.id_peminjaman
        WHERE p.id_user = ?
          AND r.id_pengembalian IS NULL"; // hanya yang belum dikembalikan

$stmt = mysqli_prepare($conn, $sql);
if (!$stmt) {
    echo json_encode(["error" => "Prepare gagal: " . mysqli_error($conn)]);
    exit;
}

mysqli_stmt_bind_param($stmt, "i", $id_user);
mysqli_stmt_execute($stmt);

$result = mysqli_stmt_get_result($stmt);
if (!$result) {
    echo json_encode(["error" => "Eksekusi gagal: " . mysqli_error($conn)]);
    exit;
}

$data = mysqli_fetch_all($result, MYSQLI_ASSOC);

echo json_encode($data);
exit;
