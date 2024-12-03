import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/login_view.dart';
import 'package:lipogram/view/profile_view.dart';
import 'package:lipogram/view/home_view.dart';

void main() {
  runApp(MyApp());
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
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile', page: () => ProfileView()),
      ],
    );
  }
}
