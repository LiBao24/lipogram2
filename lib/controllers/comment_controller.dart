import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  var comments = <String>[].obs; // Menyimpan daftar komentar

  // Fungsi untuk menambah komentar
  void addComment(String comment) {
    if (comment.isNotEmpty) {
      comments.add(comment); // Menambahkan komentar ke dalam list
    }
  }
}

class CommentBottomSheet extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final CommentController commentControllerGet = Get.put(CommentController());

  CommentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar ukuran bottom sheet minimal
        children: [
          const Text(
            'Komentar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Gunakan ListView yang di-scroll
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: commentControllerGet.comments.length,
                itemBuilder: (context, index) {
                  // Menampilkan komentar dari daftar
                  return _buildCommentTile(commentControllerGet.comments[index]);
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Input untuk menambah komentar
          TextField(
            controller: commentController,
            decoration: InputDecoration(
              labelText: 'Tambahkan komentar untuk nashya',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          
          const SizedBox(height: 10),

          // Tombol untuk mengirim komentar
          ElevatedButton(
            onPressed: () {
              // Menambah komentar ke daftar
              commentControllerGet.addComment(commentController.text);
              commentController.clear(); // Membersihkan input setelah komentar ditambahkan
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(String comment) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/profile/nashya.png'), // Ganti dengan gambar profil yang sesuai
        radius: 15,
      ),
      title: const Text(
        'nashya',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(comment),
    );
  }
}
