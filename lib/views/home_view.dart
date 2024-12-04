import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipogram/controllers/home_controller.dart';
import 'package:lipogram/controllers/profile_controller.dart';
import 'comment_bottom_sheet.dart'; // Import untuk komentar
import 'likes_bottom_sheet.dart'; // Import untuk daftar like

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController =
      Get.put(ProfileController()); // Ambil ProfileController

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Terima data dari arguments
    final Map<String, dynamic>? args = Get.arguments;
    final File? photo = args?['photo']; // Foto yang dikirim
    final String? description = args?['description']; // Deskripsi yang dikirim

    // Jika ada foto & deskripsi, tandai sebagai postingan baru
    if (photo != null && description != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        homeController.createPost(); // Tandai bahwa postingan telah dibuat
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        homeController.deletePost(); // Hapus status postingan jika data kosong
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'lipogram',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profil
            Obx(() {
              if (!homeController.hasPost.value) {
                return const SizedBox(); // Jangan tampilkan apa pun jika belum ada post
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profil
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Obx(() {
                          return CircleAvatar(
                            backgroundImage: profileController
                                    .profileImage.value
                                    .contains('assets/')
                                ? AssetImage(
                                        profileController.profileImage.value)
                                    as ImageProvider
                                : FileImage(
                                    File(profileController.profileImage.value)),
                            radius: 25,
                          );
                        }),
                        const SizedBox(width: 10),
                        Obx(() {
                          return Text(
                            profileController.username.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  // Foto Postingan
                  if (photo != null)
                    Image.file(
                      photo,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),

                  // Caption
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  const SizedBox(height: 10),

                  // Statistik, Tombol Like, dan Komentar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Obx(() => IconButton(
                              onPressed: homeController.toggleLike,
                              icon: Icon(
                                Icons.favorite,
                                color: homeController.isLiked.value
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            )),

                        // Jumlah Likes
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) =>
                                  const LikesBottomSheet(),
                            );
                          },
                          child: Obx(() => Text(
                                '${homeController.likes.value} likes',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const SizedBox(width: 16),

                        // Tombol Komentar
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) =>
                                  CommentBottomSheet(),
                            );
                          },
                          icon: const Icon(Icons.comment),
                        ),
                        Obx(() => Text(
                              '${homeController.comments.value} comments',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            }),

            // Profil
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/profil-nashya.jpg'), // Profil image
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'nashya',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Gambar Postingan
            Image.asset(
              'assets/post-nashya.jpg',
              fit: BoxFit.cover,
              height: 400,
              width: double.infinity, // Lebar penuh
            ),
            const SizedBox(height: 10),

            // Caption
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Moments framed in time.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            // Statistik, Tombol Like, dan Komentar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Tombol Love
                  Obx(() => IconButton(
                        onPressed: homeController.toggleLike,
                        icon: Icon(
                          Icons.favorite,
                          color: homeController.isLiked.value
                              ? Colors.red
                              : Colors.grey,
                        ),
                      )),

                  // Jumlah Likes
                  GestureDetector(
                    onTap: () {
                      // Menampilkan daftar likes dalam modal bottom sheet
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) =>
                            const LikesBottomSheet(),
                      );
                    },
                    child: Obx(() => Text(
                          '${homeController.likes.value} likes',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(width: 16),

                  // Tombol Komentar
                  IconButton(
                    onPressed: () {
                      // Menampilkan komentar dalam modal bottom sheet
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => CommentBottomSheet(),
                      );
                    },
                    icon: const Icon(Icons.comment),
                  ),
                  // Jumlah Komentar
                  Obx(() => Text(
                        '${homeController.comments.value} comments',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Home = index 0
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
