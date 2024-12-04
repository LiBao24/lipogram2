import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends StatelessWidget {
  // Instantiate the controller
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold, // Ketebalan lebih ringan
          ),
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            var notification = controller.notifications[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(notification
                    .profileImageUrl), // Menggunakan gambar profil dari assets
                backgroundColor:
                    Colors.grey, // Placeholder color jika gambar tidak ada
                child: notification.profileImageUrl.isEmpty
                    ? Text(notification.username[0]
                        .toUpperCase()) // Menampilkan inisial jika tidak ada gambar
                    : null,
              ),
              title: Text(notification.username),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.action),
                  Text(
                    notification.getRelativeTime(), // Menampilkan waktu relatif
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
