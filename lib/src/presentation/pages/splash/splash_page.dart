import 'dart:developer';

import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/presentation/pages/auth/login_page/login_page.dart';
import 'package:chat/src/presentation/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              log("${snapshot.data != null ? snapshot.data!.email : ""}");
              if (snapshot.data != null) {
                return const HomePage();
              } else {
                return const LoginPage();
              }
            }),
      ),
    );
  }

  Future<void> authCheck(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, RouterConstant.loginRoute, (route) => false);
    }
  }
}
