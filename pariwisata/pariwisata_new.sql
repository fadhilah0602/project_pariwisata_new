-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2024 at 07:18 PM
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
-- Database: `pariwisata_new`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `id_detail` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `status_customer` enum('Cancel','Booking') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(1, 'wisata'),
(2, 'kuliner'),
(3, 'event'),
(4, 'budaya'),
(12, 'Lorem');

-- --------------------------------------------------------

--
-- Table structure for table `pariwisata`
--

CREATE TABLE `pariwisata` (
  `id_pariwisata` int(11) NOT NULL,
  `id_kategori` int(20) NOT NULL,
  `nama_pariwisata` varchar(200) NOT NULL,
  `gambar` varchar(200) NOT NULL,
  `keterangan` text NOT NULL,
  `harga` int(50) NOT NULL,
  `lokasi` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pariwisata`
--

INSERT INTO `pariwisata` (`id_pariwisata`, `id_kategori`, `nama_pariwisata`, `gambar`, `keterangan`, `harga`, `lokasi`) VALUES
(1, 1, 'Kota Tua', 'wisata1.jpg', 'kota tua jakarta adalah sebuah bangunan peninggalan sejarah yang sampai saat ini masih banyak dikunjungi oleh wisatawan', 0, 'jakarta barat'),
(2, 1, 'Ancol', 'wisata2.jpg', 'Ancol merupakan salah pantai yang terkenal  dan menjadi kebanggan warga jakarta ', 50000, 'jakarta utara'),
(3, 2, 'Kerak Telor', 'kuliner1.jpg', 'Kerak telor merupakan makanan khas jakarta dan menjadi salah satu makana iconic yang wajib dikunjungi jika berkunjung ke kota jakarta', 20000, 'berbagai tempat di jakarta'),
(4, 2, 'Kue Lumpur', 'kuliner2.jpg', 'Kue lumpur merupakan jajanan pasar khas jakarta yang banyak dijual di berbagai tempat di kota jakarta', 2000, 'berbagai tempat di jakarta'),
(5, 3, 'Hut Kota Jakarta', 'event1.png', 'Hut kota jakarta jatuh pada tanggal 22 juni. dan di hari ini akan banyak diadakan event untuk merayakannya di berbagai sudut kota jakarta.', 0, 'berbagai kota jakarta'),
(6, 3, 'Festival Jakarta', 'event2.jpg', 'Festival jakarta merupakan salah satu event yang menjadi rutinitas kota jakarta setiap tahunnya yang diadakan di berbagai tempat setiap tahunnya.', 0, 'berbagai tempat di jakarta'),
(7, 4, 'Ondel-ondel', 'budaya1.jpg', 'Ondel-ondel merupakan budaya yang sangat identik dengan kota jakarta. dan di berbagai tempat jakarta akan menemukan ondel-ondel ini.', 0, 'berbagai tempatdi kota jakarta'),
(8, 4, 'Pencak Silat', 'budaya2.jpg', 'Pencak silat merupakan salah satu seni bela diri yang berasal dari jakarta dan identik dengan budaya betawi', 0, 'berbagai tempat di kota jakarta'),
(11, 2, 'kuliner jkt1', 'gambar/66895f72d38694.22049769.jpg', 'makanan ini terbuat dari tepung', 5000, 'Semua tempat di jakarta'),
(12, 2, 'buga', 'gambar/668ac183bbceb0.73849509.jpg', 'ftetyfhuerjf', 2000, 'jakarta'),
(15, 1, 'ragunan', 'gambar/668bf7bb76b835.93239629.jpg', 'kebun binatang', 25000, 'jakarta selatan'),
(18, 2, 'kuliner jkt1', 'gambar/668c16461b5245.36942416.jpg', 'makanan ini terbuat dari tepung', 3000, 'Semua tempat di jakarta');

-- --------------------------------------------------------

--
-- Table structure for table `penilaian`
--

CREATE TABLE `penilaian` (
  `id_penilaian` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `rating` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penilaian`
--

INSERT INTO `penilaian` (`id_penilaian`, `id_user`, `rating`) VALUES
(1, 2, 'kulinernya enak'),
(2, 2, 'ancol menarik'),
(3, 2, 'wisatanya murah\r\n'),
(4, 2, 'kue lumpur sangat enak'),
(5, 2, 'tempatnnya kurang bersih'),
(6, 2, 'wisatanya menarik'),
(7, 2, 'kurang kebersihannya'),
(8, 2, 'kerak telor rasanya enak dan sangat otentik jakarta');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_pariwisata` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `status` enum('Menunggu Pembayaran','Diterima','Cancel') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id_pesanan`, `id_user`, `id_pariwisata`, `jumlah`, `total`, `status`) VALUES
(1, 2, 2, 2, 100000, 'Diterima'),
(3, 2, 1, 2, 0, 'Menunggu Pembayaran'),
(5, 2, 3, 2, 40000, 'Menunggu Pembayaran'),
(12, 2, 2, 3, 150000, 'Menunggu Pembayaran'),
(13, 2, 2, 4, 200000, 'Menunggu Pembayaran');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `username` varchar(200) NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `jenis_kelamin` varchar(100) NOT NULL,
  `no_hp` varchar(20) NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `role` enum('Admin','Customers') NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `username`, `fullname`, `jenis_kelamin`, `no_hp`, `alamat`, `email`, `role`, `password`) VALUES
(1, 'dila edit', 'fadhilahfebrian', 'Laki-Laki', '12345', 'jakarta', 'fadhilahf@gmail.com', 'Customers', '$2y$10$nZOyC2Uaeq3fFSj6JHfkRetzWdPJ3m8/qBwOVR2M2RqxboYv3sZqa'),
(2, 'joko hadi', '123451', 'joko1@gmail.com', 'Perempuan', 'jakarta selatan', 'joko anwar1', 'Customers', '$2y$10$JqF684vtk3ck/oCscejDReU4UhQdBSjlbJviikiosHB98TWstL9Hi'),
(3, 'rahma', 'hafizah', 'Perempuan', '12345', 'jakarta', 'rahma@gmail.com', 'Customers', '$2y$10$8slaT1PPowpqXYvIN9JKGOrgi6nMHv1v4YFSQBkGTq60t/VJqSasy'),
(4, 'nadia ', 'nadia aja', 'Perempuan', '1234567', 'jkt', 'nadia@gmail.com', 'Customers', '$2y$10$eh15F9IWzVwepDeLVGt8zOd6tGd/0ASuTgCHzMzjNqNqRUcQI5KPC'),
(5, 'test12', 'test test', 'Perempuan', '12345', 'jaksel1 selatan', 'testing@gmail.com', 'Customers', '$2y$10$Sb2bIgMdCWKm5.bTnDGQQOGHELJ9b8tw4aQT6u/DmyzNBWztB3VA2'),
(7, 'admin', 'admin', 'Perempuan', '0835625721', 'jl binatu 21', 'admin@gmail.com', 'Admin', '$2y$10$oc7gown06AgV0/0tADYxi.oDqMuKsrRhc3gdNo/Y2WlXQWTGz3Jxa'),
(8, 'rania', 'rania sulistaiwati', 'Perempuan', '12345', 'jakarta', 'rania@gmail.com', 'Customers', '$2y$10$.05rPxfhCQHucmtZdugliO4smSA7VSebBomzoCXASXZ4WVaOJBYpu'),
(9, 'febrian', 'febriani fadhil', 'Perempuan', '08356257212', 'jl binatu 21', 'febrain@gmail.com', 'Customers', '$2y$10$3GTiAQl/hldFc7UrbSa5meNqqfDIaklH1UzCLq3lOkoOND7NaLCZS');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_pesanan` (`id_pesanan`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `pariwisata`
--
ALTER TABLE `pariwisata`
  ADD PRIMARY KEY (`id_pariwisata`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `penilaian`
--
ALTER TABLE `penilaian`
  ADD PRIMARY KEY (`id_penilaian`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`),
  ADD KEY `id_user` (`id_user`,`id_pariwisata`),
  ADD KEY `id_pariwisata` (`id_pariwisata`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pariwisata`
--
ALTER TABLE `pariwisata`
  MODIFY `id_pariwisata` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `penilaian`
--
ALTER TABLE `penilaian`
  MODIFY `id_penilaian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pariwisata`
--
ALTER TABLE `pariwisata`
  ADD CONSTRAINT `pariwisata_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penilaian`
--
ALTER TABLE `penilaian`
  ADD CONSTRAINT `penilaian_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`id_pariwisata`) REFERENCES `pariwisata` (`id_pariwisata`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
