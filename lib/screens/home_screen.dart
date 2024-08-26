import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form/models/user_modal.dart';
import 'package:flutter_form/screens/signin_screen.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String token = "";
  late Future<User> futureUser;

  final String apiUrl = 'https://wallet-api-7m1z.onrender.com/user/information';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadToken();
    if (token.isNotEmpty) {
      print(token);
      setState(() {
        futureUser = fetchUserData();
      });
    } else {
      Get.to(const SigninScreen());
    }
  }

  Future<void> _loadToken() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        token = await file.readAsString();
      }
    } catch (e) {
      // Handle file read error
      token = '';
    }
  }

  Future<void> _writeToFile(String content) async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    await file.writeAsString(content);
    setState(() {
      token = content;
    });
  }

  Future<void> _logout() async {
    _writeToFile('');
    _initialize();
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/token.txt';
  }

  Future<User> fetchUserData() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disables the automatic leading widget
        leading: null, // Explicitly set leading to null
        title: const Text('User Information'),
        actions: [
          IconButton(onPressed: _logout, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            } else {
              final user = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ID: ${user.id}'),
                    Text('Username: ${user.username}'),
                    Text('First Name: ${user.fname}'),
                    Text('Last Name: ${user.lname}'),
                    Text('Admin: ${user.isAdmin}'),
                    Text('Created At: ${user.createdAt}'),
                    Text('Updated At: ${user.updatedAt}'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
