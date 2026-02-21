import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_view/Features/Auth/Views/login_page.dart';
import 'package:paradise_view/Features/Auth/Views/register_page.dart';
import 'package:paradise_view/Features/Auth/Views/splash_page.dart';
import 'package:paradise_view/Features/History/Views/history_page.dart';
import 'package:paradise_view/Features/Home/View/home_page.dart';
import 'package:paradise_view/Features/Rooms/Views/checkout_page.dart';
import 'package:paradise_view/Features/Rooms/Views/room_page.dart';
import 'package:paradise_view/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paradise View',
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/room', page: () => const RoomPage()),
        GetPage(name: '/checkout', page: () => const CheckoutPage()),
        GetPage(name: '/history', page: () => const HistoryPage())
      ],
    );
  }
}