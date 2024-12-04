import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as app_controller;
import 'profile_view.dart';

class SearchView extends GetView<app_controller.SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 229, 229),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: controller.search,
            decoration: const InputDecoration(
              hintText: 'Cari',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final users = controller.getDisplayedUsers();
        
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(user.profileImage),
              ),
              title: Text(user.username),
              subtitle: Text(user.fullName),
              trailing: controller.searchText.isEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => controller.removeFromRecent(user),
                    )
                  : null,
              onTap: () {
                controller.addToRecent(user);
                Get.to(() => ProfileView(user: user));
              },
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: 1, // Search = index 1
  onTap: (index) {
    if (index == 0) {
      Get.toNamed('/home');
    } else if (index == 1) {
      // Tetap di halaman SearchView
      Get.to(() => const SearchView());
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
