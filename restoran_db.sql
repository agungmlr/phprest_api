/*
SQLyog Ultimate v12.4.1 (64 bit)
MySQL - 10.1.26-MariaDB : Database - restoran_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`restoran_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `restoran_db`;

/*Table structure for table `belanja` */

DROP TABLE IF EXISTS `belanja`;

CREATE TABLE `belanja` (
  `id_belanja` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `total` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_belanja`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `belanja` */

/*Table structure for table `histori_makanan` */

DROP TABLE IF EXISTS `histori_makanan`;

CREATE TABLE `histori_makanan` (
  `no_nota` int(11) NOT NULL,
  `makanan` varchar(30) NOT NULL,
  `harga` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  KEY `no_nota` (`no_nota`),
  CONSTRAINT `histori_makanan_ibfk_1` FOREIGN KEY (`no_nota`) REFERENCES `histori_nota` (`no_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `histori_makanan` */

/*Table structure for table `histori_nota` */

DROP TABLE IF EXISTS `histori_nota`;

CREATE TABLE `histori_nota` (
  `no_nota` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `no_meja` int(2) NOT NULL,
  `tax` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  PRIMARY KEY (`no_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `histori_nota` */

/*Table structure for table `kadaluarsa` */

DROP TABLE IF EXISTS `kadaluarsa`;

CREATE TABLE `kadaluarsa` (
  `id_makanan` int(11) NOT NULL,
  `tgl_kadaluarsa` date NOT NULL,
  `stok` int(11) NOT NULL,
  `status` int(1) DEFAULT NULL,
  KEY `id_makanan` (`id_makanan`),
  CONSTRAINT `kadaluarsa_ibfk_1` FOREIGN KEY (`id_makanan`) REFERENCES `makanan` (`id_makanan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `kadaluarsa` */

/*Table structure for table `makanan` */

DROP TABLE IF EXISTS `makanan`;

CREATE TABLE `makanan` (
  `id_makanan` int(11) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `deskripsi` varchar(60) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL,
  PRIMARY KEY (`id_makanan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `makanan` */

insert  into `makanan`(`id_makanan`,`nama`,`deskripsi`,`harga_beli`,`harga_jual`) values 
(2,'Mie Goreng','Ditambah dengan telor dadar',16000,21000),
(3,'Nasi Kuning','Enak Sekali',9000,13000),
(4,'Ikan Asin','Khas Pangandaran',10000,25000);

/*Table structure for table `meja` */

DROP TABLE IF EXISTS `meja`;

CREATE TABLE `meja` (
  `no_meja` int(3) NOT NULL,
  `seat` int(2) NOT NULL,
  `status` int(1) DEFAULT NULL,
  PRIMARY KEY (`no_meja`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `meja` */

/*Table structure for table `nota` */

DROP TABLE IF EXISTS `nota`;

CREATE TABLE `nota` (
  `no_nota` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `tax` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `no_meja` int(2) NOT NULL,
  PRIMARY KEY (`no_nota`),
  KEY `no_meja` (`no_meja`),
  CONSTRAINT `nota_ibfk_1` FOREIGN KEY (`no_meja`) REFERENCES `meja` (`no_meja`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `nota` */

/*Table structure for table `rincian_belanja` */

DROP TABLE IF EXISTS `rincian_belanja`;

CREATE TABLE `rincian_belanja` (
  `id_makanan` int(11) NOT NULL,
  `id_belanja` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  PRIMARY KEY (`id_makanan`,`id_belanja`),
  KEY `id_belanja` (`id_belanja`),
  CONSTRAINT `rincian_belanja_ibfk_1` FOREIGN KEY (`id_makanan`) REFERENCES `makanan` (`id_makanan`),
  CONSTRAINT `rincian_belanja_ibfk_2` FOREIGN KEY (`id_belanja`) REFERENCES `belanja` (`id_belanja`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rincian_belanja` */

/*Table structure for table `rincian_jajan` */

DROP TABLE IF EXISTS `rincian_jajan`;

CREATE TABLE `rincian_jajan` (
  `no_nota` int(11) NOT NULL,
  `id_makanan` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  PRIMARY KEY (`no_nota`,`id_makanan`),
  KEY `id_makanan` (`id_makanan`),
  CONSTRAINT `rincian_jajan_ibfk_1` FOREIGN KEY (`no_nota`) REFERENCES `nota` (`no_nota`),
  CONSTRAINT `rincian_jajan_ibfk_2` FOREIGN KEY (`id_makanan`) REFERENCES `makanan` (`id_makanan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rincian_jajan` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
