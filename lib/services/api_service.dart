import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/api_url.dart';

class ApiService {
  static const String baseUrl = "$apiBaseUrl"; // Ganti dengan URL API Anda

  // Register User
  static Future<Map<String, dynamic>> registerUser(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    return _handleResponse(response);
  }

  // Login User
  static Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    return _handleResponse(response);
  }

  // Logout User
  static Future<Map<String, dynamic>> logoutUser() async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/logout'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  // Get User Details
  static Future<Map<String, dynamic>> getUserDetails(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  // Update Profile
  static Future<Map<String, dynamic>> updateProfile(
      int id, Map<String, dynamic> profileData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profileData),
    );
    return _handleResponse(response);
  }

  // Get Notifications
  static Future<List<dynamic>> getNotifications(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notifications/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response)['notifications'];
  }

  // Get All Posts
  static Future<List<dynamic>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response)['posts'];
  }

  // Create Post
  static Future<Map<String, dynamic>> createPost(
      Map<String, dynamic> postData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(postData),
    );
    return _handleResponse(response);
  }

  // Delete Post
  static Future<Map<String, dynamic>> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  // Get Comments by Post ID
  static Future<List<dynamic>> getComments(int postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/$postId'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response)['comments'];
  }

  // Add Comment
  static Future<Map<String, dynamic>> addComment(
      Map<String, dynamic> commentData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(commentData),
    );
    return _handleResponse(response);
  }

  // Like a Post
  static Future<Map<String, dynamic>> likePost(
      Map<String, dynamic> likeData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/likes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(likeData),
    );
    return _handleResponse(response);
  }

  // Search Users
  static Future<List<dynamic>> searchUsers(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search?query=$query'),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response)['results'];
  }

  // Helper Function to Handle Response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseData;
    } else {
      throw Exception(responseData['message'] ?? 'Error occurred');
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/$endpoint'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // POST Request
  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // PUT Request
  Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$apiBaseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // DELETE Request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$apiBaseUrl/$endpoint'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
