import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipogram/controller/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghapus tanda panah kembali
        title: Obx(() => Align(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.username.value, // Username ditampilkan
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
              // Foto profil dan statistik
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Foto profil
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/profil-ivy.jpg'),
                    radius: 40,
                  ),
                  const SizedBox(width: 20),

                  // Statistik
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

              // Nama lengkap dan bio
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

              // Tombol Edit Profil
              SizedBox(
                width: double.infinity, // Tombol memenuhi lebar layar
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Warna teks
                    backgroundColor:
                        Colors.grey[200], // Warna background tombol
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Radius sudut tombol
                    ),
                    minimumSize:
                        const Size(0, 28), // Atur tinggi minimum tombol
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16), // Kurangi padding vertikal
                  ),
                  child: const Text(
                    'Edit Profil',
                    style:
                        TextStyle(fontSize: 13), // Sesuaikan ukuran font teks
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Grid Foto (3 Postingan)
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
                        // borderRadius: BorderRadius.circular(1),
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
        currentIndex: 4, // Profile = index 4
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
