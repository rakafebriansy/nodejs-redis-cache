# 📊 Ringkasan Uji Performa (Load Test) API Kategori - Tahap 2 (Optimasi N+1 Query)

Skenario pengujian kembali menyimulasikan lonjakan akses hingga **100 Virtual Users (VU)** selama 1 menit 10 detik. Pada pengujian kedua ini, aplikasi telah dioptimasi secara arsitektural dengan **menghapus kelemahan N+1 Query** pada sisi ORM (Prisma) dan Database. Hasilnya menunjukkan peningkatan *throughput* (daya tampung) yang sangat radikal, melonjak dari hanya 1.787 request menjadi **33.888 request**!

### 🎯 1. Metrik Kelulusan Utama (Target vs Realita)

| Indikator | Hasil Pengujian | Status | Keterangan |
| :--- | :--- | :---: | :--- |
| **Error Rate** | **0.00%** (0 dari 33.888) | ✅ LULUS | Server sangat tangguh melayani puluhan ribu *request*. |
| **HTTP 200 OK** | **100%** | ✅ LULUS | Semua *request* berhasil dijawab dengan data valid. |
| **P95 Response**| **223.7 ms** | ❌ GAGAL (Toleransi) | Hanya meleset 23.7 ms dari target (< 200ms). Turun drastis dari 7.8 detik! |
| **Avg Response**| **132.02 ms** | ✅ LULUS | Rata-rata respons sangat cepat berkat *query* yang efisien. |
| **Max Response**| **415.72 ms** | ✅ LULUS | Waktu terlama menurun tajam dari 10 detik menjadi kurang dari setengah detik. |
| **Min Response**| **0.5 ms (509 µs)** | ✅ LULUS | Kecepatan optimal eksekusi Node.js tanpa hambatan I/O *database*. |

### 🔍 2. Analisis Perubahan (Dampak Resolusi N+1 Query)
Penghapusan masalah N+1 memberikan napas lega yang luar biasa bagi MySQL dan Node.js di aplikasi POS ini.
* **Database Tidak Lagi Disiksa:** Sebelumnya, untuk memuat 10 kategori beserta anak-anaknya, ORM mungkin melakukan belasan hingga puluhan *query* terpisah secara beruntun per 1 *request*. Dengan perbaikan N+1, *query* disatukan menjadi jauh lebih sedikit dan efisien.
* **Daya Tampung Meroket:** Karena *bottleneck* antrean *query* hilang, sistem sekarang mampu memproses **~484 request per detik** (sebelumnya hanya ~25 req/sec). 
* **Beban Jaringan:** Node.js berhasil mengirimkan data JSON sebesar **249 MB** dalam waktu 70 detik (3.6 MB/s). Keterlambatan P95 (223.7 ms) kemungkinan besar dipengaruhi oleh waktu *parsing* dan transfer *payload* data JSON yang besar ke 100 *user* secara bersamaan.

### 💡 3. Rekomendasi Lanjutan
Kode pada level *database* sudah sangat optimal. Jika target P95 < 200ms adalah harga mati, maka inilah saat yang paling tepat untuk melakukan optimasi tahap 3:

* **Implementasi Redis Cache:** Karena *query* databasenya sudah efisien, hasil dari *query* tersebut bisa langsung disimpan di Redis. Ini akan memangkas proses komputasi Prisma secara keseluruhan dan berpotensi menurunkan P95 hingga di bawah 50ms.