-- ====================================================================
-- PROYEK DATA CLEANING & DATA ANALYSIS (SQL)
-- Dataset: Messy E-Commerce Sales Data (Kaggle)
-- Oleh: Naura Alifa
-- Peran: Data Entry & Data Cleaner
-- ====================================================================

-- 1. Mengaktifkan Database
USE ecommerce_db;

-- 2. Mengubah Tipe Data Kolom Angka (Data Definition Language)
-- Mentransformasi kolom teks bawaan impor Excel menjadi angka agar bisa dihitung secara matematis
ALTER TABLE sales_data MODIFY COLUMN Quantity INT;
ALTER TABLE sales_data MODIFY COLUMN Price DOUBLE;
ALTER TABLE sales_data MODIFY COLUMN Total DOUBLE;

-- 3. Analisis Bisnis Lanjutan (Exploratory Data Analysis)

-- Kueri 1: Menghitung Rangkuman Total Pendapatan per Kategori Produk
SELECT 
    category, 
    SUM(total) AS total_pendapatan
FROM sales_data
GROUP BY category
ORDER BY total_pendapatan DESC;

-- Kueri 2: Menyaring Transaksi yang Statusnya 'Cancelled' (Dibatalkan)
SELECT 
    ID, 
    Customer_Name, 
    Product, 
    Total, 
    Status
FROM sales_data
WHERE Status = 'Cancelled';

-- Kueri 3: Memeriksa Kategori Unik untuk Memastikan Keberhasilan Data Cleaning Teks
SELECT DISTINCT category 
FROM sales_data;
