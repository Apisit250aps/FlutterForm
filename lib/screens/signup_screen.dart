import 'package:flutter/material.dart';
import 'package:flutter_form/widgets/forms/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Get Start absolutely free",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                height: 3,
              ),
            ),
            Text(
              "Already have an account?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
