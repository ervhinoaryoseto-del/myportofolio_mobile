# Portofolio Mobile Pribadi: Ervhino Aryo Seto

| | |
|---|---|
| **Nama** | Ervhino Aryo Seto |
| **NPM** | 2506551125 |
| **Kelas** | PBP F |
| **Repositori** | https://github.com/ervhinoaryoseto-del/myportofolio_mobile |

Aplikasi mobile portofolio pribadi berbasis Flutter untuk mata kuliah Pemrograman Berbasis Platform (CSGE602022), Fakultas Ilmu Komputer Universitas Indonesia, semester Gasal 2026/2027.

---

## Daftar Isi

1. [Fitur](#fitur)
2. [Struktur Proyek](#struktur-proyek)
3. [Menjalankan Proyek](#menjalankan-proyek)
4. [Progres Mingguan](#progres-mingguan)
5. [Pertanyaan Reflektif](#pertanyaan-reflektif)
6. [AI Disclosure](#ai-disclosure)

---

## Fitur

- **Informasi profil**: menampilkan NPM, nama lengkap, dan kelas PBP dalam tiga kartu informasi.
- **Menu portofolio**: menyediakan tombol Lihat Proyek, Tambah Proyek, Logout, Search, Menu, dan History.
- **Interaksi tombol**: setiap tombol memiliki ikon, warna latar yang berbeda, dan menampilkan SnackBar sesuai nama tombol yang ditekan.
- **Tampilan responsif**: kartu aksi ditampilkan dalam grid menggunakan widget Flutter.
- **Drawer navigation**: menyediakan navigasi ke halaman Home dan Add Project melalui drawer.
- **Form tambah proyek**: menerima nama, deskripsi, kategori, teknologi, dan tautan proyek dengan validasi untuk nama serta deskripsi.
- **Popup hasil input**: menampilkan data proyek setelah form berhasil divalidasi dan mereset form setelah konfirmasi.
- **Navigasi kartu**: kartu Tambah Proyek membuka halaman form menggunakan `Navigator.push`.
- **Struktur modular**: halaman berada di `lib/screens/`, widget bersama berada di `lib/widgets/`, dan bootstrap aplikasi berada di `lib/main.dart`.
- **Form pendidikan**: menerima input berupa institusi, program studi, jenjang, periode pendidikan, dan deskripsi dengan validasi serta dialog ringkasan.
- **Material UI**: menggunakan dependency `material_ui` sesuai instruksi Tutorial 09 untuk Flutter 3.47.

## Struktur Proyek

```text
lib/
├── main.dart                       # Bootstrap aplikasi dan MaterialApp
├── screens/
│   ├── menu.dart                   # Halaman Home, InfoCard, dan ItemHomepage
│   └── project_form.dart           # Form tambah proyek dan validasi
└── widgets/
    ├── left_drawer.dart            # Drawer navigation
    └── project_card.dart           # Kartu menu dan navigasi form
```

## Menjalankan Proyek

Pastikan Flutter SDK sudah terpasang, lalu jalankan perintah berikut dari root proyek:

```bash
git clone https://github.com/ervhinoaryoseto-del/myportofolio_mobile.git
cd myportofolio_mobile
flutter pub get
flutter run
```
Proyek ini menggunakan `material_ui` sesuai ketentuan Tutorial 09. Jika dependency belum tersedia, jalankan:

```bash
flutter pub add material_ui
```

Untuk memeriksa kualitas kode dan menjalankan pengujian:

```bash
flutter analyze
flutter test
```

## Progres Mingguan

| Minggu | Yang dikerjakan |
|---|---|
| **Tutorial 08** | Membuat proyek Flutter, memahami struktur aplikasi, memisahkan `menu.dart` dari `main.dart`, serta membuat widget `InfoCard` dan `ItemCard`. |
| **Tugas 7** | Menyesuaikan aplikasi menjadi portofolio pribadi, mengisi identitas pemilik, menambahkan menu aksi, memberi warna berbeda pada setiap tombol, dan menampilkan SnackBar interaktif. |
| **Tutorial 09** | Menambahkan drawer navigation, halaman form tambah proyek, validasi input, popup data proyek, navigasi tombol, dan refactoring halaman serta widget ke direktori `screens` dan `widgets`. |
| **Tugas 8** | Menambahkan form pendidikan dengan input institusi, program studi, jenjang, date picker, status pendidikan, validasi, dialog ringkasan, serta navigasi dari kartu dan drawer. |
| **Tutorial 10** | Menghubungkan aplikasi dengan API, menampilkan daftar proyek dari server, menambahkan login dan logout berbasis token, melindungi fitur tambah proyek, serta menambahkan workflow CI untuk analisis, testing, dan build APK. |

---

# Pertanyaan Reflektif

### Tugas 7

1. **Widget tree dan hubungan parent-child**
   Widget tree adalah struktur hierarki yang menggambarkan hubungan antar-widget dalam aplikasi Flutter. Dimana setiap widget dapat memiliki widget lain sebagai anak (*child*), sehingga aplikasi tersusun seperti pohon (tree). Widget induk (*parent*) bertanggung jawab mengatur posisi, ukuran, tema, atau perilaku widget anaknya. Contohnya, `MaterialApp` menjadi parent dari `MyHomePage`, kemudian `MyHomePage` memiliki `Scaffold`, dan `Scaffold` memiliki `AppBar` serta `body`. Hubungan ini membuat tampilan aplikasi dapat dibangun secara bertingkat dan terorganisasi.

2. **Widget yang digunakan dalam proyek**
   - `MaterialApp`: menjadi root aplikasi dan menyediakan tema serta konfigurasi dasar Flutter.
   - `Scaffold`: menyediakan struktur dasar halaman seperti `AppBar`, `body`, dan dukungan `SnackBar`.
   - `AppBar`: menampilkan bilah navigasi di bagian atas halaman.
   - `Text`: menampilkan tulisan seperti judul, nama tombol, NPM, nama, dan kelas.
   - `Padding`: memberikan jarak di sekitar widget.
   - `Column`: menyusun widget secara vertikal.
   - `Row`: menyusun tiga `InfoCard` secara horizontal.
   - `InfoCard`: widget kustom untuk menampilkan informasi profil.
   - `Card`: memberikan tampilan kartu pada informasi profil.
   - `Container`: mengatur ukuran, padding, dan tata letak isi kartu.
   - `SizedBox`: memberikan jarak dengan ukuran tertentu.
   - `Center`: menempatkan widget di posisi tengah.
   - `GridView.count`: menampilkan daftar tombol dalam bentuk grid.
   - `ItemCard`: widget kustom untuk menampilkan tombol aksi portofolio.
   - `Material`: memberikan warna latar dan bentuk material pada tombol.
   - `InkWell`: memberikan efek sentuhan dan menangani aksi ketika kartu ditekan.
   - `Icon`: menampilkan ikon pada setiap tombol aksi.
   - `SnackBar`: menampilkan pesan sementara ketika tombol ditekan.
   - `MediaQuery`: mengambil informasi ukuran layar untuk menentukan lebar `InfoCard`.

3. **Fungsi MaterialApp**
   `MaterialApp` adalah widget utama yang menyediakan konfigurasi dasar untuk aplikasi yang menggunakan desain Material dari Flutter. Widget ini mengatur tema, judul aplikasi, halaman awal, navigasi, dan konfigurasi visual lainnya.`MaterialApp` biasanya digunakan sebagai root widget karena menjadi dasar bagi widget-widget lain di dalam aplikasi. Dengan menjadikannya root, seluruh halaman di bawahnya dapat menggunakan tema, navigasi, dan fitur Material secara konsisten. Pada proyek ini, `MaterialApp` mengatur tema aplikasi dan menampilkan `MyHomePage` sebagai halaman utama.

4. **Perbedaan StatelessWidget dan StatefulWidget**
   `StatelessWidget` adalah widget yang tampilannya bergantung pada data yang tidak berubah selama widget tersebut digunakan. Widget ini tidak memiliki state internal yang dapat diperbarui. Contohnya adalah `MyHomePage`, `InfoCard`, dan `ItemCard` pada proyek ini karena struktur dan data tampilannya sudah ditentukan.

   `StatefulWidget` adalah widget yang memiliki state yang dapat berubah selama aplikasi berjalan. Perubahan state biasanya dilakukan menggunakan `setState()`, sehingga Flutter akan membangun ulang bagian tampilan yang terpengaruh. Contohnya adalah form input, calculator, animasi, atau halaman yang memiliki data loading.

   Kita sebaiknya menggunakan `StatelessWidget` jika tampilan hanya bergantung pada data yang tetap atau data dari parent. `StatefulWidget` digunakan jika tampilan perlu berubah sebagai respons terhadap interaksi pengguna, perubahan data, animasi, atau proses asynchronous.

5. **BuildContext**
   `BuildContext` adalah referensi terhadap lokasi sebuah widget di dalam widget tree. Context membantu Flutter mengetahui posisi widget dan hubungan widget tersebut dengan parent maupun ancestor-nya.

   `BuildContext` penting karena digunakan untuk mengakses informasi dari widget di atasnya, seperti tema, ukuran layar, navigator, dan `ScaffoldMessenger`. Pada proyek ini, `BuildContext` digunakan untuk mengambil warna tema melalui `Theme.of(context)`, ukuran layar melalui `MediaQuery.of(context)`, serta menampilkan `SnackBar` menggunakan `ScaffoldMessenger.of(context)`.

   Parameter `context` tersedia di dalam metode `build`. Context tersebut digunakan ketika widget membutuhkan informasi dari lingkungan atau widget ancestor di dalam widget tree.

6. **Hot reload dan hot restart**
   Hot reload adalah fitur Flutter yang menerapkan perubahan kode ke aplikasi yang sedang berjalan tanpa mengulang seluruh aplikasi. State aplikasi biasanya tetap dipertahankan, sehingga proses pengembangan dan pengecekan tampilan menjadi lebih cepat.

   Hot restart menjalankan ulang aplikasi Flutter dari awal dan menghapus state yang sedang tersimpan. Hot restart diperlukan ketika perubahan tidak dapat diterapkan dengan benar melalui hot reload atau ketika ingin menguji aplikasi dari kondisi awal.

   Hot reload biasanya tidak cukup jika perubahan dilakukan pada kode inisialisasi tertentu, struktur global, konfigurasi plugin, atau state yang sudah terlanjur tersimpan. Hot restart juga diperlukan jika aplikasi berada dalam kondisi state yang tidak sesuai.

   Full restart diperlukan jika perubahan berkaitan dengan native code Android atau iOS, konfigurasi platform, penambahan plugin native, perubahan dependency tertentu, atau perubahan yang membutuhkan proses build ulang secara menyeluruh.


### Tugas 8

1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama?

`Navigator.push()` menambahkan halaman baru ke stack sehingga form dapat dibuka dari kartu atau drawer dan pengguna dapat kembali dengan tombol Back. `Navigator.pushReplacement()` mengganti halaman aktif, sehingga digunakan oleh opsi Home pada drawer agar pengguna kembali ke halaman utama tanpa menumpuk route baru. `Navigator.pop()` menutup route teratas, sehingga digunakan untuk menutup dialog dan kembali dari halaman.

2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman?

`Scaffold` menyediakan struktur halaman, `AppBar` menjaga judul dan tema visual tetap konsisten, sedangkan `Drawer` menyediakan navigasi global yang dapat dipakai dari halaman utama maupun halaman form.

3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas?

Form pendidikan memakai `TextFormField` untuk teks, `DropdownButtonFormField` untuk jenjang dengan pilihan terbatas, dan `showDatePicker()` untuk tanggal agar input lebih terstruktur dan mengurangi kesalahan format. `SingleChildScrollView` digunakan agar seluruh form tetap dapat diakses pada layar sempit atau saat keyboard terbuka.

4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup?

`GlobalKey<FormState>` memberi akses ke state form. Setiap validator memeriksa input masing-masing, lalu `validate()` menjalankan seluruh validator saat tombol Simpan ditekan. Contoh input yang ditolak adalah nama institusi kosong, deskripsi kurang dari 10 karakter, atau tanggal selesai yang lebih awal dari tanggal mulai.

---

## AI Disclosure

# Tugas 7
Log chat: https://chatgpt.com/share/6af960ea-6d9c-83ec-9c66-79b7a9374e6e

**Strategi prompting:** 
Saya menggunakan Generative-AI yaitu ChatGPT Web sebagai alat bantu untuk meninjau kesesuaian implementasi Flutter dengan instruksi Tugas 7 dan menyusun kerangka dokumentasi README. Implementasi akhir tugas 7 serta penyesuaian data pribadi, pengujian, serta keputusan desain tetap saya periksa dan kerjakan sendiri.

**Bagian yang dibantu AI:**
- Pembuatan kerangka README, termasuk daftar isi, fitur, struktur proyek, dan panduan menjalankan proyek.

**Keterbatasan AI dan perbaikan manual:**
- AI tidak dapat menulis data pribadi saya tanpa context yang lengkap, sehingga saya menambahkan identitas pribadi (nama, NPM, kelas) secara manual.

## Tugas 8
Log chat: https://chatgpt.com/share/6b045cfb-0880-83ec-b3ed-ac7313f9ce52

**Strategi prompting:** 
Saya menggunakan Generative-AI yaitu ChatGPT Web sebagai alat bantu untuk menyusun rencana implementasi dan meninjau kesesuaian aplikasi Flutter dengan instruksi Tugas 8. Implementasi akhir, penyesuaian fitur pendidikan, pengujian aplikasi, dan keputusan desain tetap saya periksa sendiri.

**Bagian yang dibantu AI:**
- Penyusunan rencana implementasi Tugas 8

**Keterbatasan AI dan perbaikan manual:**
- Saya memeriksa kembali hasil implementasi dan memperbaiki masalah runtime terkait penggunaan library Material dan localization

