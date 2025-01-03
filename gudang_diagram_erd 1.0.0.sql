-- Schema db design gudang sederhana ( masih tahap awal )



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
