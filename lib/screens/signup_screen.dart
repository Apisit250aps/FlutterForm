import 'package:flutter/material.dart';
import 'package:flutter_form/screens/signin_screen.dart';
import 'package:flutter_form/widgets/forms/signup_form.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disables the automatic leading widget
        leading: null, // Explicitly set leading to null
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Get Start absolutely free",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                height: 3,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninScreen()),
                      (Route<dynamic> route) => false,
                    ); // Correctly call Get.to inside the onTap function
                  },
                  splashColor: Colors
                      .blueAccent, // Optional: Add splash color for visual feedback
                  highlightColor: Colors.blue.withOpacity(0.3),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        height: 1.2,
                        color: Colors.green),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 45,
            ),
            const SignUpForm(),
          ],
        ),
      ),
    );
  }
}
