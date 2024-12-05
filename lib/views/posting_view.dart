import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/photo_controller.dart';
import '../controllers/post_controller.dart';
import '../models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());
  final PhotoController controller = Get.find<PhotoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Postingan Baru"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: const Center(
                        child: Text("Tidak ada foto yang dipilih"))),
            ),
            const SizedBox(height: 12),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: controller.updateDescription,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'Tambah deskripsi',
                  labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 54, 54, 54), width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF469FC0),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () async {
                  if (controller.selectedPhoto.value != null &&
                      controller.photoDescription.value.isNotEmpty) {
                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getInt('userId') ?? 0;

                    final newPost = Post(
                      idPost: 0,
                      idUser: userId,
                      media: controller.selectedPhoto.value!.path,
                      caption: controller.photoDescription.value,
                    );
                    postController.sharePost(newPost);
                  } else {
                    Get.snackbar('Error', 'Pilih foto dan tambahkan deskripsi terlebih dahulu');
                  }
                },
                child: const Text('Bagikan', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
