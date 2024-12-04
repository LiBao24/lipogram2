import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Declare reactive variables
  var name = 'Jovianka Ivy'.obs;
  var username = 'its_ivyyyy'.obs;
  var bio = 'living like i should'.obs;
  var posts = 10.obs; // Example data
  var followers = '500'.obs; // Example data
  var following = 150.obs; // Example data
  var photos = [
    'assets/post-ivy-1.jpg',
    'assets/post-ivy-2.jpg',
    'assets/post-ivy-3.jpg'
  ].obs;
  var profileImage = 'assets/profil-ivy.jpg'.obs;

  var postDetails = <Map<String, String>>[].obs; // Menyimpan detail postingan

  ProfileController() {
    // Tambahkan postingan awal ke postDetails
    for (var photo in photos) {
      postDetails.add({'photo': photo});
    }
    posts.value = postDetails.length; // Perbarui jumlah postingan
  }

  void updateProfile(String newName, String newUsername, String newBio,
      String newProfileImage) {
    name.value = newName;
    username.value = newUsername;
    bio.value = newBio;
    profileImage.value = newProfileImage;
  }

  // Fungsi untuk menambahkan postingan baru
  void addPost(Map<String, String> post) {
    postDetails.insert(0, post); // Tambahkan postingan di awal daftar
    photos.insert(0, post['photo']!); // Tambahkan foto di awal daftar
    posts.value = postDetails.length; // Perbarui jumlah postingan
  }
}
