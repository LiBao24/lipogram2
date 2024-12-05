import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  var name = ''.obs;
  var username = ''.obs;
  var bio = ''.obs;
  var profileImage = ''.obs;

  void updateName(String newName) => name.value = newName;

  void updateUsername(String newUsername) => username.value = newUsername;

  void updateBio(String newBio) => bio.value = newBio;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = image.path;
    }
  }

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId == null) {
      throw Exception('User not logged in');
    }
    return userId;
  }

  Future<void> fetchProfile() async {
    try {
      final userId = await _getUserId();
      final response = await http.get(Uri.parse('$apiBaseUrl/profiles/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['profile'];
        name.value = data['nama'];
        username.value = data['username'];
        bio.value = data['bio'];
        profileImage.value = data['foto_profil'];
      } else {
        Get.snackbar('Error', 'Failed to fetch profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Future<void> updateProfile() async {
    try {
      final userId = await _getUserId();
      Map<String, String> updatedData = {
        'id': userId.toString(),
        'nama': name.value,
        'bio': bio.value,
        'foto_profil': profileImage.value,
      };

      final response = await http.put(
        Uri.parse('$apiBaseUrl/profiles/$userId'),
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
