# 🚀 Laporan Peningkatan Performa (Improvement Report) API Kategori: Resolusi N+1 Query

### Spesifikasi Pengujian
- **CPU:** Intel® Core™ i7-13620H Processor
- **VGA:** NVIDIA® GeForce RTX™ 4060 Laptop GPU 8GB GDDR6
- **RAM:** 6GB
- **Skenario:** 100 Virtual Users (VU) bersamaan selama 1 menit 10 detik.

### 📋 Ringkasan Eksekutif
Telah dilakukan *refactoring* pada *layer* database (Prisma ORM) untuk menyelesaikan masalah **N+1 Query** saat memuat relasi *parent-child* pada data kategori menu. Optimasi ini berdampak sangat radikal, **melipatgandakan daya tampung server hingga hampir 19x lipat** dan memangkas waktu tunggu pengguna (*latency*) hingga **97%**.

---

### 📊 Perbandingan Metrik (Before vs After)

| Indikator Performa | Sebelum Optimasi (N+1) | Sesudah Optimasi (Optimized) | 📈 Tingkat Peningkatan |
| :--- | :--- | :--- | :--- |
| **Total Request Sukses** | 1.787 request | **33.888 request** | 🔥 **Naik ~1.896% (19x lipat)** |
| **Throughput (Kecepatan)**| ~25 req / detik | **~484 req / detik** | 🚀 **Naik ~1.836%** |
| **P95 Response Time** | 7.83 detik | **223.7 ms** | ⚡ **Lebih Cepat 97.1%** |
| **Rata-rata Response** | 2.6 detik | **132.02 ms** | ⚡ **Lebih Cepat 94.9%** |
| **Max Response (Terburuk)**| 10.54 detik | **415.72 ms** | 🛡️ **Lebih Cepat 96%** |
| **Min Response (Tercepat)**| 25.33 ms | **0.5 ms (509 µs)** | 🏎️ **Lebih Cepat 98%** |
| **Error Rate** | 0.00% | **0.00%** | Tetap Sempurna (Stabil) |
| **Data Terkirim ke Klien**| 9.4 MB | **249 MB** | 📦 Aliran data lebih lancar |

---

### 🔍 Analisis Peningkatan (Key Takeaways)

1. **Efisiensi Database yang Radikal:** Dengan mengatasi N+1 Query (menggunakan *nested reads* / *JOIN* yang benar pada Prisma), aplikasi tidak lagi membombardir MySQL dengan ribuan *query* kecil secara beruntun. Hasilnya, *bottleneck* antrean di sisi database lenyap seketika. Node.js bisa mengeksekusi logika jauh lebih bebas, terbukti dari *Min Response* yang menembus angka setengah milidetik (**0.5 ms**).

2. **Skalabilitas Kapasitas Menakjubkan:** Dalam durasi waktu yang persis sama (70 detik) dan beban yang sama (100 VU), aplikasi yang tadinya hanya mampu melayani 1.787 pelanggan kini sanggup melayani **33.888 pelanggan** tanpa ada satu pun *request* yang *error*.

3. **Pengalaman Pengguna (User Experience):** Pengguna aplikasi Point of Sale (POS) yang sebelumnya harus menunggu menu *loading* hingga nyaris 8 detik saat jam sibuk, kini akan melihat layar mem