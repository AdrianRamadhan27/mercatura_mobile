[![Staging](https://github.com/AdrianRamadhan27/mercatura_mobile/actions/workflows/staging.yml/badge.svg?branch=staging)](https://github.com/AdrianRamadhan27/mercatura_mobile/actions/workflows/staging.yml)

[![Pre-Release](https://github.com/AdrianRamadhan27/mercatura_mobile/actions/workflows/pre-release.yml/badge.svg?branch=main)](https://github.com/AdrianRamadhan27/mercatura_mobile/actions/workflows/pre-release.yml)

[![Release](https://github.com/AdrianRamadhan27/mercatura_mobile/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/AdrianRamadhan27/mercatura_mobile/actions/workflows/release.yml)

[![Build status](https://build.appcenter.ms/v0.1/apps/bd9aa5e5-8f5a-463b-9eb5-a901b274c59b/branches/main/badge)](https://appcenter.ms)

# Tugas Kelompok Akhir Semester PBP - Mercatura

Nama anggota kelompok:
- Aidah Novallia Putri - 2106653400
- Katrina Gisella Sembiring - 2106707826
- Majid Rajendra Rahmat - 2106752382
- Raden Dhaneswara Timur Bhamakrti Rasendriya - 2106750710
- Raden Mohamad Adrian Ramadhan Hendar Wibawa - 2106750540

## 📱 Publikasi Aplikasi di App Center
[Mercatura](https://install.appcenter.ms/orgs/mercatura_mobile/apps/mercatura/distribution_groups/public)

## 🌐 Nama Aplikasi dan Link ke Sumber Web Service
[Mercatura](https://mercatura-id.up.railway.app)


## 🖼 Latar belakang & Kegunaan Aplikasi
Mengingat pentingnya digitalisasi untuk memulihkan perekonomian dunia, kelompok kami memutuskan untuk membuat suatu aplikasi yang dapat membantu setiap pelaku UMKM, khususnya UMKM dalam negeri, untuk mengembangkan bisnis mereka. Seperti yang kita tahu, bahwa sekitar 70% dari setiap bisnis UMKM sendiri memberikan potensi yang sangat besar untuk roda ekonomi negara Indonesia. Bukti ini dapat terlihat selama beberapa tahun terakhir yang dipaparkan dalam forum diskusi sekretariat presiden bahwa terbukti bahwa UMKM dapat meningkatkan Produk Domestik Bruto (PDB) negara sebanyak dua kali lipat atau lebih tepatnya 61,97%. Ditambah lagi, dengan data yang mengatakan bahwa UMKM menyerap tenaga kerja sebanyak 70% memberikan secercah harapan untuk mereduksi pengangguran yang kian marak di Indonesia. Bila ditarik dalam sebuah kesimpulan, Indonesia memiliki peluang yang cukup besar sebagai pemain aktif di pasar global. Sangat disayangkan sekali apabila produk-produk lokal yang terdapat dalam negara Indonesia tidak dapat dipromosikan ke dalam kancah internasional. Oleh karena itu, kami berharap dengan aplikasi ini, setiap UMKM memiliki kans yang lebih tinggi  untuk bersaing di pasar global. 


## 🕴 Peran Pengguna Aplikasi
- Guest: Pengguna yang belum mendaftarkan akun dapat mengakses seluruh website, tetapi tidak dapat membuat artikel baru, mengomentari artikel, atau menambahkan UMKM baru.
- User: Pengguna yang telah mendaftarkan akun dan masuk dengan username yang unik dan sebuah password. Dapat mengakses seluruh website dan dapat menggunakan semua fitur yang ada.


## 📲 Daftar Fitur

### 1. Halaman Login & Registrasi Akun (Kelompok)
User yang telah mendaftarkan akun dapat memasukkan username dan password untuk masuk ke halaman website. Pada halaman register, pengguna baru atau Guest dapat mendaftarkan akun agar bisa login sebagai User.

### 2. FAQ Module (Raden Dhaneswara Timur)
Halaman ini berisi jawaban dari pertanyaan-pertanyaan yang umum ditanyakan pengguna Mercatura. Pengguna yang telah login sebagai User dapat menambahkan daftar pertanyaan yang ada.

### 3. Kisah Inspiratif Module (Majid Rajendra Rahmat)
Halaman ini merupakan halaman utama yang berisi kisah inspiratif dari beberapa usaha secara singkat. Pengguna yang telah login sebagai User dapat menceritakan kisahnya dan akan ditampilkan disini. 

### 4. Article Module (Aidah Novallia Putri)
Halaman ini berisi daftar artikel seputar UMKM yang dibuat oleh user Mercatura. Pengguna yang telah login sebagai User dapat menambahkan artikel baru serta melihat riwayat artikel yang telah dibuatnya. Pada riwayat artikel, pengguna dapat mengubah ataupun menghapus artikel yang telah dibuatnya.

### 5. Kritik dan Saran Module (Katrina Gisella Sembiring)
Halaman ini berisi kritik dan saran yang User ingin sampaikan terkait dengan Mercatura. Membuat kritik dan saran hanya dibatasi untuk User yang sudah log in saja, dan User yang tidak log in hanya dapat melihat kritik dan saran yang sudah dibuat oleh User lain.

### 6. UMKM Module (Raden Mohamad Adrian Ramadhan Hendar Wibawa)
Halaman ini berisi daftar nama UMKM dan profil singkatnya. Terdapat searchbox yang memungkinkan pengguna untuk mencari UMKM berdasarkan keyword ataupun filter berdasarkan bidang dan lokasi usaha. Pengguna yang telah login sebagai User dapat menambahkan UMKM baru dan juga dapat menambahkan UMKM favoritnya. 


## ⚙ Alur Integrasi Web Service
Untuk dapat mengintegrasikan data dari Web Service yang merupakan hasil Proyek Tengah Semester, kami akan mengikuti tahapan berikut (Sumber: [Tutorial 8](https://pbp-fasilkom-ui.github.io/ganjil-2023/assignments/tutorial/tutorial-8#tutorial-menambahkan-dependensi-http)):
- Membuat model berdasarkan data yang diterima dari url JSON menggunakan situs [Quicktype](https://app.quicktype.io/). Untuk setiap model yang ada, yakni Artikel, KritikSaran, Faq, Kisah, dan UMKM akan kami buat model nya di dalam flutter. Pada model ini juga akan ada function `fromJson` dan `toJson` untuk mengonversi data yang diterima menjadi model dan sebaliknya.
- Membuat function asynchronous untuk meng-*fetch* response dari url JSON Proyek Akhir Semester untuk setiap model yang memanfaatkan dependensi HTTP. Setelah response diterima dan di*parse*, kemudian akan dikonversikan ke model kustom sebelumnya dalam bentuk `Future`.
- Memanfaatkan asynchronous programming dari widget FutureBuilder, data yang telah diterima akan diintegrasikan ke widget-widget *User Interface* sehingga data yang berasal dari Web Service dapat ditampilkan dalam aplikasi Flutter. 

