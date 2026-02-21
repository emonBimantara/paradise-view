import 'package:flutter/material.dart';
import 'package:paradise_view/Features/Auth/Views/login_page.dart';
import 'package:paradise_view/Features/Auth/Views/register_page.dart';
import 'package:paradise_view/Features/Auth/Views/splash_page.dart';
import 'package:paradise_view/Features/Home/View/home_page.dart';
import 'package:paradise_view/Features/Rooms/Views/room_page.dart';
import 'package:paradise_view/Routes/app_routes.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashPage:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case AppRoutes.loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.roomPage:
        return MaterialPageRoute(builder: (_) => RoomPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }
}
