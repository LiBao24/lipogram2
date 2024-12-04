import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipogram/controllers/photo_controller.dart';
import 'package:lipogram/views/posting_view.dart';

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
              if (controller.selectedPhoto.value != null) {
                // Navigasi ke halaman ShareScreen untuk menambahkan deskripsi
                Get.to(() => ShareScreen());
              } else {
                // Jika belum memilih foto, tampilkan snackbar
                Get.snackbar('Error', 'Pilih foto terlebih dahulu');
              }
            },
            child:
                const Text("Selanjutnya", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Foto utama
          Obx(() => controller.selectedPhoto.value != null
              ? Image.file(
                  controller
                      .selectedPhoto.value!, // Menampilkan foto yang dipilih
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey[200],
                  width: double.infinity,
                  height: 300,
                  child:
                      const Center(child: Text("Pilih foto untuk ditampilkan")),
                )),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pilih foto",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: controller.takePhotoFromCamera,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Grid foto dengan infinite scroll
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
                        print("Foto dipilih: ${photo.path}"); // Debugging
                      },
                      child: Stack(
                        children: [
                          // Foto
                          ClipRRect(
                            child: Image.file(
                              photo,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          // Overlay putih jika foto dipilih
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
            // Pindah ke Home
            Get.toNamed('/home');
          } else if (index == 1) {
            // Pindah ke Search
            Get.toNamed('/search');
          } else if (index == 2) {
            // Pindah ke Add Post
            Get.toNamed('/addPost');
          } else if (index == 3) {
            // Pindah ke Notifikasi
            Get.toNamed('/notifications');
          } else if (index == 4) {
            // Tetap di Profile
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
