-- Schema db design gudang sederhana ( masih tahap awal )
-- db_gudang_prod (name db)
-- version 1.0.0

CREATE TABLE `gudang` (
  `id_gudang` int PRIMARY KEY AUTO_INCREMENT,
  `nama_gudang` varchar(255) UNIQUE NOT NULL,
  `id_city_gudang` int,
  `id_kapasitas_gudang` int,
  `status` ENUM ('created', 'running', 'done', 'failure') DEFAULT null,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `kapasitas_gudang` (
  `id_kapasitas_gudang` int PRIMARY KEY AUTO_INCREMENT,
  `lebar_kapasitas_gudang` float DEFAULT 0,
  `tinggi_kapasitas_gudang` float DEFAULT 0,
  `muatan_kapasitas_gudang` float DEFAULT 0,
  `jumlah_rak_kapasitas_gudang` int DEFAULT 0
);

CREATE TABLE `city_gudang` (
  `id_city_gudang` int PRIMARY KEY,
  `nama_city` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `rak_gudang` (
  `id_rak_gudang` int PRIMARY KEY AUTO_INCREMENT,
  `nomor_rak_gudang` int NOT NULL DEFAULT 0,
  `lebar_kapasitas_rak_gudang` float DEFAULT 0,
  `tinggi_kapasitas_rak_gudang` float DEFAULT 0,
  `muatan_kapasitas_rak_gudang` float DEFAULT 0,
  `jumlah_rak_kapasitas_rak_gudang` int DEFAULT 0,
  `id_gudang` int,
  `status_kapasitas_rak_gudang` ENUM ('empty', 'partial', 'full', 'overloaded', 'maintenance', 'blocked') DEFAULT 'empty'
);

CREATE TABLE `produk` (
  `produk_id` int PRIMARY KEY AUTO_INCREMENT,
  `id_nama_produk` varchar(255) NOT NULL,
  `id_jenis_produk` int,
  `id_rak_gudang` int,
  `produk_kadaluarsa` timestamp NOT NULL,
  `jumlah_stock` int DEFAULT 0
);

CREATE TABLE `jenis_produk` (
  `id_jenis_produk` int PRIMARY KEY AUTO_INCREMENT,
  `nama_jenis_produk` varchar(255) UNIQUE NOT NULL
);

ALTER TABLE `gudang` COMMENT = 'add constraint : nama_gudang';

ALTER TABLE `gudang` ADD FOREIGN KEY (`id_city_gudang`) REFERENCES `city_gudang` (`id_city_gudang`);

ALTER TABLE `gudang` ADD FOREIGN KEY (`id_kapasitas_gudang`) REFERENCES `kapasitas_gudang` (`id_kapasitas_gudang`);

ALTER TABLE `rak_gudang` ADD FOREIGN KEY (`id_gudang`) REFERENCES `gudang` (`id_gudang`);

ALTER TABLE `produk` ADD FOREIGN KEY (`id_jenis_produk`) REFERENCES `jenis_produk` (`id_jenis_produk`);

CREATE TABLE `rak_gudang_produk` (
  `rak_gudang_id_rak_gudang` int,
  `produk_id_rak_gudang` int,
  PRIMARY KEY (`rak_gudang_id_rak_gudang`, `produk_id_rak_gudang`)
);

ALTER TABLE `rak_gudang_produk` ADD FOREIGN KEY (`rak_gudang_id_rak_gudang`) REFERENCES `rak_gudang` (`id_rak_gudang`);

ALTER TABLE `rak_gudang_produk` ADD FOREIGN KEY (`produk_id_rak_gudang`) REFERENCES `produk` (`id_rak_gudang`);

ALTER TABLE `rak_gudang_produk` ADD FOREIGN KEY (`produk_id_rak_gudang`) REFERENCES `produk` (`produk_id`);


-- add new column
ALTER Table produk
ADD COLUMN nama_produk VARCHAR(255) after produk_id;
ALTER Table produk
ADD COLUMN deskpripsi_produk VARCHAR(255) after produk_kadaluarsa;

-- add index
CREATE INDEX idx_gudang ON gudang (id_gudang);
CREATE INDEX idx_rak_gudang ON rak_gudang (id_rak_gudang);
CREATE INDEX idx_produk ON produk (produk_id);

-- add fulltext search
CREATE FULLTEXT INDEX idx_nama_produk ON produk (id_nama_produk);
CREATE FULLTEXT INDEX idx_deskripsi_produk ON produk (deskpripsi_produk);

-- Add views
-- Menampilkan nama produk, nama jenis produk, rak gudang, id rak gudang, produk kadaluarsa, jumlah stock
CREATE VIEW view_produk AS
SELECT p.produk_id, p.id_nama_produk, jp.nama_jenis_produk, rg.id_rak_gudang, p.produk_kadaluarsa, p.jumlah_stock
FROM produk p
JOIN jenis_produk jp ON p.id_jenis_produk = jp.id_jenis_produk
JOIN rak_gudang rg ON p.id_rak_gudang = rg.id_rak_gudang;

-- Menampilkan informasi tentang gudang, nama, lebar, tinggi, muatan, jumlah rak, dan kota
CREATE VIEW view_gudang AS
SELECT
gg.nama_gudang, kg.lebar_kapasitas_gudang, kg.tinggi_kapasitas_gudang, kg.muatan_kapasitas_gudang, kg.jumlah_rak_kapasitas_gudang, cg.nama_city
FROM gudang gg JOIN kapasitas_gudang kg ON gg.id_kapasitas_gudang = kg.id_kapasitas_gudang JOIN city_gudang cg ON gg.id_city_gudang = cg.id_city_gudang

-- Menampilkan informasi tentang rak gudang seperti nomor, kapasitas, dan status rak
CREATE VIEW view_rak_gudang AS
SELECT rg.nomor_rak_gudang, rg.lebar_kapasitas_rak_gudang, rg.tinggi_kapasitas_rak_gudang, rg.muatan_kapasitas_rak_gudang, rg.status_kapasitas_rak_gudang
FROM rak_gudang rg

-- alter tabel
-- hapus muatan_kapasitas_gudang
-- kemudian bikin banyak nya di table rak_gudang itu ada banyak juga di produk (many to many)

-- hapus foregn_key dari tabel rak gudang dan produk
ALTER TABLE `rak_gudang_produk`
DROP FOREIGN KEY `rak_gudang_id_rak_gudang`;

ALTER TABLE `rak_gudang_produk`
DROP FOREIGN KEY `produk_id_rak_gudang`;


CREATE TABLE produk_rak_gudang_mapping (
  produk_id INT,
  rak_gudang_id INT,
  FOREIGN KEY (produk_id) REFERENCES produk(produk_id),
  FOREIGN KEY (rak_gudang_id) REFERENCES rak_gudang(id_rak_gudang)
);


CREATE TABLE gudang_rak_gudang_mapping (
  gudang_id INT,
  rak_gudang_id INT,
  FOREIGN KEY (gudang_id) REFERENCES gudang(id_gudang),
  FOREIGN KEY (rak_gudang_id) REFERENCES rak_gudang(id_rak_gudang)
);


ALTER TABLE gudang
DROP FOREIGN KEY id_city_gudang;

SHOW CREATE TABLE gudang;


CREATE TABLE `gudang` (  `id_gudang` int NOT NULL AUTO_INCREMENT,  `nama_gudang` varchar(255) NOT NULL,  `id_city_gudang` int DEFAULT NULL,  `id_kapasitas_gudang` int DEFAULT NULL,  `status` enum('created','running','done','failure') DEFAULT NULL,  `created_at` timestamp NULL DEFAULT (now()),  PRIMARY KEY (`id_gudang`),  UNIQUE KEY `nama_gudang` (`nama_gudang`),  KEY `id_city_gudang` (`id_city_gudang`),  KEY `id_kapasitas_gudang` (`id_kapasitas_gudang`),  KEY `idx_gudang` (`id_gudang`),  CONSTRAINT `gudang_ibfk_1` FOREIGN KEY (`id_city_gudang`) REFERENCES `city_gudang` (`id_city_gudang`),  CONSTRAINT `gudang_ibfk_2` FOREIGN KEY (`id_kapasitas_gudang`) REFERENCES `kapasitas_gudang` (`id_kapasitas_gudang`),  CONSTRAINT `gudang_ibfk_3` FOREIGN KEY (`id_city_gudang`) REFERENCES `city_gudang` (`id_city_gudang`),  CONSTRAINT `gudang_ibfk_4` FOREIGN KEY (`id_kapasitas_gudang`) REFERENCES `kapasitas_gudang` (`id_kapasitas_gudang`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='add constraint : nama_gudang'



ALTER TABLE gudang
DROP FOREIGN KEY gudang_ibfk_3;



SHOW CREATE TABLE rak_gudang

ALTER TABLE rak_gudang
DROP FOREIGN KEY rak_gudang_ibfk_2;



SHOW CREATE TABLE kapasitas_gudang


CREATE TABLE `kapasitas_gudang` (  `id_kapasitas_gudang` int NOT NULL AUTO_INCREMENT,  `lebar_kapasitas_gudang` float DEFAULT '0',  `tinggi_kapasitas_gudang` float DEFAULT '0',  `muatan_kapasitas_gudang` float DEFAULT '0',  `jumlah_rak_kapasitas_gudang` int DEFAULT '0',  PRIMARY KEY (`id_kapasitas_gudang`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


SHOW CREATE TABLE produk

ALTER TABLE produk
DROP FOREIGN KEY produk_ibfk_2;



ALTER TABLE gudang
DROP FOREIGN KEY gudang_ibfk_4;