import 'package:flutter/material.dart';
import 'creataccountcompany_screen.dart';
import 'jobseeker_screen.dart';
import 'myappbar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2EC),
      appBar: MyAppBar(title: "Sign Up"),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ===== Job Seeker Button =====
              SizedBox(
                width: 316,
                height: 72,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobSeekerScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CA6A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: const Text(
                    "Job Seeker",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== Company Account Button =====
              SizedBox(
                width: 316,
                height: 72,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => comopnycreate()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CA6A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: const Text(
                    "Company Account",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
