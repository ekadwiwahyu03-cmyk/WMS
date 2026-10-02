# BD Gudang

**BD Gudang** adalah sistem informasi gudang dan produksi untuk perusahaan otomotif yang memproduksi alternator/dinamo mobil. Sistem ini membantu pengelolaan bahan baku, part, produk jadi, lokasi penyimpanan, transaksi stok, serta pemantauan stok minimum.

> **Status:** Project pembelajaran dan portofolio. Data part alternator yang tersedia adalah data simulasi untuk pengujian sistem.

## Fitur Utama

- Login, logout, dan session pengguna.
- Hak akses berdasarkan role pengguna.
- Dashboard ringkasan stok dan operasional gudang.
- Master data bahan baku, part, material pendukung, dan produk jadi.
- Transaksi barang masuk dan barang keluar.
- Validasi agar stok tidak menjadi negatif.
- Riwayat transaksi stok.
- Laporan stok per barang dan per lokasi gudang.
- Status stok aman dan peringatan stok yang harus dipesan ulang (*reorder*).
- Tampilan responsif untuk komputer, tablet, dan ponsel.
- Cetak laporan stok melalui browser.

## Teknologi

| Komponen | Teknologi |
|---|---|
| Backend | PHP 8+ |
| Database | MySQL / MariaDB |
| Koneksi database | PDO MySQL dan prepared statement |
| Web server lokal | Apache dari XAMPP |
| Tampilan | HTML5 dan CSS3 |
| Manajemen database | phpMyAdmin |

## Struktur Folder

Letakkan project pada folder bernama **bd_gudang**.

```text
bd_gudang/
├── assets/
│   └── style.css                 # Tampilan aplikasi
├── database/
│   └── users.sql                 # Script tabel user/login
├── auth.php                      # Session, login guard, dan role guard
├── config.php                    # Konfigurasi koneksi MySQL
├── footer.php                    # Footer aplikasi
├── header.php                    # Sidebar, topbar, dan layout utama
├── index.php                     # Dashboard
├── login.php                     # Halaman login
├── logout.php                    # Proses logout
├── products.php                  # Master data barang
├── reports.php                   # Laporan stok per lokasi
├── setup_admin.php               # Pembuatan admin pertama
├── transactions.php              # Transaksi stok masuk/keluar
├── README.md                     # Panduan penggunaan sistem
└── sample_data_dinamo_mobil.sql  # Data contoh 50 part dan 20 produk jadi
```

## Persyaratan Sistem

Sebelum menjalankan aplikasi, siapkan:

- XAMPP dengan Apache dan MySQL aktif.
- PHP 8 atau versi yang lebih baru.
- Browser modern, misalnya Google Chrome, Microsoft Edge, atau Firefox.
- phpMyAdmin.
- Database `db_gudang`.

## Instalasi

### 1. Aktifkan XAMPP

Buka **XAMPP Control Panel**, kemudian klik **Start** pada:

```text
Apache
MySQL
```

### 2. Simpan project

Extract seluruh file project ke folder berikut:

```text
C:\xampp\htdocs\bd_gudang\
```

Pastikan nama foldernya tepat:

```text
bd_gudang
```

### 3. Buat database

Buka phpMyAdmin:

```text
http://localhost/phpmyadmin
```

Buat database jika belum tersedia:

```sql
CREATE DATABASE db_gudang
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

Setelah itu, jalankan script struktur database gudang utama. Tabel minimum yang harus tersedia adalah:

```text
products
warehouses
storage_locations
stock_balances
stock_transactions
inbound_shipments
```

### 4. Import tabel user

Pilih database `db_gudang`, buka tab **Import**, pilih file berikut, lalu klik **Import/Kirim**:

```text
database/users.sql
```

File tersebut membuat tabel:

```text
users
```

### 5. Atur koneksi database

Buka file `config.php` dan periksa konfigurasi berikut:

```php
$host = 'localhost';
$db   = 'db_gudang';
$user = 'root';
$pass = '';
```

Untuk XAMPP standar, konfigurasi di atas biasanya sudah benar. Jika MySQL Anda memakai password, isi nilai `$pass`.

## Membuat Admin Pertama

Buka halaman berikut hanya untuk membuat akun admin pertama:

```text
http://localhost/bd_gudang/setup_admin.php
```

Contoh data admin:

```text
Nama lengkap : Eka Dwi Wahyudi
Username     : admin
Password     : admin12345
```

Setelah akun admin berhasil dibuat, hapus file berikut demi keamanan:

```text
C:\xampp\htdocs\bd_gudang\setup_admin.php
```

## Akses Aplikasi

Buka halaman login melalui browser:

```text
http://localhost/bd_gudang/login.php
```

Atau buka halaman utama:

```text
http://localhost/bd_gudang/
```

## Role Pengguna

| Role | Dashboard | Laporan | Master Barang | Transaksi Stok |
|---|:---:|:---:|:---:|:---:|
| `ADMIN` | Ya | Ya | Ya | Ya |
| `WAREHOUSE` | Ya | Ya | Tidak | Ya |
| `PURCHASING` | Ya | Ya | Tidak | Tidak |
| `PRODUCTION` | Ya | Ya | Tidak | Tidak |
| `SALES` | Ya | Ya | Tidak | Tidak |
| `VIEWER` | Ya | Ya | Tidak | Tidak |

## Cara Menggunakan Sistem

### Login

1. Buka `http://localhost/bd_gudang/login.php`.
2. Masukkan username dan password.
3. Jika data valid, sistem mengarahkan user ke dashboard.

### Dashboard

Dashboard menampilkan informasi berikut:

```text
Barang aktif
Stok fisik
Stok dialokasikan
Barang dalam perjalanan
Peringatan stok minimum
```

### Master Barang

Menu **Master Barang** hanya dapat dibuka oleh role `ADMIN`.

Contoh input bahan baku:

| Kolom | Contoh nilai |
|---|---|
| SKU | `RM-CU-001` |
| Nama barang | `Kawat Tembaga Email 0.90 mm` |
| Jenis barang | `RAW_MATERIAL` |
| Satuan | `KG` |
| Harga beli | `120000` |
| Harga jual | `0` |
| Stok minimum | `300` |
| Deskripsi | `Material kumparan stator` |

Jenis barang yang digunakan:

```text
RAW_MATERIAL         = Bahan baku
FINISHED_GOOD        = Produk jadi
SUPPORTING_MATERIAL  = Material pendukung
```

### Transaksi Stok

Menu **Transaksi Stok** dapat digunakan oleh role `ADMIN` dan `WAREHOUSE`.

Jenis transaksi:

```text
Barang masuk
Barang keluar
```

Contoh barang masuk dari supplier:

| Kolom | Contoh nilai |
|---|---|
| Barang | Kawat Tembaga Email 0.90 mm |
| Lokasi | Gudang Bahan Baku • RM-01-01 |
| Jumlah | `500` |
| Nomor referensi | `PO-202610-001` |
| Catatan | Penerimaan bahan baku dari supplier |

Contoh barang keluar untuk proses produksi:

| Kolom | Contoh nilai |
|---|---|
| Barang | Bearing Depan 6303 |
| Lokasi | Gudang Bahan Baku • RM-01-01 |
| Jumlah | `100` |
| Nomor referensi | `PRD-202610-001` |
| Catatan | Pemakaian untuk produksi alternator 12V |

Sistem menolak transaksi barang keluar apabila jumlah stok pada lokasi tersebut tidak mencukupi.

### Laporan Stok

Menu **Laporan Stok** menampilkan:

- Kode dan nama barang.
- Gudang dan lokasi/bin penyimpanan.
- Stok fisik.
- Stok dialokasikan.
- Stok tersedia.
- Stok minimum.
- Status `Aman` atau `Reorder`.

Rumus stok tersedia:

```text
Stok tersedia = Stok fisik - Stok dialokasikan
```

Gunakan tombol **Cetak Laporan** untuk mencetak data melalui browser.

## Import Data Contoh

File berikut berisi data simulasi untuk perusahaan pembuat alternator/dinamo mobil:

```text
sample_data_dinamo_mobil.sql
```

Isi data contoh:

- 50 material/part produksi alternator.
- 20 produk jadi alternator 12V dan 24V.
- Contoh stok tertinggi, stok aman, dan stok hampir habis.
- Struktur BOM dasar untuk produk jadi.

### Lokasi Gudang yang Dibutuhkan

Data contoh menggunakan minimal dua lokasi:

```text
location_id 1 = Gudang Bahan Baku
location_id 2 = Gudang Barang Jadi
```

Jika lokasi belum tersedia, jalankan SQL berikut:

```sql
INSERT INTO warehouses (warehouse_code, warehouse_name, address)
VALUES ('GDG-01', 'Gudang Utama Alternator', 'Bekasi, Jawa Barat');

INSERT INTO storage_locations (
    warehouse_id, zone, rack, bin_code, location_name
) VALUES
(1, 'RM', '01', 'RM-01-01', 'Gudang Bahan Baku'),
(1, 'FG', '01', 'FG-01-01', 'Gudang Barang Jadi');
```

### Cara Import

1. Buka `http://localhost/phpmyadmin`.
2. Pilih database `db_gudang`.
3. Klik menu **Import**.
4. Pilih file `sample_data_dinamo_mobil.sql`.
5. Pastikan format file `SQL`.
6. Klik **Import** atau **Kirim**.
7. Cek tabel `products` dan `stock_balances` untuk memastikan data berhasil masuk.

## Query Cek Stok

Gunakan query berikut untuk melihat stok dari jumlah terbanyak sampai stok yang perlu dilakukan pemesanan ulang:

```sql
SELECT
    p.sku,
    p.product_name,
    p.product_type,
    p.unit,
    SUM(s.qty_on_hand) AS stok_fisik,
    SUM(s.qty_reserved) AS stok_dipesan,
    p.minimum_stock,
    CASE
        WHEN SUM(s.qty_on_hand - s.qty_reserved) <= p.minimum_stock
            THEN 'HAMPIR HABIS / REORDER'
        WHEN SUM(s.qty_on_hand - s.qty_reserved) <= p.minimum_stock * 2
            THEN 'PERLU DIPANTAU'
        ELSE 'AMAN'
    END AS status_stok
FROM products p
LEFT JOIN stock_balances s ON s.product_id = p.product_id
GROUP BY p.product_id
ORDER BY stok_fisik DESC;
```

## Troubleshooting

### Koneksi database gagal

Periksa hal berikut:

- Apache dan MySQL pada XAMPP aktif.
- Nama database adalah `db_gudang`.
- Pengaturan database pada `config.php` benar.
- Ekstensi `pdo_mysql` aktif pada PHP.

### Tabel users tidak ditemukan

Import kembali file:

```text
database/users.sql
```

### Data stok tidak tampil

Pastikan tabel `stock_balances` memiliki data. Lakukan transaksi **Barang masuk** atau import file data contoh.

### Stok tidak mencukupi

Jumlah transaksi keluar lebih besar daripada stok pada lokasi yang dipilih. Tambahkan transaksi barang masuk atau pilih lokasi dengan stok yang cukup.

### Tampilan masih lama

Tekan tombol berikut di browser:

```text
Ctrl + F5
```

Hal ini memuat ulang file CSS terbaru tanpa menggunakan cache browser.

### Selalu kembali ke halaman login

Jangan membuka file PHP dengan klik langsung dari Windows. Buka melalui alamat localhost:

```text
http://localhost/bd_gudang/
```

## Pengembangan Selanjutnya

Beberapa fitur yang dapat dikembangkan:

- Manajemen user: tambah, ubah role, nonaktifkan, reset password.
- Purchase order dan penerimaan barang dari supplier.
- Production order serta pemakaian material berdasarkan BOM.
- Quality control hasil produksi dan data reject.
- Sales order, delivery order, dan pengiriman ke customer.
- Audit log untuk mencatat user pembuat transaksi.
- Barcode atau QR code untuk barang dan lokasi.
- Export laporan ke PDF dan Excel.
- Backup database rutin serta penggunaan HTTPS saat aplikasi dipublikasikan.

## Lisensi

Project **BD Gudang** dibuat untuk pembelajaran, portofolio, dan pengembangan sistem informasi gudang pada industri manufaktur otomotif.
