import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var likesList = <Map<String, String>>[].obs;
  var commentsList = <Map<String, String>>[].obs;

  var isLiked = false.obs;
  var likes = 0.obs;
  var comments = 0.obs;

  var hasPost = false.obs;
  
  var username = ''.obs;
  var profileImage = ''.obs;

  final ProfileController profileController = Get.put(ProfileController());

  @override
  void onInit() async {
    super.onInit();
    int userId = await getUserIdFromPreferences();
    profileController.fetchProfile(userId);
    ever(profileController.profileImage, (callback) {
      profileImage.value = profileController.profileImage.value;
      username.value = profileController.name.value;
    });
  }

  Future<int> getUserIdFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0;
  }

  void toggleLike() {
    if (isLiked.value) {
      isLiked.value = false;
      likes.value--;
      likesList.removeWhere((user) => user['username'] == username.value);
    } else {
      isLiked.value = true;
      likes.value++;
      likesList.add({
        'username': username.value,
        'profilePic': profileImage.value,
      });
    }
  }

  void addComment(Map<String, String> comment) {
    commentsList.add(comment);
    comments.value++;
  }

  void createPost() {
    hasPost.value = true;
  }

  void deletePost() {
    hasPost.value = false;
    isLiked.value = false;
    likes.value = 0;
    comments.value = 0;
    likesList.clear();
    commentsList.clear();
  }
}