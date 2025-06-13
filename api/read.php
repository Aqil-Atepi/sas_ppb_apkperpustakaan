<?php
include 'db.php';
header('Content-Type: application/json');

if (!isset($_GET['id_user'])) {
    echo json_encode(["error" => "Parameter id_user tidak ditemukan."]);
    exit;
}

$id_user = intval($_GET['id_user']);

$sql = "
SELECT b.*
FROM buku AS b
WHERE b.stock > 0
  AND NOT EXISTS (
        SELECT 1
        FROM peminjaman p
        LEFT JOIN pengembalian r
               ON r.id_peminjaman = p.id_peminjaman
        WHERE p.kode_buku = b.kode_buku
          AND p.id_user   = ?
          AND r.id_pengembalian IS NULL
  )
";

$stmt = mysqli_prepare($conn, $sql);
if (!$stmt) {
    echo json_encode(["error" => "Prepare gagal: " . mysqli_error($conn)]);
    exit;
}

mysqli_stmt_bind_param($stmt, "i", $id_user);
mysqli_stmt_execute($stmt);

$result = mysqli_stmt_get_result($stmt);
if (!$result) {
    echo json_encode(["error" => "Gagal mengambil hasil query: " . mysqli_error($conn)]);
    exit;
}

echo json_encode(mysqli_fetch_all($result, MYSQLI_ASSOC));
?>
