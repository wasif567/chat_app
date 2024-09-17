import 'dart:developer';

import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/application/auth/auth_bloc.dart';
import 'package:chat/src/application/user/user_bloc.dart';
import 'package:chat/src/application/user/user_event.dart';
import 'package:chat/src/application/user/user_state.dart';
import 'package:chat/src/domain/models/register_user/register_user_model.dart';
import 'package:chat/src/presentation/core/widgets/drawer.dart';
import 'package:chat/src/presentation/core/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    context.read<UserBloc>().add(FetchUsers());
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Theme.of(context).splashColor,
        elevation: 1,
        leadingWidth: 0,
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
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          } else if (state is UserLoaded) {
            return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                itemBuilder: (context, index) {
                  RegisterUserModel user = state.users[index];
                  return UserTile(
                      displayName: user.fullName!,
                      email: user.email!,
                      onTap: () {
                        Navigator.pushNamed(context, RouterConstant.chatRoute, arguments: user);
                      });
                },
                separatorBuilder: (context, index) {
                  return const Padding(padding: EdgeInsets.only(bottom: 8));
                },
                itemCount: state.users.length);
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text('No users found.'));
        }),
      ),
    );
  }
}
