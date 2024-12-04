import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class LikesBottomSheet extends StatelessWidget {
  const LikesBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Liked by',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() => homeController.likesList.isEmpty
                ? const Center(child: Text('No likes yet.'))
                : ListView.builder(
                    itemCount: homeController.likesList.length,
                    itemBuilder: (context, index) {
                      final user = homeController.likesList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              user['profilePic'] ?? 'assets/default_profile.png'),
                        ),
                        title: Text(user['username'] ?? 'Unknown User'),
                      );
                    },
                  )),
          ),
        ],
      ),
    );
  }
}
