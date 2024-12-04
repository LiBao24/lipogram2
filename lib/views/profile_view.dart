import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipogram/controllers/profile_controller.dart';
import 'package:lipogram/views/edit_profile_view.dart';
import 'dart:io';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Obx(() => Align(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.username.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arial',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          controller.profileImage.value.contains('assets/')
                              ? AssetImage(controller.profileImage.value)
                                  as ImageProvider
                              : FileImage(File(controller.profileImage
                                  .value)), // Handle local file images
                      backgroundColor: Colors.grey[200],
                    );
                  }),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.posts.value.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  'Postingan',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.followers.value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  'Pengikut',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.following.value.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  'Mengikuti',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.name.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.bio.value,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  )),
              const SizedBox(height: 13),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(EditProfileView());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(0, 28),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text(
                    'Edit Profil',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: controller.photos.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        child: Image.asset(
                          controller.photos[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
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
