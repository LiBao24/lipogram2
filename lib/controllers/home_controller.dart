import 'package:get/get.dart';

class HomeController extends GetxController {
  var likes = 500.obs; // Jumlah likes
  var isLiked = false.obs; // Status apakah sudah di-like atau belum
  var comments = 260.obs; // Jumlah komentar

  void toggleLike() {
    if (isLiked.value) {
      // Jika sudah di-like, unlike dan kurangi jumlah likes
      isLiked.value = false;
      likes.value--;
    } else {
      // Jika belum di-like, like dan tambahkan jumlah likes
      isLiked.value = true;
      likes.value++;
    }
  }
}
