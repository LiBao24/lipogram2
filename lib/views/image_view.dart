import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_view.dart';

class ImageView extends StatefulWidget {
  final List<String> images; // List of image paths for the posts
  final int initialIndex;

  const ImageView({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late PageController _pageController;
  RxInt comments = 0.obs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile3.jpg'),
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'naila', // Username
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                RxBool isLikedForThisPost = RxBool(false);
                RxInt likesForThisPost = RxInt(500);
                RxString captionForThisPost = RxString('----');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post Image
                    Image.asset(
                      widget.images[index],
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Obx(() => Text(
                            captionForThisPost.value,
                            style: const TextStyle(fontSize: 16),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              isLikedForThisPost.value =
                                  !isLikedForThisPost.value;
                              if (isLikedForThisPost.value) {
                                likesForThisPost.value++;
                              } else {
                                likesForThisPost.value--;
                              }
                            },
                            icon: Obx(() => Icon(
                                  Icons.favorite,
                                  color: isLikedForThisPost.value
                                      ? Colors.red
                                      : Colors.grey,
                                )),
                          ),
                          // Number of Likes
                          Obx(() => Text(
      '${likesForThisPost.value} likes',
      style: const TextStyle(fontWeight: FontWeight.bold),
    )),
                          const SizedBox(width: 16),
                          // Comment Button
                          IconButton(
                            onPressed: () {
                              // Action to open comments
                            },
                            icon: const Icon(Icons.comment),
                          ),
                          // Number of Comments
                          Obx(() => Text(
                                '${comments.value} Komentar',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            )
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Profile = index 4
        onTap: (index) {
          if (index == 0) {
            Get.toNamed('/home');
          } else if (index == 1) {
            // Pindah ke Search
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
