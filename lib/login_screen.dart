import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'Home_Screen.dart';
import 'ForgetPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // ===== Title + Logo =====
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'LogIn',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF73946B),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ===== Login Card =====
              Form(
                key: _formKey,
                child: Container(
                  width: 396,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== Username =====
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                        width: 370,
                        height: 56,
                        child: TextFormField(
                          controller: emailController,
                          style: const TextStyle(
                            fontFamily: 'JosefinSans',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your username',
                            hintStyle: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                color: Color(0xFF4CA6A8),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                color: Color(0xFF4CA6A8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                color: Color(0xFF4CA6A8),
                              ),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Username is required' : null,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ===== Password =====
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                        width: 370,
                        height: 56,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(
                            fontFamily: 'JosefinSans',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                color: Color(0xFF4CA6A8),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                color: Color(0xFF4CA6A8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                color: Color(0xFF4CA6A8),
                              ),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ===== Remember + Forget =====
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                activeColor: const Color(0xFF4CA6A8),
                                onChanged: (v) =>
                                    setState(() => rememberMe = v!),
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontSize: 15,
                                  color: Color(0xFF867F7F),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                fontFamily: 'JosefinSans',
                                fontSize: 14,
                                color: Color(0xFF867F7F),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // ===== Divider =====
                      Center(
                        child: Container(
                          width: 201,
                          height: 2,
                          color: const Color(0xFF867F7F).withOpacity(0.3),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ===== Login Button =====
                      Center(
                        child: SizedBox(
                          width: 362,
                          height: 49,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CA6A8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      userName: emailController.text.trim(),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'JosefinSans',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ===== Google Button =====
                      Center(
                        child: SizedBox(
                          width: 362,
                          height: 47,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.5),
                              side: const BorderSide(color: Color(0xFF404040)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/g.png',
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Continue With Google',
                                  style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===== Sign Up =====
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontFamily: 'JosefinSans', fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: const Text(
                      'Sign UP',
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 14,
                        color: Color(0xFF4CA6A8),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
