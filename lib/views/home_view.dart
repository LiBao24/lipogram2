import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'comment_bottom_sheet.dart'; // Import untuk komentar
import 'likes_bottom_sheet.dart'; // Import untuk daftar like

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/profile/nashya.png'), // Profil image
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
              'assets/post-nashya.png',
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
                        builder: (BuildContext context) => const LikesBottomSheet(),
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
                        builder: (BuildContext context) =>  CommentBottomSheet(),
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
