import 'package:get/get.dart';
import '../models/user_model.dart';

class SearchController extends GetxController {
  var searchText = ''.obs;
  var recentSearches = <User>[].obs; 
  var filteredUsers = <User>[].obs; 

  final allUsers = [
    User(
      id: '1',
      username: 'nashya',
      fullName: 'Nashya Fildza',
      profileImage: 'assets/profile1.jpg',
      posts: 10,
      followers: 10,
      following: 500,
      images: [],
    ),
    User(
      id: '2',
      username: 'lie_p01',
      fullName: 'Liepo',
      profileImage: 'assets/profile2.jpg',
      posts: 5,
      followers: 15,
      following: 190,
      images: [],
    ),
    User(
      id: '3',
      username: 'naila',
      fullName: 'Naila Winingtyas',
      profileImage: 'assets/profile3.jpg',
      posts: 6,
      followers: 10,
      following: 0,
      images: ['assets/post1.jpg', 'assets/post2.jpg', 'assets/post3.jpg'],
    ),
    User(
      id: '4',
      username: 'cars3nn_',
      fullName: 'Carsen Aja',
      profileImage: 'assets/profile4.jpg',
      posts: 65,
      followers: 10,
      following: 78,
      images: [],
    ),
    User(
      id: '5',
      username: 'jesica_r',
      fullName: 'Jesica Reinanda',
      profileImage: 'assets/profile5.jpg',
      posts: 1,
      followers: 5,
      following: 557,
      images: [],
    ),
    User(
      id: '6',
      username: 'raisa_monn',
      fullName: 'Raisa Monica',
      profileImage: 'assets/profile6.jpg',
      posts: 0,
      followers: 1,
      following: 504,
      images: [],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi riwayat pencarian dengan semua pengguna
    recentSearches.value = [...allUsers];
  }

  void search(String query) {
    searchText.value = query;
    if (query.isEmpty) {

      filteredUsers.clear();
    } else {

      filteredUsers.value = allUsers
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()) ||
              user.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void removeFromRecent(User user) {
    recentSearches.remove(user);
  }

  void addToRecent(User user) {
    recentSearches.remove(user);

    recentSearches.insert(0, user);
  }

  List<User> getDisplayedUsers() {
    if (searchText.isEmpty) {
      return recentSearches;
    } else {
      return filteredUsers;
    }
  }
}