# 🏆 Laporan Komprehensif Evolusi Performa API Kategori (Stage 1 vs 2 vs 3)

### Spesifikasi Pengujian
- **CPU:** Intel® Core™ i7-13620H Processor
- **VGA:** NVIDIA® GeForce RTX™ 4060 Laptop GPU 8GB GDDR6
- **RAM:** 6GB
- **Skenario:** 100 Virtual Users (VU) bersamaan selama 1 menit 10 detik.

### 📋 Ringkasan Eksekutif
Laporan ini mendokumentasikan perjalanan optimasi performa (*performance tuning*) pada *endpoint* `GET /api/categories`. Pengujian dilakukan dalam tiga tahap arsitektural yang berbeda untuk mengukur dampak nyata dari setiap perbaikan kode terhadap daya tampung (*throughput*) dan waktu tunggu (*latency*) server. 

Dari sistem awal yang kewalahan merespons dalam 7 detik, API kini telah berevolusi menjadi sistem berkinerja tinggi yang merespons secara instan dalam 31 milidetik.

---

### 📊 Perbandingan Metrik Keseluruhan (3 Fase Evolusi)

| Indikator Performa | Tahap 1 (Baseline: N+1 Issue) | Tahap 2 (Optimasi: Fix N+1) | Tahap 3 (Final: Redis Cache) | 🚀 Total Peningkatan (T1 vs T3) |
| :--- | :--- | :--- | :--- | :--- |
| **Total Request Sukses** | 1.787 request | 33.888 request | **216.198 request** | 🔥 **Naik 120x Lipat (+11.998%)** |
| **Throughput (Kecepatan)**| ~25 req / detik | ~484 req / detik | **~3.088 req / detik** | 🚀 **Naik 120x Lipat** |
| **P95 Response Time** | 7.83 detik *(Gagal)* | 223.7 ms *(Hampir Lulus)* | **31.57 ms *(LULUS)*** | ⚡ **Lebih Cepat 99.6%** |
| **Rata-rata Response** | 2.6 detik | 132.02 ms | **20.57 ms** | ⚡ **Lebih Cepat 99.2%** |
| **Max Response (Terburuk)**| 10.54 detik | 415.72 ms | **75.29 ms** | 🛡️ **Lebih Cepat 99.2%** |
| **Min Response (Tercepat)**| 25.33 ms | 0.5 ms | **~0.0 ms** | 🏎️ **Maksimal Kecepatan Hardware** |
| **Data Terkirim ke Klien**| 9.4 MB | 249 MB | **1.6 GB** | 📦 Aliran data termaksimalkan |

---

### 🔍 Analisis Evolusi Arsitektur

#### 🔴 Tahap 1: Kondisi Awal (The Bottleneck)
Pada tahap awal, ORM melakukan eksekusi *query* yang tidak efisien (*N+1 Query Problem*). MySQL dipaksa merespons ribuan *query* kecil secara beruntun hanya untuk merakit satu *response* JSON. Akibatnya, server hanya sanggup melayani 25 *request* per detik, dan 95% pengguna harus menunggu hingga **7.8 detik**.

#### 🟡 Tahap 2: Efisiensi Database (The Database Fix)
Dengan memperbaiki relasi *query* (menggunakan *JOIN*/*nested reads* di Prisma), beban I/O MySQL turun drastis. MySQL kini bisa mengirimkan data utuh dalam satu tarikan. Hasilnya sangat signifikan: waktu tunggu anjlok menjadi **223 ms** dan daya tampung server melonjak 19x lipat menjadi hampir 34 ribu *request*.

#### 🟢 Tahap 3: Bypass Memori (The Ultimate Scale)
Meskipun database sudah efisien, komputasi berulang untuk data statis tetap membuang-buang sumber daya. Dengan memasukkan **Redis**, Node.js berhenti menanyakan data ke MySQL. Kategori menu ditarik langsung dari RAM dengan kecepatan cahaya. Hasil akhir: P95 menyentuh angka **31.57 ms** dan server berhasil melibas **216.198 request** tanpa satu pun *error*.

### 💡 Kesimpulan Akhir
Kombinasi antara **Kode Database yang Sehat (Bebas N+1)** dan **Strategi Caching yang Tepat (Redis)** adalah formula absolut untuk skalabilitas tingkat *Enterprise*. Endpoint `/api/categories` kini tidak hanya memenuhi target Service Level Agreement (SLA < 200ms), tetapi menghancurkannya dengan performa yang jauh melampaui ekspektasi awal.