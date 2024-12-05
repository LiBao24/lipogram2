import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/api_url.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var username = ''.obs;
  var bio = ''.obs;
  var posts = 0.obs;
  var followers = '0'.obs;
  var following = 0.obs;
  var photos = <String>[].obs;
  var profileImage = ''.obs;

  var postDetails = <Map<String, String>>[].obs;

  ProfileController() {
    for (var photo in photos) {
      postDetails.add({'photo': photo});
    }
    posts.value = postDetails.length;
  }

  void addPost(Map<String, String> post) {
    postDetails.insert(0, post);
    photos.insert(0, post['photo']!);
    posts.value = postDetails.length;
  }

  Future<void> fetchProfile(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/profiles/$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['profile'];
        name.value = data['nama'];
        bio.value = data['bio'];
        profileImage.value = data['foto_profil'];
      } else {
        Get.snackbar('Error', 'Failed to fetch profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Future<void> updateProfile(Map<String, String> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('$apiBaseUrl/profiles/${updatedData["id"]}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedData),
      );
      if (response.statusCode == 200) {
        final updatedProfile = json.decode(response.body)['profile'];
        name.value = updatedProfile['nama'];
        bio.value = updatedProfile['bio'];
        profileImage.value = updatedProfile['foto_profil'];
      } else {
        Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }
}
