import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipogram/controllers/home_controller.dart';

class CommentBottomSheet extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();

  CommentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'Comments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() => homeController.commentsList.isEmpty
                ? const Center(child: Text('No comments yet.'))
                : ListView.builder(
                    itemCount: homeController.commentsList.length,
                    itemBuilder: (context, index) {
                      final comment = homeController.commentsList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  comment['profilePic'] ?? 'assets/default_profile.png'),
                              radius: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment['username'] ?? 'Anonymous',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(comment['comment'] ?? ''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (commentController.text.trim().isNotEmpty) {
                    homeController.addComment({
                      'username': 'its_ivyyyy',
                      'comment': commentController.text.trim(),
                      'profilePic': 'assets/profile/user3.png',
                    });
                    commentController.clear();
                  }
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
