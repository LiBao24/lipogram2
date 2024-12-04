import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';
import '../views/home_view.dart';

class SignUpView extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigasi kembali
          },
        ),
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold, // Ketebalan lebih ringan
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Logo
            Image.asset('assets/logo.png', height: 50),
            const SizedBox(height: 10),
            // Teks "Lipogram"
            Text(
              'lipogram',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            // Nama Pengguna
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nama pengguna',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // Input Nama Pengguna
            TextField(
              onChanged: (value) => controller.usernameController.value = value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Alamat Email
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Alamat email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // Input Email
            TextField(
              onChanged: (value) => controller.emailController.value = value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // Kata Sandi Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kata sandi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // Input Kata Sandi
            TextField(
              onChanged: (value) => controller.passwordController.value = value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            // Tombol Buat Akun
            ElevatedButton(
              onPressed: () {
                // Periksa apakah semua field sudah terisi
                if (controller.usernameController.value.isEmpty ||
                    controller.emailController.value.isEmpty ||
                    controller.passwordController.value.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Semua field harus diisi!",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  Get.to(
                      HomeView()); // Navigasi ke HomePage setelah berhasil sign up
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF469FC0),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Buat Akun',
                style: TextStyle(
                  color: Colors.white, // Mengubah warna teks menjadi putih
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tombol Sudah Punya Akun
            OutlinedButton(
              onPressed: () {
                // Navigasi kembali ke halaman login
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Color(0xFF469FC0)),
              ),
              child: Text(
                'Sudah punya akun',
                style: TextStyle(color: Color(0xFF469FC0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
