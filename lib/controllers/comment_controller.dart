import 'package:get/get.dart';

class CommentController extends GetxController {
  // Daftar komentar menggunakan RxList untuk reaktivitas
  var commentsList = <Map<String, String>>[].obs;

  // Menambahkan komentar
  void addComment(String commentText) {
  if (commentText.isNotEmpty) {  // Memastikan komentar tidak kosong
    commentsList.add({'text': commentText});
  }
}
}
