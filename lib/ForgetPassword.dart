import 'package:flutter/material.dart';

import 'changepassword.dart';
import 'myappbar.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2EC),
      appBar: MyAppBar(title: "Sign Up"),
      /*AppBar(
        backgroundColor: const Color(0xFF73946B),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.25),
        toolbarHeight: 80,
        titleSpacing: 0,

        // زر الرجوع
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Forget Password",
                style: TextStyle(
                  fontFamily: 'Aleo',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                "assets/images/logo.png",
                width: 60,
                height: 57,
              ),
            ),
          ],
        ),
      ),
*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Aleo',
                      color: const Color(0xFF73946B),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color(0x49000000),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                _buildInputField("Enter your username"),

                const SizedBox(height: 60),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Aleo',
                      color: const Color(0xFF73946B),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color(0x49000000),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                _buildInputField("Enter your email"),

                const SizedBox(height: 60),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ID number',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Aleo',
                      color: const Color(0xFF73946B),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color(0x49000000),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                _buildInputField("Enter your ID number"),

                const SizedBox(height: 60),

                Center(
                  child: SizedBox(
                    width: 362,
                    height: 49,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => changepassswordscreen(),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF73946B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.25),
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          fontFamily: 'Aleo',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Aleo',
            fontSize: 18,
            color: Colors.black.withOpacity(0.4),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
