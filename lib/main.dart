import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/login_view.dart';
import 'package:lipogram/views/profile_view.dart';
import 'package:lipogram/views/home_view.dart';
import 'package:lipogram/views/photo_view.dart';
import 'package:lipogram/views/posting_view.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lipogram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: LoginView(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/home', page: () => HomeView()),
        GetPage(name: '/addPost', page: () => PhotoPickerScreen()),
        GetPage(name: '/addPost2', page: () => ShareScreen()),
        GetPage(name: '/profile', page: () => ProfileView()),
      ],
    );
  }
}

Future<void> requestPermissions() async {
  // Meminta izin kamera
  if (await Permission.camera.isDenied) {
    await Permission.camera.request();
  }

  // Meminta izin akses galeri
  if (await Permission.photos.isDenied) {
    await Permission.photos.request();
  }
}
