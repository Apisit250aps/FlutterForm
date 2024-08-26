// api_service.dart
import 'dart:convert';
import 'package:flutter_form/models/user_modal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://wallet-api-7m1z.onrender.com/user/information';
  

  Future<User> fetchUserData() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer',
        'Content-Type': 'application/json', // Optional, depending on your API
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
