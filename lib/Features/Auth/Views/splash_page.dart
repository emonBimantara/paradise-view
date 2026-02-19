import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_view/Features/Auth/Controller/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.put(AuthController(), permanent: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7C6A46),
      body: Center(child: Image.asset('assets/logo.png', height: 40)),
    );
  }
}
