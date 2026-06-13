# E-Commerce Sales Data Cleaning and SQL Analysis Project

**Oleh:** Naura Alifa  
**Peran:** Data Entry & Data Cleaner  
**Peralatan yang Digunakan:** Microsoft Excel & MySQL Workbench  
**Dataset Sumber:** Kaggle (*Messy E-Commerce Sales Dataset*)

---

## 1. Deskripsi Proyek
Proyek ini bertujuan untuk merapikan, memvalidasi, dan menganalisis dataset transaksi penjualan e-commerce yang kotor (*messy data*). Data mentah diunduh dari Kaggle dalam kondisi tidak terstruktur dan memiliki banyak kesalahan input (*human error*). Proses yang dilakukan meliputi pemisahan kolom, penanganan data kosong, standardisasi teks, penghapusan data ganda di Excel, hingga pemindahan data ke MySQL untuk analisis bisnis dasar.

---

## 2. Tahap 1: Data Cleaning dengan Microsoft Excel
Di tahap ini, data mentah dibersihkan secara visual agar siap diimpor ke sistem database dengan integritas yang tinggi.

- **Masalah 1: Data Menumpuk di Satu Kolom**
    - *Kondisi Awal:* Seluruh baris data menumpuk di Kolom A karena format CSV dipisahkan oleh tanda koma (`,`).
    - *Solusi:* Menggunakan fitur **Text to Columns (Delimited by Comma)** untuk memecah data menjadi kolom yang terstruktur dari Kolom A sampai K.
- **Masalah 2: Kesalahan Tipe Data & Salah Input (Typo)**
    - *Kondisi Awal:* Kolom *Quantity* berisi teks `"four hundred"` dan `"2 abd"`. Kolom *Category* tidak konsisten (`electronic` huruf kecil dan `ELECTRONICS` huruf besar).
    - *Solusi:* Melakukan *manual data override* dengan mengubah teks menjadi angka yang valid (`400` dan `2`) serta menyeragamkan kategori menjadi `Electronics` menggunakan fitur **Find and Replace**.
- **Masalah 3: Data Kosong (Missing Values) & Angka Anomali (Minus)**
    - *Kondisi Awal:* Kolom harga (*Price*) kosong di beberapa baris produk. Terdapat nilai transaksi minus pada kuantitas dan total harga yang merusak kalkulasi.
    - *Solusi:* Mengisi harga yang kosong menggunakan pendekatan logika matematika ($\text{Price} = \text{Total} / \text{Quantity}$). Nilai minus diubah menjadi nilai positif untuk menyamakan asumsi input penjualan bersih operasional.
- **Masalah 4: Data Transaksi Ganda (Duplicate Data)**
    - *Kondisi Awal:* Ditemukan data transaksi yang terinput dua kali di bagian akhir dokumen akibat kesalahan sistem (seperti pengulangan ID 175, 142, dan 146).
    - *Solusi:* Menggunakan fitur **Remove Duplicates** berbasis seluruh kolom untuk mengeliminasi baris duplikat agar laporan keuangan tidak membengkak secara palsu.

---

## 3. Tahap 2: Implementasi dan Analisis dengan SQL
Setelah data bersih di Excel, file disimpan ke format `.csv` dan diimpor ke MySQL Workbench ke dalam database `ecommerce_db` dengan nama tabel `sales_data`.

Skrip SQL lengkap dapat dilihat pada file `cleaning_and_queries.sql` di repository ini. Berikut adalah fungsi utama kueri yang berhasil dijalankan:
1. **Mengubah Tipe Data Kolom Angka:** Menggunakan perintah `ALTER TABLE ... MODIFY COLUMN` agar kolom Quantity, Price, dan Total berubah dari tipe teks menjadi angka (`INT` & `DOUBLE`) sehingga bisa dihitung secara matematis oleh sistem database.
2. **Agregasi Data Pendapatan:** Menggunakan fungsi `SUM` dan `GROUP BY` untuk menghitung total pendapatan asli per kategori produk secara akurat dan mengurutkannya dari yang terbesar (`ORDER BY DESC`).
3. **Penyaringan Laporan Bisnis:** Menggunakan fungsi `WHERE` untuk memisahkan data transaksi sukses dengan transaksi yang dibatalkan (`Cancelled`).

---

## 4. Kesimpulan Akhir
Proyek ini berhasil mentransformasi data mentah yang tidak layak olah menjadi database korporat yang bersih, terstruktur, dan memiliki integritas data yang tinggi. Melalui kueri SQL yang telah dioptimasi, pihak manajemen perusahaan kini dapat melihat laporan pendapatan asli per kategori produk secara akurat tanpa terganggu oleh data ganda atau kesalahan ketik dari tim operasional lapangan.
