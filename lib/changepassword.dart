import 'package:flutter/material.dart';

import 'myappbar.dart';

class changepassswordscreen extends StatefulWidget {
  const changepassswordscreen({super.key});

  @override
  State<changepassswordscreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<changepassswordscreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  String? passwordError;
  String? confirmError;

  void _submit() {
    setState(() {
      passwordError = null;
      confirmError = null;

      String password = passwordController.text.trim();
      String confirm = confirmController.text.trim();

      if (password.length < 8) {
        passwordError = "Password must be at least 8 characters";
      }
      if (confirm != password) {
        confirmError = "Passwords do not match";
      }

      if (passwordError == null && confirmError == null) {
        // Show success dialog

        showDialog(
          context: context,
          builder: (_) => Center(
            child: Center(
              child: Center(
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: SizedBox(
                    width: 356,
                    height: 391,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 100,
                          left: 122,
                          child: Container(
                            width: 92,
                            height: 92,
                            decoration: BoxDecoration(
                              color: const Color(0xFF73946B),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Image.asset("assets/images/tru.png"),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 220,
                          left: 80,
                          child: SizedBox(
                            width: 176,
                            height: 33,
                            child: const Text(
                              "Successfully",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Adamina",
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 280,
                          left: 50,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, "home");
                            },
                            child: Container(
                              width: 237,
                              height: 43,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF73946B),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                  fontFamily: "Adamina",
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Sign Up"),
      /*AppBar(
        backgroundColor: const Color(0xFF73946B),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.25),
        toolbarHeight: 80,
        titleSpacing: 0,
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
                "Change Password",
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
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "New Password",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Aleo',
                  color: Color(0xFF73946B),
                ),
              ),
              const SizedBox(height: 10),
              _buildInputField(
                passwordController,
                "Enter your new password",
                errorText: passwordError,
                obscure: true,
              ),
              const SizedBox(height: 30),
              const Text(
                "Confirm New Password",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Aleo',
                  color: Color(0xFF73946B),
                ),
              ),
              const SizedBox(height: 10),
              _buildInputField(
                confirmController,
                "Confirm new password",
                errorText: confirmError,
                obscure: true,
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF73946B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text(
                      "Change Password",
                      style: TextStyle(
                        fontFamily: 'Aleo',
                        fontSize: 20,
                        color: Colors.white,
                      ),
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

  Widget _buildInputField(
    TextEditingController controller,
    String hint, {
    String? errorText,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 55,
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
            controller: controller,
            obscureText: obscure,
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
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
      ],
    );
  }
}
