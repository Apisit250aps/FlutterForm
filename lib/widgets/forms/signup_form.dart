import 'package:flutter/material.dart';
import 'package:flutter_form/screens/signin_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> register(BuildContext context) async {
    final url = Uri.parse('https://wallet-api-7m1z.onrender.com/auth/register');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // ถ้าการลงทะเบียนสำเร็จ (เช่นได้รับ HTTP 200)
        final data = jsonDecode(response.body);
        final token = data['token']; // สมมติว่า API คืน token กลับมา
        print('Register successful. Token: $token');
        // คุณสามารถจัดเก็บ token หรือทำการ navigation ไปยังหน้าถัดไปได้ที่นี่
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SigninScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        // ถ้าการลงทะเบียนล้มเหลว
        _showDialog(
          context,
          'Register Failed',
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
          onTap: () => register(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87,
            ),
            child: const Text(
              "Create account",
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
