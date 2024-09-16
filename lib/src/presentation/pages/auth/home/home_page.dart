import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/application/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Theme.of(context).splashColor,
        elevation: 1,
        title: const Text("Home"),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.loggedOut != null) {
                if (state.loggedOut!) {
                  Navigator.pushNamedAndRemoveUntil(context, RouterConstant.loginRoute, (route) => false);
                }
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogOutEvent());
                },
                icon: const Icon(Icons.logout),
              );
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        // child:  ,
      ),
    );
  }
}
