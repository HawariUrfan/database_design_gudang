-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_gudang_prod
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `city_gudang`
--

DROP TABLE IF EXISTS `city_gudang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_gudang` (
  `id_city_gudang` int NOT NULL,
  `nama_city` varchar(255) NOT NULL,
  PRIMARY KEY (`id_city_gudang`),
  UNIQUE KEY `nama_city` (`nama_city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_gudang`
--

LOCK TABLES `city_gudang` WRITE;
/*!40000 ALTER TABLE `city_gudang` DISABLE KEYS */;
/*!40000 ALTER TABLE `city_gudang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gudang`
--

DROP TABLE IF EXISTS `gudang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gudang` (
  `id_gudang` int NOT NULL AUTO_INCREMENT,
  `nama_gudang` varchar(255) NOT NULL,
  `id_city_gudang` int DEFAULT NULL,
  `id_kapasitas_gudang` int DEFAULT NULL,
  `status` enum('created','running','done','failure') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  PRIMARY KEY (`id_gudang`),
  UNIQUE KEY `nama_gudang` (`nama_gudang`),
  KEY `id_city_gudang` (`id_city_gudang`),
  KEY `id_kapasitas_gudang` (`id_kapasitas_gudang`),
  KEY `idx_gudang` (`id_gudang`),
  CONSTRAINT `gudang_ibfk_1` FOREIGN KEY (`id_city_gudang`) REFERENCES `city_gudang` (`id_city_gudang`),
  CONSTRAINT `gudang_ibfk_2` FOREIGN KEY (`id_kapasitas_gudang`) REFERENCES `kapasitas_gudang` (`id_kapasitas_gudang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='add constraint : nama_gudang';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gudang`
--

LOCK TABLES `gudang` WRITE;
/*!40000 ALTER TABLE `gudang` DISABLE KEYS */;
/*!40000 ALTER TABLE `gudang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gudang_rak_gudang_mapping`
--

DROP TABLE IF EXISTS `gudang_rak_gudang_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gudang_rak_gudang_mapping` (
  `gudang_id` int DEFAULT NULL,
  `rak_gudang_id` int DEFAULT NULL,
  KEY `gudang_id` (`gudang_id`),
  KEY `rak_gudang_id` (`rak_gudang_id`),
  CONSTRAINT `gudang_rak_gudang_mapping_ibfk_1` FOREIGN KEY (`gudang_id`) REFERENCES `gudang` (`id_gudang`),
  CONSTRAINT `gudang_rak_gudang_mapping_ibfk_2` FOREIGN KEY (`rak_gudang_id`) REFERENCES `rak_gudang` (`id_rak_gudang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gudang_rak_gudang_mapping`
--

LOCK TABLES `gudang_rak_gudang_mapping` WRITE;
/*!40000 ALTER TABLE `gudang_rak_gudang_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `gudang_rak_gudang_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jenis_produk`
--

DROP TABLE IF EXISTS `jenis_produk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jenis_produk` (
  `id_jenis_produk` int NOT NULL AUTO_INCREMENT,
  `nama_jenis_produk` varchar(255) NOT NULL,
  PRIMARY KEY (`id_jenis_produk`),
  UNIQUE KEY `nama_jenis_produk` (`nama_jenis_produk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenis_produk`
--

LOCK TABLES `jenis_produk` WRITE;
/*!40000 ALTER TABLE `jenis_produk` DISABLE KEYS */;
/*!40000 ALTER TABLE `jenis_produk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kapasitas_gudang`
--

DROP TABLE IF EXISTS `kapasitas_gudang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kapasitas_gudang` (
  `id_kapasitas_gudang` int NOT NULL AUTO_INCREMENT,
  `lebar_kapasitas_gudang` float DEFAULT '0',
  `tinggi_kapasitas_gudang` float DEFAULT '0',
  `muatan_kapasitas_gudang` float DEFAULT '0',
  `jumlah_rak_kapasitas_gudang` int DEFAULT '0',
  PRIMARY KEY (`id_kapasitas_gudang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kapasitas_gudang`
--

LOCK TABLES `kapasitas_gudang` WRITE;
/*!40000 ALTER TABLE `kapasitas_gudang` DISABLE KEYS */;
/*!40000 ALTER TABLE `kapasitas_gudang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produk`
--

DROP TABLE IF EXISTS `produk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produk` (
  `produk_id` int NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(255) DEFAULT NULL,
  `id_nama_produk` varchar(255) NOT NULL,
  `id_jenis_produk` int DEFAULT NULL,
  `produk_kadaluarsa` timestamp NOT NULL,
  `deskpripsi_produk` varchar(255) DEFAULT NULL,
  `jumlah_stock` int DEFAULT '0',
  PRIMARY KEY (`produk_id`),
  KEY `id_jenis_produk` (`id_jenis_produk`),
  KEY `idx_produk` (`produk_id`),
  FULLTEXT KEY `idx_nama_produk` (`id_nama_produk`),
  FULLTEXT KEY `idx_deskripsi_produk` (`deskpripsi_produk`),
  CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`id_jenis_produk`) REFERENCES `jenis_produk` (`id_jenis_produk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produk`
--

LOCK TABLES `produk` WRITE;
/*!40000 ALTER TABLE `produk` DISABLE KEYS */;
/*!40000 ALTER TABLE `produk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produk_rak_gudang_mapping`
--

DROP TABLE IF EXISTS `produk_rak_gudang_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produk_rak_gudang_mapping` (
  `produk_id` int DEFAULT NULL,
  `rak_gudang_id` int DEFAULT NULL,
  KEY `produk_id` (`produk_id`),
  KEY `rak_gudang_id` (`rak_gudang_id`),
  CONSTRAINT `produk_rak_gudang_mapping_ibfk_1` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`),
  CONSTRAINT `produk_rak_gudang_mapping_ibfk_2` FOREIGN KEY (`rak_gudang_id`) REFERENCES `rak_gudang` (`id_rak_gudang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produk_rak_gudang_mapping`
--

LOCK TABLES `produk_rak_gudang_mapping` WRITE;
/*!40000 ALTER TABLE `produk_rak_gudang_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `produk_rak_gudang_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rak_gudang`
--

DROP TABLE IF EXISTS `rak_gudang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rak_gudang` (
  `id_rak_gudang` int NOT NULL AUTO_INCREMENT,
  `nomor_rak_gudang` int NOT NULL DEFAULT '0',
  `lebar_kapasitas_rak_gudang` float DEFAULT '0',
  `tinggi_kapasitas_rak_gudang` float DEFAULT '0',
  `muatan_kapasitas_rak_gudang` float DEFAULT '0',
  `jumlah_rak_kapasitas_rak_gudang` int DEFAULT '0',
  `id_gudang` int DEFAULT NULL,
  `status_kapasitas_rak_gudang` enum('empty','partial','full','overloaded','maintenance','blocked') DEFAULT 'empty',
  PRIMARY KEY (`id_rak_gudang`),
  KEY `id_gudang` (`id_gudang`),
  KEY `idx_rak_gudang` (`id_rak_gudang`),
  CONSTRAINT `rak_gudang_ibfk_1` FOREIGN KEY (`id_gudang`) REFERENCES `gudang` (`id_gudang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rak_gudang`
--

LOCK TABLES `rak_gudang` WRITE;
/*!40000 ALTER TABLE `rak_gudang` DISABLE KEYS */;
/*!40000 ALTER TABLE `rak_gudang` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-03 16:01:00
