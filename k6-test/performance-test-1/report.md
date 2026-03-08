# 📊 Ringkasan Uji Performa (Load Test) API Kategori

### Spesifikasi

- CPU: Intel® Core™ i7-13620H Processor
- VGA: NVIDIA® GeForce RTX™ 4060 Laptop GPU 8GB GDDR6
- RAM: 6GB

### Deskripsi

Skenario pengujian menyimulasikan lonjakan akses hingga **100 *request* bersamaan** untuk mengambil data menu selama 1 menit 10 detik. Secara keseluruhan, server menunjukkan **stabilitas yang sempurna**, namun mengalami **keterlambatan respons (latency) yang kritis** di bawah beban berat.

### 🎯 1. Metrik Kelulusan Utama (Target vs Realita)

| Indikator | Hasil Pengujian | Status | Keterangan |
| :--- | :--- | :---: | :--- |
| **Error Rate** | **0.00%** (0 dari 1.787) | ✅ LULUS | Server sama sekali tidak tumbang. |
| **HTTP 200 OK** | **100%** | ✅ LULUS | Semua *request* berhasil dijawab. |
| **P95 Response**| **7.83 detik** | ❌ GAGAL | Melewati ambang batas toleransi (target: < 200ms). |
| **Avg Response**| **2.6 detik** | ⚠️ KRITIS | Rata-rata waktu tunggu sangat lambat untuk standar API. |
| **Max Response**| **10.54 detik** | ⚠️ KRITIS | Waktu tunggu terlama yang dialami pengguna. |
| **Min Response**| **25.33 ms** | ✅ LULUS | Kecepatan optimal saat server dalam kondisi sepi (VU rendah). |

### 🔍 2. Akar Masalah (Bottleneck)
Masalah murni terjadi pada antrean database akibat **N+1 Query Problem**. 
Saat aplikasi menerima ratusan *request* menu secara bersamaan, Prisma melakukan *query* berulang kali ke database untuk menarik data *parent* dan kemudian melakukan *looping* untuk memanggil *child* kategorinya secara terpisah. Server Node.js terbukti sanggup menahan beban (terlihat dari *error rate* 0%), tetapi MySQL kewalahan melayani eksekusi puluhan ribu *query* kecil secara masif dalam satu waktu, sehingga antrean memanjang dan memicu *delay* hingga 10 detik.

### 💡 3. Rekomendasi Solusi
Sebelum menambahkan *layer* infrastruktur baru seperti Redis, logika pengambilan data di level ORM/aplikasi harus disehatkan terlebih dahulu agar tidak menyiksa database.

* **Resolusi N+1 Query:** Lakukan *refactoring* pada kode Prisma Client untuk memanfaatkan *nested reads* (misal: menggunakan parameter `include` untuk merelasikan *parent* dan *children*). Ini akan memaksa database menggunakan *JOIN* dan menyelesaikan permintaan hanya dalam satu kali tarikan *query* per *request*.
* **Hasil yang Diharapkan:** Menghemat ribuan proses I/O pada MySQL, melipatgandakan *throughput* aplikasi secara drastis, dan memangkas waktu P95 dari **7.8 detik** menjadi hanya kisaran **ratusan milidetik**.