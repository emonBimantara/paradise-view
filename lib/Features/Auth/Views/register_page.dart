import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_view/Components/custom_button.dart';
import 'package:paradise_view/Components/custom_text_field.dart';
import 'package:paradise_view/Features/Auth/Controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffF5F1E8), Color(0xffEDE6D6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 40),

                    Image.asset('assets/activeLogo.png', height: 70),

                    SizedBox(height: 30),

                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Sign up to get started",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    SizedBox(height: 35),

                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Username',
                            controller: usernameController,
                            imageAsset: 'assets/user.png',
                          ),

                          SizedBox(height: 18),

                          CustomTextField(
                            hintText: 'Email',
                            controller: emailController,
                            imageAsset: 'assets/email.png',
                          ),

                          SizedBox(height: 18),

                          CustomTextField(
                            hintText: 'Password',
                            controller: passwordController,
                            imageAsset: 'assets/password.png',
                            obscureText: true,
                          ),

                          SizedBox(height: 30),

                          GestureDetector(
                            onTap: () async {
                              await authController.register(
                                emailController.text.trim(),
                                passwordController.text.trim()
                              );
                            },
                            child: CustomButton(text: 'Register')
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),

                    GestureDetector(
                      onTap: () => Get.toNamed('/login'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7C6A46),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
