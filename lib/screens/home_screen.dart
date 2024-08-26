import 'package:flutter/material.dart';
import 'package:flutter_form/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null || token.isEmpty) {
      // ไม่มี token ให้ไปหน้า Login
     
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      );
    } else {
      // ถ้ามี token ก็อยู่ในหน้าหลักต่อไป
      
    }
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disables the automatic leading widget
        leading: null, // Explicitly set leading to null
      ),
      body: const Text("Home"),
    );
  }
}
