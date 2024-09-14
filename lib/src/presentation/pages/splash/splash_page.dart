import 'package:chat/app/router/router_constant.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: FutureBuilder(
            future: authCheck(context),
            builder: (context, snpashot) {
              if (snpashot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                return const SizedBox();
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
