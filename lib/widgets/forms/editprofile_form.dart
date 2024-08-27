import 'dart:io';
import 'package:flutter_form/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class EditprofileForm extends StatefulWidget {
  const EditprofileForm({super.key});

  @override
  State<EditprofileForm> createState() => _EditprofileFormState();
}

class _EditprofileFormState extends State<EditprofileForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String token = "";
  Future<String> _loadToken() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);

      if (await file.exists()) {
        token = await file.readAsString();
      }
      return token;
    } catch (e) {
      // Handle file read error
      return '';
    }
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/token.txt';
  }

  Future<void> editData(BuildContext context) async {
    final auth = await _loadToken();
    final response = await http.post(
      Uri.parse('https://wallet-api-7m1z.onrender.com/user/set/profile'),
      headers: {
        'Authorization': 'Bearer $auth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'fname': _firstNameController.text,
        'lname': _lastNameController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Show dialog warning
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update user data'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First name',
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
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last name',
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
            InkWell(
              onTap: () => editData(context), // Call editData when tapped
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black87,
                ),
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
