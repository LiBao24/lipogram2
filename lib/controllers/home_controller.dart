import 'package:get/get.dart';

class HomeController extends GetxController {
  var likesList = <Map<String, String>>[].obs;
  var commentsList = <Map<String, String>>[].obs;

  var isLiked = false.obs;
  var likes = 0.obs;
  var comments = 0.obs;

  void toggleLike() {
    if (isLiked.value) {
      isLiked.value = false;
      likes.value--;
      likesList.removeWhere((user) => user['username'] == 'its_ivyyyy');
    } else {
      isLiked.value = true;
      likes.value++;
      likesList.add({
        'username': 'its_ivyyyy',
        'profilePic': 'assets/profile/user3.png',
      });
    }
  }

  void addComment(Map<String, String> comment) {
    commentsList.add(comment);
    comments.value++;
  }
}
