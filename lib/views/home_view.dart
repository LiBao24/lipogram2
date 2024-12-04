import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipogram/controllers/home_controller.dart';

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
            fontFamily: 'Arial',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profil
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/profil-nashya.jpg'), // Profil image
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'nashya',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Gambar Postingan
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/post-nashya.jpg',
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 10),

              // Caption
              const Text(
                'Moments framed in time.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Statistik (Likes dan Comments)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        '${homeController.likes.value} likes',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Obx(() => Text(
                        '${homeController.comments.value} comments',
                      )),
                ],
              ),
              const SizedBox(height: 10),

              // Tombol Like
              ElevatedButton.icon(
                onPressed: homeController.likePost,
                icon: const Icon(Icons.favorite, color: Colors.red),
                label: const Text("Like"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
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
