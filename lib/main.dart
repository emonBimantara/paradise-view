import 'package:firebase_core/firebase_core.dart';
import 'package:paradise_view/Features/Home/View/home_page.dart';
import 'package:paradise_view/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_view/Features/Auth/Controller/auth_controller.dart';
import 'package:paradise_view/Features/Auth/Views/login_page.dart';
import 'package:paradise_view/Features/Auth/Views/register_page.dart';
import 'package:paradise_view/Features/Auth/Views/splash_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthController(), permanent: true);

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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black
        ),
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage())
      ],
    );
  }
}
