import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:lipogram/controllers/edit_profile_controller.dart';
import '../controllers/profile_controller.dart'; // Import ProfileController

class EditProfileView extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());
  final ProfileController profileController =
      Get.find(); // Get existing ProfileController

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: controller.name.value);
    final usernameController =
        TextEditingController(text: controller.username.value);
    final bioController = TextEditingController(text: controller.bio.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Update ProfileController with new values, including profile image
              profileController.updateProfile(
                nameController.text,
                usernameController.text,
                bioController.text,
                controller.profileImage.value, // Pass the updated profile image
              );

              Get.back(); // Go back to ProfileView
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          controller.profileImage.value.contains('assets/')
                              ? AssetImage(controller.profileImage.value)
                                  as ImageProvider
                              : FileImage(File(controller.profileImage
                                  .value)), // Handle local file images
                      backgroundColor: Colors.grey[200],
                    );
                  }),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      await controller.pickImage(); // Pick new image
                    },
                    child: const Text(
                      'Edit foto',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Nama pengguna',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
