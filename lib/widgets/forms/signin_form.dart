import 'package:flutter/material.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
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
          onTap: null,
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
