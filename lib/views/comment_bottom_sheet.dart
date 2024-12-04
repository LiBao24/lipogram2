import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/comment_controller.dart';

class CommentBottomSheet extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final CommentController commentControllerGet = Get.put(CommentController());

  CommentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Menyembunyikan keyboard saat menekan di luar teks field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, // Mengatur latar belakang menjadi transparan
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding untuk menghindari elemen terlalu dekat dengan tepi
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75, // Membuat popup lebih tinggi (75% dari tinggi layar)
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0), // Menambahkan radius sudut untuk desain yang lebih halus
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Komentar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Daftar komentar menggunakan Obx
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: commentControllerGet.commentsList.length,
                        itemBuilder: (context, index) {
                          final comment = commentControllerGet.commentsList[index];
                          return _buildCommentTile(comment['text']!);
                        },
                      ),
                    ),
                  ),

                  // Input komentar dan tombol kirim
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              labelText: 'Tambahkan komentar',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            // Menambahkan komentar setelah tombol kirim ditekan
                            if (commentController.text.trim().isNotEmpty) {
                              commentControllerGet.addComment(commentController.text);
                              commentController.clear(); // Membersihkan teks setelah mengirim
                            }
                          },
                          icon: const Icon(Icons.send),
                          color: Colors.blue,
                          tooltip: 'Kirim komentar',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentTile(String comment) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/profile/nashya.png'),
        radius: 15,
      ),
      title: const Text(
        'its_ivyyyy',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(comment),
    );
  }
}
