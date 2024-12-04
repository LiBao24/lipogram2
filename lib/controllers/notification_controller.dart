import 'package:get/get.dart';

class NotificationItem {
  String username;
  String action;
  DateTime timestamp;
  String profileImageUrl; // Tambahkan URL gambar profil

  NotificationItem({
    required this.username,
    required this.action,
    required this.timestamp,
    required this.profileImageUrl, // Tambahkan parameter ini pada konstruktor
  });

  // Fungsi untuk menghitung waktu relatif (misal: "2 minggu yang lalu")
  String getRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks mg';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} hr';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} j';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} m';
    } else {
      return 'Baru saja';
    }
  }
}

// Controller untuk mengelola notifikasi
class NotificationController extends GetxController {
  // Daftar notifikasi (menghapus yang berkaitan dengan "mengikuti")
  var notifications = <NotificationItem>[
    NotificationItem(
      username: 'nashya',
      action: 'mulai mengikuti Anda',
      timestamp: DateTime.now().subtract(Duration(days: 14)), // 2 minggu lalu
      profileImageUrl: 'assets/profil-nashya.jpg', // Gambar dari assets
    ),
    NotificationItem(
      username: 'lie_p01',
      action: 'mulai mengikuti Anda',
      timestamp: DateTime.now().subtract(Duration(days: 10)), // 10 hari lalu
      profileImageUrl: 'assets/profil-nashya.jpg', // Gambar dari assets
    ),
    NotificationItem(
      username: 'naila',
      action: 'menyukai postingan Anda',
      timestamp: DateTime.now().subtract(Duration(hours: 5)), // 5 jam lalu
      profileImageUrl: 'assets/profil-nashya.jpg', // Gambar dari assets
    ),
    NotificationItem(
      username: 'cars3nn_',
      action: 'menyukai postingan Anda',
      timestamp:
          DateTime.now().subtract(Duration(minutes: 30)), // 30 menit lalu
      profileImageUrl: 'assets/profil-nashya.jpg', // Gambar dari assets
    ),
    NotificationItem(
      username: 'jesica_r',
      action: 'mengomentari postingan Anda',
      timestamp: DateTime.now().subtract(Duration(days: 1)), // 1 hari lalu
      profileImageUrl: 'assets/profil-nashya.jpg', // Gambar dari assets
    ),
    NotificationItem(
      username: 'raisa_monn',
      action: 'mulai mengikuti Anda',
      timestamp: DateTime.now().subtract(Duration(minutes: 0)), // 1 minggu lalu
      profileImageUrl: 'assets/profil-nashya.jpg', // Gambar dari assets
    ),
  ].obs;
}
