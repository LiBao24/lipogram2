import 'package:get/get.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserController extends GetxController {
  final ApiService apiService = ApiService();
  var user = User(
    idUser: 0,
    username: '',
    email: '',
    password: '',
  ).obs;

  Future<void> fetchUser(int userId) async {
    try {
      var response = await apiService.get('user/$userId');
      user.value = User.fromJson(response);
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  Future<void> updateUser(Map<String, dynamic> updatedData) async {
    try {
      var response = await apiService.post('user/update', updatedData);
      user.value = User.fromJson(response);
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}
