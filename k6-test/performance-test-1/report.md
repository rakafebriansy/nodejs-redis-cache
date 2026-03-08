# 📊 Ringkasan Uji Performa (Load Test) API Kategori
commit c9c03032d5098f3c05ba1437ac23b422ac150bc6

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
Masalah murni terjadi pada **Antrean Database (MySQL/Prisma)**. 
Saat aplikasi POS menerima ratusan *request* menu secara bersamaan, Prisma harus melakukan *query* berulang kali ke database untuk menarik data *parent* dan *child* kategori. Server Node.js terbukti sanggup menahan beban (terlihat dari *error rate* 0%), tetapi MySQL kewalahan melayani permintaan pembacaan data yang masif dalam satu waktu, sehingga menciptakan antrean respons hingga 10 detik.

### 💡 3. Rekomendasi Solusi
Mengingat data kategori menu ini statis dan jarang diubah, melakukan *query* ke MySQL untuk setiap *request* sangat membebani sistem.

* **Implementasi Caching dengan Redis:** Simpan struktur JSON kategori menu ke dalam memori RAM (Redis) pada tarikan pertama.
* **Hasil yang Diharapkan:** 1.786 *request* berikutnya akan dilayani langsung oleh Redis tanpa menyentuh MySQL. Ini diproyeksikan akan memangkas waktu P95 dari **7.8 detik** menjadi di bawah **50 ms**.