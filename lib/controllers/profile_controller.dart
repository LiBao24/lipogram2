import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Declare reactive variables
  var name = 'Jovianka Ivy'.obs;
  var username = 'its_ivyyyy'.obs;
  var bio = 'living like i should'.obs;
  var posts = 10.obs; // Example data
  var followers = '500'.obs; // Example data
  var following = 150.obs; // Example data
  var photos =
      ['assets/photo1.jpg', 'assets/photo2.jpg', 'assets/photo3.jpg'].obs;
  var profileImage = 'assets/image/profile.png'.obs;

  // Method to update profile data
  void updateProfile(String newName, String newUsername, String newBio,
      String newProfileImage) {
    name.value = newName;
    username.value = newUsername;
    bio.value = newBio;
    profileImage.value = newProfileImage;
  }
}
