import 'package:flutter/material.dart';
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

  Future<void> register() async {
    final url = Uri.parse(
        'https://wallet-api-7m1z.onrender.com/auth/register'); // แทนที่ด้วย URL ของ API จริง

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': _usernameController.text, // ใช้ .text เพื่อดึงค่า
          'password': _passwordController.text, // ใช้ .text เพื่อดึงค่า
        }),
      );

      if (response.statusCode == 200) {
        // ถ้าการล็อกอินสำเร็จ (เช่นได้รับ HTTP 200)
        final data = jsonDecode(response.body);
        final token = data['token']; // สมมติว่า API คืน token กลับมา
        print('register successful. Token: $token');
        // คุณสามารถจัดเก็บ token หรือทำการ navigation ไปยังหน้าถัดไปได้ที่นี่
      } else {
        // ถ้าการล็อกอินล้มเหลว (เช่นได้รับ HTTP 401)
        print('register failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
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
          onTap: () => register(),
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
