import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class EditProfileController extends GetxController {
  // Default data
  var name = 'Jovianka Ivy'.obs;
  var username = 'its_ivyyyy'.obs;
  var bio = 'living like i should'.obs;
  var profileImage = 'assets/image/profile.png'.obs;

  // Fungsi untuk memperbarui nama
  void updateName(String newName) => name.value = newName;

  // Fungsi untuk memperbarui nama pengguna
  void updateUsername(String newUsername) => username.value = newUsername;

  // Fungsi untuk memperbarui bio
  void updateBio(String newBio) => bio.value = newBio;

  // Fungsi untuk memperbarui foto profil
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = image.path; // Menyimpan path file gambar
    }
  }
}
