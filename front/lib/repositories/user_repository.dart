import 'dart:convert';
import 'package:food_delivery_app/services/api_services.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<User> loginUser(String email, String password) async {
    try {
      final response = await apiService.loginUser(email, password);

      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final token = data['token'];
        print("User TOKEN: $token");
        print("User : ${data['user']}");
        print("User JSON format : ${User.fromJson(data['user'])}");
        // Store the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        print("Token from app : ${prefs.getString('authToken')}");

        return User.fromJson(data['user']);
      } else {
        final errorData = jsonDecode(response.body);
        throw errorData['message']; // Throw only the message
      }
    } catch (e) {
      throw e
          .toString()
          .replaceFirst('Exception: ', ''); // Clean up the message
    }
  }

  Future<User> registerUser(
    String fullname,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await apiService.registerUser(
        fullname,
        email,
        password,
        confirmPassword,
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final token = data['token'];
        print("User data: ${data['user']}");
        print("User TOKEN: $token");

        // Store the token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        print("Token from app : ${prefs.getString('authToken')}");

        return User.fromJson(data['user']);
      } else {
        throw Exception('Failed to register user: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    final fullname = prefs.getString('userFullname');
    final email = prefs.getString('userEmail');
    final token = prefs.getString('authToken');

    if (id != null && fullname != null && email != null && token != null) {
      return User(id: id, fullname: fullname, email: email, token: token);
    } else {
      throw Exception('User details not found in SharedPreferences');
    }
  }
}
