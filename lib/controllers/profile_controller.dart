import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Data profil pengguna
  final username = 'its_ivyyyy'.obs;
  final name = 'Jovianka Ivy'.obs;
  final bio = 'living like i should'.obs;

  // Statistik profil
  final posts = 3.obs;
  final followers = '2,7JT'.obs;
  final following = 0.obs;

  // Daftar foto untuk ditampilkan dalam grid
  final photos = [
    'assets/post-ivy-1.jpg',
    'assets/post-ivy-2.jpg',
    'assets/post-ivy-3.jpg',
  ].obs;
}
