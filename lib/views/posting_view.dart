import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipogram/controllers/photo_controller.dart';

class ShareScreen extends StatelessWidget {
  final PhotoController controller = Get.find<PhotoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Postingan baru"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        // Tambahkan ini
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan foto yang dipilih
            Obx(() => controller.selectedPhoto.value != null
                ? Image.file(
                    controller.selectedPhoto.value!,
                    width: double.infinity,
                    height: 300, // Tinggi foto diperbesar
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    height: 300, // Tinggi default saat foto tidak ada
                    child: const Center(
                        child: Text("Tidak ada foto yang dipilih")),
                  )),
            const SizedBox(height: 12), // Jarak antar komponen
            // Form deskripsi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: controller.updateDescription,
                style: const TextStyle(fontSize: 14), // Ukuran teks lebih kecil
                decoration: InputDecoration(
                  labelText: 'Tambah deskripsi',
                  labelStyle: const TextStyle(
                      fontSize: 14, color: Colors.grey), // Warna abu-abu
                  border: OutlineInputBorder(
                    // Border biasa
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border saat tidak fokus
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border saat fokus
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 54, 54, 54), width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12), // Jarak antar komponen
            // Tombol Bagikan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF469FC0), // Warna biru terang
                  minimumSize: const Size(
                      double.infinity, 48), // Lebar penuh dan tinggi tombol
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(6), // Radius sesuai gambar
                  ),
                ),
                onPressed: controller.sharePhoto,
                child: const Text(
                  "Bagikan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
