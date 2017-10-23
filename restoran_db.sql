-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 23 Okt 2017 pada 12.10
-- Versi Server: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restoran_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `belanja`
--

CREATE TABLE `belanja` (
  `id_belanja` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `total` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `histori_makanan`
--

CREATE TABLE `histori_makanan` (
  `no_nota` int(11) NOT NULL,
  `makanan` varchar(30) NOT NULL,
  `harga` int(11) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `histori_nota`
--

CREATE TABLE `histori_nota` (
  `no_nota` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `no_meja` int(2) NOT NULL,
  `tax` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kadaluarsa`
--

CREATE TABLE `kadaluarsa` (
  `id_makanan` int(11) NOT NULL,
  `tgl_kadaluarsa` date NOT NULL,
  `stok` int(11) NOT NULL,
  `status` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `makanan`
--

CREATE TABLE `makanan` (
  `id_makanan` int(11) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `deskripsi` varchar(60) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `makanan`
--

INSERT INTO `makanan` (`id_makanan`, `nama`, `deskripsi`, `harga_beli`, `harga_jual`) VALUES
(2, 'Mie Goreng', 'Ditambah dengan telor dadar', 16000, 21000),
(3, 'Nasi Kuning', 'Enak Sekali', 9000, 13000),
(4, 'Ikan Asin', 'Khas Pangandaran', 10000, 25000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `meja`
--

CREATE TABLE `meja` (
  `no_meja` int(3) NOT NULL,
  `seat` int(2) NOT NULL,
  `status` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nota`
--

CREATE TABLE `nota` (
  `no_nota` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `tax` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `no_meja` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rincian_belanja`
--

CREATE TABLE `rincian_belanja` (
  `id_makanan` int(11) NOT NULL,
  `id_belanja` int(11) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rincian_jajan`
--

CREATE TABLE `rincian_jajan` (
  `no_nota` int(11) NOT NULL,
  `id_makanan` int(11) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `belanja`
--
ALTER TABLE `belanja`
  ADD PRIMARY KEY (`id_belanja`);

--
-- Indexes for table `histori_makanan`
--
ALTER TABLE `histori_makanan`
  ADD KEY `no_nota` (`no_nota`);

--
-- Indexes for table `histori_nota`
--
ALTER TABLE `histori_nota`
  ADD PRIMARY KEY (`no_nota`);

--
-- Indexes for table `kadaluarsa`
--
ALTER TABLE `kadaluarsa`
  ADD KEY `id_makanan` (`id_makanan`);

--
-- Indexes for table `makanan`
--
ALTER TABLE `makanan`
  ADD PRIMARY KEY (`id_makanan`);

--
-- Indexes for table `meja`
--
ALTER TABLE `meja`
  ADD PRIMARY KEY (`no_meja`);

--
-- Indexes for table `nota`
--
ALTER TABLE `nota`
  ADD PRIMARY KEY (`no_nota`),
  ADD KEY `no_meja` (`no_meja`);

--
-- Indexes for table `rincian_belanja`
--
ALTER TABLE `rincian_belanja`
  ADD PRIMARY KEY (`id_makanan`,`id_belanja`),
  ADD KEY `id_belanja` (`id_belanja`);

--
-- Indexes for table `rincian_jajan`
--
ALTER TABLE `rincian_jajan`
  ADD PRIMARY KEY (`no_nota`,`id_makanan`),
  ADD KEY `id_makanan` (`id_makanan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `nota`
--
ALTER TABLE `nota`
  MODIFY `no_nota` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `histori_makanan`
--
ALTER TABLE `histori_makanan`
  ADD CONSTRAINT `histori_makanan_ibfk_1` FOREIGN KEY (`no_nota`) REFERENCES `histori_nota` (`no_nota`);

--
-- Ketidakleluasaan untuk tabel `kadaluarsa`
--
ALTER TABLE `kadaluarsa`
  ADD CONSTRAINT `kadaluarsa_ibfk_1` FOREIGN KEY (`id_makanan`) REFERENCES `makanan` (`id_makanan`);

--
-- Ketidakleluasaan untuk tabel `nota`
--
ALTER TABLE `nota`
  ADD CONSTRAINT `nota_ibfk_1` FOREIGN KEY (`no_meja`) REFERENCES `meja` (`no_meja`);

--
-- Ketidakleluasaan untuk tabel `rincian_belanja`
--
ALTER TABLE `rincian_belanja`
  ADD CONSTRAINT `rincian_belanja_ibfk_1` FOREIGN KEY (`id_makanan`) REFERENCES `makanan` (`id_makanan`),
  ADD CONSTRAINT `rincian_belanja_ibfk_2` FOREIGN KEY (`id_belanja`) REFERENCES `belanja` (`id_belanja`);

--
-- Ketidakleluasaan untuk tabel `rincian_jajan`
--
ALTER TABLE `rincian_jajan`
  ADD CONSTRAINT `rincian_jajan_ibfk_1` FOREIGN KEY (`no_nota`) REFERENCES `nota` (`no_nota`),
  ADD CONSTRAINT `rincian_jajan_ibfk_2` FOREIGN KEY (`id_makanan`) REFERENCES `makanan` (`id_makanan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
