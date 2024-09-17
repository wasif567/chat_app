import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/domain/models/register_user/register_user_model.dart';
import 'package:chat/src/presentation/pages/chat/chat_page.dart';
import 'package:chat/src/presentation/pages/home/home_page.dart';
import 'package:chat/src/presentation/pages/auth/login_page/login_page.dart';
import 'package:chat/src/presentation/pages/auth/register_page/register_page.dart';
import 'package:chat/src/presentation/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash
      case RouterConstant.splashRoute:
        return MaterialPageRoute<SplashPage>(builder: (_) => const SplashPage());
      // Login
      case RouterConstant.loginRoute:
        return MaterialPageRoute<LoginPage>(builder: (_) => const LoginPage());
      // Register
      case RouterConstant.registerRoute:
        final args = settings.arguments as List;
        return MaterialPageRoute<RegisterPage>(builder: (_) => RegisterPage(email: args.first ?? ''));
      //homeRoute
      case RouterConstant.homeRoute:
        return MaterialPageRoute<HomePage>(builder: (_) => const HomePage());
      //chat
      case RouterConstant.chatRoute:
        final args = settings.arguments as RegisterUserModel;
        return MaterialPageRoute<ChatPage>(
            builder: (_) => ChatPage(
                  chatUser: args,
                ));
      default:
        return MaterialPageRoute<Scaffold>(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No route defined for ${settings.name}"),
                  ),
                ));
    }
  }
}
