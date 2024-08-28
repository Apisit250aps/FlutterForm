import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form/screens/home_screen.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String _fileContent = "";

  @override
  void initState() {
    super.initState();
    _readFromFile();
    print(_fileContent);
  }

  Future<void> login(BuildContext context) async {
    // Validate username and password
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty) {
      _showDialog(context, 'Validation Error', 'Username cannot be empty.');
      return;
    }

    if (password.isEmpty) {
      _showDialog(context, 'Validation Error', 'Password cannot be empty.');
      return;
    }

    if (password.length < 6) {
      _showDialog(context, 'Validation Error',
          'Password must be at least 6 characters long.');
      return;
    }

    final url = Uri.parse('https://wallet-api-7m1z.onrender.com/auth/login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] as String?;
        if (token != null) {
          print('Login successful. Token: $token');
          await _writeToFile(token);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );
        } else {
          _showDialog(context, 'Login Error', 'Token not received.');
        }
      } else {
        _showDialog(
          context,
          'Login Failed',
          'Status: ${response.statusCode}\nResponse: ${response.body}',
        );
      }
    } catch (e) {
      _showDialog(context, 'Error', 'An error occurred: $e');
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();

    return '${directory.path}/token.txt';
  }

  Future<void> _writeToFile(String content) async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    await file.writeAsString(content);
    setState(() {
      _fileContent = content;
    });
  }

  Future<void> _readFromFile() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      final content = await file.readAsString();
      print('>>> $content');
      setState(() {
        _fileContent = content;
      });
    } catch (e) {
      setState(() {
        _fileContent = "Error reading file: $e";
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            floatingLabelStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 25,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black87),
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            floatingLabelStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
            labelText: 'Password',
            hintText: '6+ characters',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 25,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black87),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        InkWell(
          onTap: () => login(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87,
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Divider(
          height: 50,
        )
      ],
    );
  }
}
