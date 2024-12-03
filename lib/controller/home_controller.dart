import 'package:get/get.dart';

class HomeController extends GetxController {
  var likes = 500.obs; // Jumlah likes
  var comments = 260.obs; // Jumlah komentar

  // Fungsi untuk menambah jumlah likes
  void likePost() {
    likes.value++;
  }
}
