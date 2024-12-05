import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/edit_profile_controller.dart';
// import '../controllers/profile_controller.dart';
// import 'package:image_picker/image_picker.dart';
// import '../controllers/edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundImage: controller.profileImage.value.isNotEmpty
                        ? NetworkImage(controller.profileImage.value)
                        : const AssetImage('assets/image/profile.png')
                            as ImageProvider,
                  )),
              const SizedBox(height: 16),
              
              ElevatedButton(
                onPressed: () async {
                  await controller.pickImage();
                },
                child: const Text("Change Profile Picture"),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: TextEditingController(text: controller.name.value),
                onChanged: controller.updateName,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: TextEditingController(text: controller.username.value),
                onChanged: controller.updateUsername,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: TextEditingController(text: controller.bio.value),
                onChanged: controller.updateBio,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  await controller.updateProfile();
                  Get.snackbar("Success", "Profile updated successfully");
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
