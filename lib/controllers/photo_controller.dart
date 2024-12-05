import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import '../utils/api_url.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../views/home_view.dart';
import '../controllers/profile_controller.dart';
import '../utils/api_url.dart';

class PhotoController extends GetxController {
  var galleryPhotos = <File>[].obs;
  var selectedPhoto = Rxn<File>();
  var photoDescription = ''.obs;
  var currentPage = 0.obs;
  final int pageSize = 50;

  late AssetPathEntity album;
  var isLoading = false.obs;

  get description => null;

  get pickPhotoFromGallery => null;

  @override
  void onInit() {
    super.onInit();
    loadAllGalleryPhotos();
  }

  Future<void> loadAllGalleryPhotos() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
      );

      if (albums.isNotEmpty) {
        album = albums[0];
        loadNextBatch();
      } else {
        print("Tidak ada album ditemukan di galeri");
      }
    } else {
      print("Izin akses galeri tidak diberikan");
    }
  }

  Future<void> loadNextBatch() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final List<AssetEntity> media = await album.getAssetListPaged(
        page: currentPage.value,
        size: pageSize,
      );

      if (media.isNotEmpty) {
        for (var asset in media) {
          final file = await asset.file;
          if (file != null) galleryPhotos.add(file);
        }

        if (currentPage.value == 0 && galleryPhotos.isNotEmpty) {
          selectedPhoto.value = galleryPhotos.first;
        }

        currentPage.value++;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> takePhotoFromCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final photo = File(pickedFile.path);
        selectedPhoto.value = photo;
        galleryPhotos.insert(0, photo);
      }
    } else {
      Get.snackbar("Izin Kamera", "Akses kamera tidak diizinkan.");
    }
  }

  void selectPhoto(File photo) {
    print("Foto dipilih: ${photo.path}");
    selectedPhoto.value = photo;
  }

  void updateDescription(String description) {
    photoDescription.value = description;
  }

  Future<void> sharePhoto() async {
    if (selectedPhoto.value != null && photoDescription.value.isNotEmpty) {
      try {
        File photo = selectedPhoto.value!;
        String description = photoDescription.value;

        var request = http.MultipartRequest('POST', Uri.parse(apiBaseUrl));

        var file = await http.MultipartFile.fromPath(
          'photo', photo.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);

        request.fields['description'] = description;

        var response = await request.send();

        if (response.statusCode == 200) {
          Get.snackbar('Sukses', 'Post berhasil dibuat');
          Get.to(HomeView(), arguments: {
            'photo': selectedPhoto.value,
            'description': photoDescription.value,
          });
        } else {
          Get.snackbar('Gagal', 'Gagal mengirim post ke server');
        }
      } catch (e) {
        Get.snackbar('Error', 'Terjadi kesalahan: $e');
      }
    } else {
      Get.snackbar('Error', 'Pilih foto dan tambahkan deskripsi terlebih dahulu.');
    }
  }
}
