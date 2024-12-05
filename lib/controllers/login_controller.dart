import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';
import '../views/home_view.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;

      final username = usernameController.text.trim();
      final password = passwordController.text.trim();

      // Validasi input kosong
      if (username.isEmpty || password.isEmpty) {
        Get.snackbar(
          "Error",
          "Username dan password tidak boleh kosong",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Panggil fungsi login dari ApiService
      final response = await ApiService.loginUser(username, password);

      if (response['status'] == true) {
        final userId = response['data']['user_id'];

        // Simpan user_id ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', userId);

        // Navigasi ke HomeView
        Get.offAll(() => HomeView());
      } else {
        Get.snackbar(
          "Error",
          response['message'] ?? "Login gagal, periksa username dan password",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan: ${e.toString()}",
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
    passwordController.dispose();
    super.onClose();
  }
}
