import 'dart:io';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lipogram/views/home_view.dart';
import 'package:lipogram/controllers/profile_controller.dart';

class PhotoController extends GetxController {
  var galleryPhotos = <File>[].obs; // Daftar foto dalam bentuk File
  var selectedPhoto = Rxn<File>(); // Foto yang dipilih
  var photoDescription = ''.obs; // Deskripsi foto
  var currentPage = 0.obs; // Halaman saat ini untuk paging
  final int pageSize = 50; // Jumlah foto per batch

  late AssetPathEntity album; // Album utama (All Photos)
  var isLoading = false.obs; // Indikator loading

  @override
  void onInit() {
    super.onInit();
    loadAllGalleryPhotos();
  }

  /// Memuat semua foto dari galeri pengguna
  Future<void> loadAllGalleryPhotos() async {
    // Meminta izin akses galeri
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      // Mendapatkan daftar album (hanya "All Photos")
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
      );

      if (albums.isNotEmpty) {
        album = albums[0]; // Mengambil album utama
        loadNextBatch(); // Memuat batch pertama
      } else {
        print("Tidak ada album ditemukan di galeri");
      }
    } else {
      print("Izin akses galeri tidak diberikan");
    }
  }

  /// Memuat batch foto berikutnya
  Future<void> loadNextBatch() async {
    if (isLoading.value) return; // Jangan memuat ulang jika sedang loading
    isLoading.value = true;

    try {
      // Mengambil daftar aset berdasarkan halaman dan ukuran
      final List<AssetEntity> media = await album.getAssetListPaged(
        page: currentPage.value, // Halaman saat ini
        size: pageSize, // Jumlah item per halaman
      );

      if (media.isNotEmpty) {
        for (var asset in media) {
          final file = await asset.file;
          if (file != null) galleryPhotos.add(file);
        }

        if (currentPage.value == 0 && galleryPhotos.isNotEmpty) {
          selectedPhoto.value = galleryPhotos.first; // Atur foto pertama
        }

        currentPage.value++; // Increment halaman
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Mengambil foto langsung dari kamera
  Future<void> takePhotoFromCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      // Akses kamera diizinkan
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final photo = File(pickedFile.path);
        selectedPhoto.value = photo;
        galleryPhotos.insert(0, photo); // Menambahkan foto ke galeri
      }
    } else {
      // Izin tidak diberikan
      Get.snackbar("Izin Kamera", "Akses kamera tidak diizinkan.");
    }
  }

  /// Memilih foto dari grid
  void selectPhoto(File photo) {
    print("Foto dipilih: ${photo.path}"); // Debugging
    selectedPhoto.value = photo; // Memperbarui foto utama
  }

  // Fungsi untuk memperbarui deskripsi
  void updateDescription(String description) {
    photoDescription.value = description;
  }

  // Fungsi untuk membagikan
  void sharePhoto() {
    if (selectedPhoto.value != null && photoDescription.value.isNotEmpty) {
      // Ambil instance ProfileController
      final profileController = Get.put(ProfileController());
      Get.to(HomeView(), arguments: {
        'photo': selectedPhoto.value,
        'description': photoDescription.value,
      });
      // Tambahkan postingan baru ke profil
      profileController.addPost({
        'photo': selectedPhoto.value!.path,
        'description': photoDescription.value,
      });
    } else {
      Get.snackbar(
          'Error', 'Pilih foto dan tambahkan deskripsi terlebih dahulu.');
    }
  }
}
