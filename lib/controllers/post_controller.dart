import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';
import '../utils/api_url.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;

  var isLoading = false.obs;

  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/posts'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        posts.value = (jsonData as List).map((data) => Post.fromJson(data)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sharePost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(post.toJson()),
      );
      if (response.statusCode == 201) {
        posts.insert(0, post);
        Get.snackbar('Success', 'Post shared successfully');
      } else {
        Get.snackbar('Error', 'Failed to share post');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
