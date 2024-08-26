import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form/screens/signin_screen.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _checkToken() async {
    final token = _readFromFile();
    if (token == '' || token == null) {
      Get.to(SigninScreen());
    }
  }

  String _fileContent = "";

  @override
  void initState() {
    super.initState();

    _checkToken();
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
