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
      profileImage: 'assets/images/profile1.jpg',
      posts: 10,
      followers: 10,
      following: 500,
      images: [],
    ),
    User(
      id: '2',
      username: 'lie_p01',
      fullName: 'Liepo',
      profileImage: 'assets/images/profile2.jpg',
      posts: 5,
      followers: 15,
      following: 190,
      images: [],
    ),
    User(
      id: '3',
      username: 'naila',
      fullName: 'Naila Winingtyas',
      profileImage: 'assets/images/profile3.jpg',
      posts: 6,
      followers: 10,
      following: 0,
      images: ['assets/images/post1.jpg', 'assets/images/post2.jpg', 'assets/images/post3.jpg'],
    ),
    User(
      id: '4',
      username: 'cars3nn_',
      fullName: 'Carsen Aja...',
      profileImage: 'assets/images/profile4.jpg',
      posts: 65,
      followers: 10,
      following: 78,
      images: [],
    ),
  ];

  @override
  void onInit() {
    super.onInit();

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