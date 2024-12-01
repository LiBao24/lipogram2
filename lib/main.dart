import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/search_controller.dart' as app_controller;
import 'views/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instagram Search Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(app_controller.SearchController());
      }),
      home: const SearchView(),
    );
  }
}