<?php
// Enable error reporting for debugging (remove in production)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header('Content-Type: application/json');

// Make sure the path to koneksi.php is correct relative to this file.
// Adjust this if your folder structure differs.
include 'db.php';

// Check if $conn is properly defined
if (!isset($conn)) {
    echo json_encode(['success' => false, 'message' => 'Database connection not established']);
    exit;
}

$id_peminjaman = $_POST['id_peminjaman'] ?? null;
$kode_buku = $_POST['kode_buku'] ?? null;

if (!$id_peminjaman) {
    echo json_encode(['success' => false, 'message' => 'ID tidak valid']);
    exit;
}

// Sanitize input to avoid SQL injection (basic)
$id_peminjaman = intval($id_peminjaman);

$query = "DELETE FROM peminjaman WHERE id_peminjaman = $id_peminjaman";

$result = mysqli_query($conn, $query);

if ($result) {
    $updateStock = "UPDATE buku SET stock = stock + 1 WHERE kode_buku = ?";
    $stmt2 = mysqli_prepare($conn, $updateStock);
    mysqli_stmt_bind_param($stmt2, "s", $kode_buku);
    mysqli_stmt_execute($stmt2);

    echo json_encode(['success' => true, 'message' => 'Pinjaman berhasil dibatalkan']);
} else {
    // Return the mysqli error for debugging
    echo json_encode(['success' => false, 'message' => 'Gagal membatalkan pinjaman: ' . mysqli_error($conn)]);
}
?>