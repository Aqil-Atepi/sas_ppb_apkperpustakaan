-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2025 at 04:34 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uas_perpus`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `kode_buku` int(11) NOT NULL,
  `cover` varchar(2083) NOT NULL,
  `judul` varchar(225) NOT NULL,
  `penulis` varchar(225) NOT NULL,
  `penerbit` varchar(225) NOT NULL,
  `katalog` varchar(225) NOT NULL,
  `stock` int(11) NOT NULL,
  `harga` decimal(20,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`kode_buku`, `cover`, `judul`, `penulis`, `penerbit`, `katalog`, `stock`, `harga`) VALUES
(1, 'https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/items/img20220830_10560995.jpg', 'Bumi', 'Tere Liye', 'Gramedia Pustaka Utama', 'Fiksi Remaja', 7, 35000.00),
(2, 'https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/items/9786027870864_dilan-1990.jpg', 'Dilan: Dia adalah Dilanku Tahun 1990', 'Pidi Baiq', 'Pastel Books', 'Novel', 8, 30000.00),
(3, 'https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/product-metas/uh0d0g8ukg.jpg', 'Ronggeng Dukuh Paruk', 'Ahmad Tohari', 'Gramedia Pustaka Utama', 'Sastra Indonesia', 7, 38000.00),
(4, 'https://image.gramedia.net/rs:fit:256:0/plain/https://cdn.gramedia.com/uploads/items/mariposa_cover_film.jpg', 'Mariposa', 'Luluk HF', 'Coconut Books', 'Fiksi Remaja', 7, 42000.00),
(5, 'https://image.gramedia.net/rs:fit:256:0/plain/https://cdn.gramedia.com/uploads/items/9786024242756_Pulang-New-C.jpg', 'Pulang', 'Leila S. Chudori', 'Kepustakaan Populer Gramedia', 'Novel', 9, 40000.00),
(7, 'https://cdn.gramedia.com/uploads/items/Kesatria._Putri__Bintang_Jatuh_Supernova.jpg', 'Supernova: Ksatria, Puteri, dan Bintang Jatuh', 'Dee Lestari', 'Truedee Books', 'Fiksi Ilmiah', 5, 45000.00),
(8, 'https://simpus.mkri.id/uploaded_files/sampul_koleksi/original/Monograf//uploadedfiles/perpustakaan/11610-11613.jpg', 'Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', 'Fiksi Remaja', 9, 37000.00),
(9, 'https://s3-ap-southeast-1.amazonaws.com/ebook-previews/1682/10530/1.jpg', 'Negeri 5 Menara', 'Ahmad Fuadi', 'Gramedia Pustaka Utama', 'Motivasi', 9, 39000.00),
(10, 'https://www.gramedia.com/blog/content/images/2025/04/ayatayatcinta.jpg', 'Ayat-Ayat Cinta', 'Habiburrahman El Shirazy', 'Republika', 'Religi', 9, 35000.00),
(11, 'https://ebooks.gramedia.com/ebook-covers/41260/general_small_covers/ID_GPU2018MTH01CILLE.jpg', 'Cantik Itu Luka', 'Eka Kurniawan', 'Gramedia Pustaka Utama', 'Sastra Indonesia', 6, 41000.00),
(12, 'https://s3-ap-southeast-1.amazonaws.com/ebook-previews/31752/100792/1.jpg', 'Perahu Kertas', 'Dee Lestari', 'Bentang Pustaka', 'Fiksi Remaja', 9, 36000.00),
(13, 'https://cdn.gramedia.com/uploads/picture_meta/2023/8/25/xwovhwc5qeirnzpzdwwvjo.jpg', 'Sukarno: Biografi Politik', 'Cindy Adams', 'Yayasan Obor Indonesia', 'Biografi', 3, 46000.00),
(14, 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1565658920i/1398034.jpg', 'Bumi Manusia', 'Pramoedya Ananta Toer', 'Hasta Mitra', 'Sastra Indonesia', 6, 43000.00),
(15, 'https://cdn.gramedia.com/uploads/items/9786022915249_orang-orang-b.jpg', 'Orang-Orang Biasa', 'Andrea Hirata', 'Bentang Pustaka', 'Fiksi', 6, 39000.00),
(16, 'https://cdn.gramedia.com/uploads/items/img20220905_11493451.jpg', 'Hujan', 'Tere Liye', 'Gramedia Pustaka Utama', 'Fiksi Remaja', 10, 35000.00);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `kode_buku` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `status` enum('dipinjam','reservasi') NOT NULL,
  `harga` decimal(20,2) DEFAULT NULL,
  `tenggat_balik` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_user`, `kode_buku`, `tgl_pinjam`, `status`, `harga`, `tenggat_balik`) VALUES
(5, 3, 3, '2025-05-25', '', 38000.00, '2025-05-27'),
(6, 4, 7, '2025-05-29', 'reservasi', 45000.00, '0000-00-00'),
(7, 4, 3, '2025-05-29', 'reservasi', 38000.00, '0000-00-00'),
(8, 4, 11, '2025-05-29', 'reservasi', 41000.00, '0000-00-00'),
(9, 4, 13, '2025-05-29', 'reservasi', 46000.00, '0000-00-00'),
(10, 4, 12, '2025-05-29', 'reservasi', 36000.00, '0000-00-00'),
(11, 4, 15, '2025-05-22', '', 39000.00, '2025-05-24'),
(12, 4, 2, '2025-05-29', 'reservasi', 30000.00, '0000-00-00'),
(13, 5, 4, '2025-05-29', 'reservasi', 42000.00, '0000-00-00'),
(14, 5, 7, '2025-05-10', 'dipinjam', 45000.00, '2025-05-21'),
(15, 5, 10, '2025-05-29', 'reservasi', 35000.00, '0000-00-00'),
(16, 5, 2, '2025-05-29', 'reservasi', 30000.00, '0000-00-00'),
(17, 5, 14, '2025-05-29', 'reservasi', 43000.00, '0000-00-00'),
(18, 5, 5, '2025-05-29', 'reservasi', 40000.00, '0000-00-00'),
(19, 6, 1, '2025-05-29', 'reservasi', 35000.00, '0000-00-00'),
(20, 6, 3, '2025-05-29', 'reservasi', 38000.00, '0000-00-00'),
(21, 6, 14, '2025-05-29', 'dipinjam', 43000.00, '2025-05-29'),
(22, 6, 4, '2025-05-29', 'reservasi', 42000.00, '0000-00-00'),
(23, 6, 15, '2025-05-29', 'dipinjam', 39000.00, '2025-05-31'),
(24, 3, 1, '2025-05-20', 'dipinjam', 35000.00, '2025-05-27'),
(25, 3, 15, '2025-05-20', 'dipinjam', 39000.00, '2025-05-29'),
(26, 3, 8, '2025-05-29', 'reservasi', 37000.00, '0000-00-00'),
(27, 3, 13, '2025-05-29', 'reservasi', 46000.00, '0000-00-00'),
(28, 3, 7, '2025-05-11', 'dipinjam', 45000.00, '2025-05-31'),
(30, 3, 4, '2025-06-13', 'reservasi', 42000.00, '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `pengembalian`
--

CREATE TABLE `pengembalian` (
  `id_pengembalian` int(11) NOT NULL,
  `id_peminjaman` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `kode_buku` int(11) NOT NULL,
  `tgl_balik` date NOT NULL,
  `harga_awal` decimal(20,2) NOT NULL,
  `denda` decimal(20,2) NOT NULL,
  `harga_akhir` decimal(20,2) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tenggat_balik` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengembalian`
--

INSERT INTO `pengembalian` (`id_pengembalian`, `id_peminjaman`, `id_user`, `kode_buku`, `tgl_balik`, `harga_awal`, `denda`, `harga_akhir`, `tgl_pinjam`, `tenggat_balik`) VALUES
(4, 5, 3, 3, '2025-05-29', 38000.00, 10000.00, 48000.00, '2025-05-25', '2025-05-27'),
(5, 11, 4, 15, '2025-05-29', 39000.00, 25000.00, 64000.00, '2025-05-22', '2025-05-24'),
(6, 25, 3, 15, '2025-05-29', 39000.00, 0.00, 39000.00, '2025-05-20', '2025-05-29');

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `id_profile` int(11) NOT NULL,
  `nama_lengkap` varchar(225) NOT NULL,
  `alamat` varchar(225) NOT NULL,
  `tpt_lahir` varchar(225) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `no_tlp` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`id_profile`, `nama_lengkap`, `alamat`, `tpt_lahir`, `tgl_lahir`, `no_tlp`, `email`) VALUES
(1, 'Rizky Pratama', 'Jl. Merpati No. 45, Bandung', 'Bandung', '1997-05-12', '081234567890', 'rizky.pratama@gmail.com'),
(2, 'Nadya Salsabila', 'Jl. Kenanga No. 20, Jakarta', 'Jakarta', '1985-08-30', '081298765432', 'nadya.salsa@yahoo.com'),
(3, 'Mohammad Aqil Athvihaz', 'Jl. Melati No. 12, Tangerang Selatan', 'Jakarta', '2007-11-27', '087775158883', 'athvi@gmail.com'),
(4, 'Wildan Izhar Al-Haqq', 'Jl. Cendana No. 78, Jakarta Selatan', 'Tangerang Selatan', '2008-02-12', '081525760935', 'wildan@gmail.com'),
(5, 'Raditya Putra Hidayat', 'Jl. Anggrek No. 9, Tangerang', 'Jakarta', '2008-12-03', '087784033387', 'radit@gmail.com'),
(6, 'Rizky Sugiharto', 'Jakarta', 'Jl. Mawar No. 33, Jakarta Utara', '2008-09-24', '085817286654', 'rizky@gmail.com'),
(7, 'Raihan Rizky Adriansyah', 'Jl. Flamboyan No. 5, Jakarta', 'Jakarta', '2008-04-29', '085714184714', 'raihan@gmail.com'),
(9, 'Sugi', 'jakarta', 'jaksel', '2001-09-11', '0889191027', 'sugilada@gmail.com'),
(10, 'athvi', 'Jakart', 'Jakarta ', '2007-09-11', '08777171837', 'aqilathvihaz@gmail.com'),
(11, 'TestAkun', 'Pondok Jaya', 'Jayaraya', '2009-10-10', '0877192892', 'testakun@gmail.com'),
(13, 'sugiharto', 'tangsel', 'tangsel', '2007-11-11', '001992029829', 'sugianto@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `registrasi`
--

CREATE TABLE `registrasi` (
  `nama_lengkap` varchar(225) NOT NULL,
  `alamat` varchar(225) NOT NULL,
  `tpt_lahir` varchar(225) NOT NULL,
  `tgl_lahir` varchar(225) NOT NULL,
  `no_tlp` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL,
  `password` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registrasi`
--

INSERT INTO `registrasi` (`nama_lengkap`, `alamat`, `tpt_lahir`, `tgl_lahir`, `no_tlp`, `email`, `password`) VALUES
('user', 'jakarta', 'jakarta', '2007-09-12', '0812928393', 'user@gmail.com', 'akunmalu'),
('user2', 'tangerang', 'tangerang', '2008-11-10', '08192929', 'user2@gmail.com', 'ayqiwbsin'),
('user3', 'Bandung', 'Bandung', '2007-11-11', '0899110092', 'user3@gmail.com', 'aokspsndon');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat`
--

CREATE TABLE `riwayat` (
  `id_riwayat` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `kode_buku` int(11) NOT NULL,
  `tgl_pinjam` date DEFAULT NULL,
  `tgl_balik` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riwayat`
--

INSERT INTO `riwayat` (`id_riwayat`, `id_user`, `kode_buku`, `tgl_pinjam`, `tgl_balik`) VALUES
(1, 3, 1, '2025-05-25', '2025-05-26'),
(2, 3, 3, '2025-05-25', NULL),
(3, 3, 3, '2025-05-25', NULL),
(4, 3, 3, '2025-05-25', NULL),
(5, 3, 3, '2025-05-25', NULL),
(6, 3, 3, '2025-05-25', '2025-05-29'),
(7, 3, 3, '2025-05-25', '2025-05-29'),
(8, 3, 3, '2025-05-25', NULL),
(9, 3, 3, '2025-05-25', NULL),
(10, 3, 3, '2025-05-25', NULL),
(11, 3, 3, '2025-05-25', NULL),
(12, 3, 3, '2025-05-25', '2025-05-29'),
(13, 3, 3, '2025-05-25', '2025-05-29'),
(14, 3, 7, '2025-05-11', NULL),
(15, 3, 7, '2025-05-11', NULL),
(16, 5, 7, '2025-05-10', NULL),
(17, 5, 7, '2025-05-10', NULL),
(18, 4, 15, '2025-05-22', NULL),
(19, 4, 15, '2025-05-22', NULL),
(20, 3, 1, '2025-05-20', NULL),
(21, 3, 1, '2025-05-20', NULL),
(22, 3, 15, '2025-05-20', NULL),
(23, 3, 15, '2025-05-20', NULL),
(24, 6, 14, '2025-05-29', NULL),
(25, 6, 14, '2025-05-29', NULL),
(26, 4, 15, '2025-05-22', '2025-05-29'),
(27, 4, 15, '2025-05-22', '2025-05-29'),
(28, 6, 15, '2025-05-29', NULL),
(29, 6, 15, '2025-05-29', NULL),
(30, 3, 15, '2025-05-20', '2025-05-29'),
(31, 3, 15, '2025-05-20', '2025-05-29'),
(32, 3, 15, '2025-05-20', NULL),
(33, 3, 15, '2025-05-20', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `id_profile` int(11) NOT NULL,
  `username` varchar(225) NOT NULL,
  `password` varchar(225) NOT NULL,
  `role` enum('Anggota','Staff','Admin') DEFAULT NULL,
  `status` enum('aktif','non-aktif') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `id_profile`, `username`, `password`, `role`, `status`) VALUES
(1, 1, 'administratif', '5021c17302653ce813fdd01ee90e923d', 'Admin', 'aktif'),
(2, 2, 'staff', 'e01c98de8a9a32bc2f75581fe6df887f', 'Staff', 'aktif'),
(3, 3, 'Athvi', 'd550ae8538947caad2a555cfdf688ac2', 'Anggota', 'aktif'),
(4, 4, 'Wildan', 'd29edea13143efbbcf62610676b8f179', 'Anggota', 'aktif'),
(5, 5, 'Radit', '5cf963d678f54ab31e650e561d93c169', 'Anggota', 'aktif'),
(6, 6, 'Rizky', 'ba9547d6e3508c58d908dce809468217', 'Anggota', 'aktif'),
(7, 7, 'Raihan', '78a69b2a867cf0fd933d27520dbbc337', 'Anggota', 'non-aktif'),
(9, 9, 'sugilada@gmail.com', '97', 'Anggota', 'non-aktif'),
(10, 10, 'aqilathvihaz@gmail.com', '202cb962ac59075b964b07152d234b70', 'Anggota', 'non-aktif'),
(11, 11, 'testakun@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Anggota', 'non-aktif'),
(15, 13, 'sugianto@gmail.com', 'db5b5d396cad6404541ffcfb8a9fd826', 'Anggota', 'aktif');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`kode_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `kode_buku` (`kode_buku`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`id_pengembalian`),
  ADD KEY `id_peminjaman` (`id_peminjaman`),
  ADD KEY `kode_buku` (`kode_buku`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`id_profile`);

--
-- Indexes for table `riwayat`
--
ALTER TABLE `riwayat`
  ADD PRIMARY KEY (`id_riwayat`),
  ADD KEY `kode_buku` (`kode_buku`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_profile` (`id_profile`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `kode_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `id_pengembalian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `profile`
--
ALTER TABLE `profile`
  MODIFY `id_profile` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `riwayat`
--
ALTER TABLE `riwayat`
  MODIFY `id_riwayat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`kode_buku`) REFERENCES `buku` (`kode_buku`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`id_peminjaman`) REFERENCES `peminjaman` (`id_peminjaman`),
  ADD CONSTRAINT `pengembalian_ibfk_2` FOREIGN KEY (`kode_buku`) REFERENCES `buku` (`kode_buku`),
  ADD CONSTRAINT `pengembalian_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `riwayat`
--
ALTER TABLE `riwayat`
  ADD CONSTRAINT `riwayat_ibfk_1` FOREIGN KEY (`kode_buku`) REFERENCES `buku` (`kode_buku`),
  ADD CONSTRAINT `riwayat_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`id_profile`) REFERENCES `profile` (`id_profile`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
