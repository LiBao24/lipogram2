import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_service.dart';
import '../views/login_view.dart';

class SignupController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading.value = true;

      // Validasi input kosong
      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        Get.snackbar(
          "Error",
          "Semua field harus diisi",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Panggil API register menggunakan ApiService
      final response = await ApiService.registerUser(username, email, password);

      if (response['status'] == true) {
        // Berhasil registrasi, arahkan ke halaman login
        Get.offAll(() => LoginView());
      } else {
        Get.snackbar(
          "Error",
          response['message'] ?? "Registrasi gagal, periksa input Anda",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat registrasi: ${e.toString()}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
