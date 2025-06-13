<?php
include 'db.php';

$id_user = intval($_GET['id_user'] ?? 0);

$sql = "SELECT b.judul, b.cover, b.penulis, r.tgl_pinjam, r.tgl_balik
FROM riwayat r
JOIN buku b ON r.kode_buku = b.kode_buku
WHERE r.id_user = ?
";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, "i", $id_user);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

$riwayat = [];
while ($row = mysqli_fetch_assoc($result)) {
    $riwayat[] = $row;
}

echo json_encode($riwayat);
?>
