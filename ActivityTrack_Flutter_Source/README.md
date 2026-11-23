# ActivityTrack – Daily Activity Counter

Project UTS Pemrograman Mobile menggunakan Flutter dan Dart dengan arsitektur MVVM, Repository, dan Data.

## Fitur
- Menampilkan daftar aktivitas dan nilai counter.
- Menambah dan mengedit nama aktivitas.
- Melihat detail aktivitas.
- Menambah counter (+) dan mengurangi counter (-).
- Counter tidak dapat bernilai kurang dari 0.
- Reset counter dengan konfirmasi AlertDialog.
- Menghapus aktivitas dengan konfirmasi.
- SnackBar untuk feedback perubahan data.
- Data disimpan sementara dalam List selama aplikasi berjalan.

## Struktur folder
```text
lib/
├── main.dart
├── models/
│   └── activity_model.dart
├── data/
│   └── activity_data.dart
├── repositories/
│   └── activity_repository.dart
├── viewmodels/
│   └── activity_viewmodel.dart
└── views/
    ├── home_view.dart
    ├── activity_form_view.dart
    └── activity_detail_view.dart
```

## Cara menjalankan
1. Pastikan Flutter SDK dan Android Studio/VS Code sudah terpasang.
2. Buka terminal pada folder project Flutter yang dibuat.
3. Jalankan `flutter create .` jika folder platform Android/iOS belum dibuat.
4. Ganti folder `lib` bawaan dengan folder `lib` dari project ini.
5. Jalankan `flutter pub get`.
6. Hubungkan emulator atau perangkat Android.
7. Jalankan `flutter run`.

Project ini menggunakan widget dan package bawaan Flutter, sehingga tidak membutuhkan dependency tambahan.

## Penjelasan arsitektur MVVM
- **Model** (`activity_model.dart`): mendefinisikan objek aktivitas dengan atribut id, name, dan counter.
- **Data** (`activity_data.dart`): menyediakan data awal dan List sebagai penyimpanan sementara.
- **Repository** (`activity_repository.dart`): menjadi perantara ViewModel untuk mengambil dan memanipulasi data.
- **ViewModel** (`activity_viewmodel.dart`): mengelola logika aplikasi, memanggil Repository, dan memberi notifikasi perubahan melalui ChangeNotifier.
- **View** (`views/`): menampilkan halaman Home, Tambah/Edit, dan Detail serta meneruskan interaksi pengguna ke ViewModel.

## Alur data
Pengguna berinteraksi dengan View. View memanggil fungsi pada ViewModel. ViewModel meneruskan permintaan ke Repository, lalu Repository mengelola data pada List di ActivityData. Setelah data berubah, ViewModel menjalankan `notifyListeners()`. Widget yang menggunakan `AnimatedBuilder` kemudian membangun ulang tampilan sesuai data terbaru.

## Catatan
Data tidak disimpan permanen. Ketika aplikasi ditutup sepenuhnya, data aktivitas yang dibuat pengguna akan kembali ke data awal. Hal ini sesuai ketentuan tugas yang hanya meminta penyimpanan sementara menggunakan List.
