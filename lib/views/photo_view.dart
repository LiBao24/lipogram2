import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/photo_controller.dart';
import '../views/posting_view.dart';

class PhotoPickerScreen extends StatelessWidget {
  final PhotoController controller = Get.put(PhotoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Postingan Baru"),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.selectedPhoto.value != null &&
                  controller.photoDescription.value.isNotEmpty) {
                controller.sharePhoto();
              } else {
                Get.snackbar('Error', 'Pilih foto dan tambahkan deskripsi terlebih dahulu');
              }
            },
            child: const Text("Selanjutnya", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => controller.selectedPhoto.value != null
              ? Image.file(
                  controller.selectedPhoto.value!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey[200],
                  width: double.infinity,
                  height: 300,
                  child: const Center(child: Text("Pilih foto untuk ditampilkan")),
                )),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pilih foto",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: controller.takePhotoFromCamera,
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: controller.pickPhotoFromGallery,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Obx(() => Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.galleryPhotos.length,
                  itemBuilder: (context, index) {
                    final photo = controller.galleryPhotos[index];
                    final isSelected =
                        controller.selectedPhoto.value?.path == photo.path;
                    return GestureDetector(
                      onTap: () {
                        controller.selectPhoto(photo);
                        print("Foto dipilih: ${photo.path}");
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: Image.file(
                              photo,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          if (isSelected)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Get.toNamed('/home');
          } else if (index == 1) {
            Get.toNamed('/search');
          } else if (index == 2) {
            Get.toNamed('/addPost');
          } else if (index == 3) {
            Get.toNamed('/notifications');
          } else if (index == 4) {
            Get.toNamed('/profile');
          }
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }
}
