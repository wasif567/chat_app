import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/application/auth/auth_bloc.dart';
import 'package:chat/src/application/user/user_bloc.dart';
import 'package:chat/src/application/user/user_event.dart';
import 'package:chat/src/presentation/core/widgets/custom_textfield.dart';
import 'package:chat/src/presentation/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _obscureText = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (!state.isLoading! && state.responseMsg!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
                content: Row(
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Colors.white,
                    ),
                    Text(state.responseMsg!),
                  ],
                )));
          }
          if (state.loggedIn!) {
            Navigator.pushReplacementNamed(context, RouterConstant.homeRoute);
            context.read<UserBloc>().add(FetchUsers());
          }

          if (state.code == "invalid-credential") {
            Navigator.pushReplacementNamed(context, RouterConstant.registerRoute,
                arguments: [_emailController.text]);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: kSize.height,
                width: kSize.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 3),
                      Icon(
                        Icons.message,
                        size: kSize.height * 0.05,
                        color: Theme.of(context).primaryColor,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Text(
                        "Welcome Back!",
                      ),
                      const Spacer(),
                      CustomTextField(
                        hint: 'Email',
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }

                          if (!(value.contains("@") && value.contains(".com"))) {
                            return 'Invalid email address';
                          }

                          return null;
                        },
                      ),
                      // const Spacer(),
                      ValueListenableBuilder<bool>(
                          valueListenable: _obscureText,
                          builder: (context, value, child) {
                            return CustomTextField(
                              controller: _passwordController,
                              hint: 'Password',
                              obscureText: _obscureText.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 7) {
                                  return "Password required minimum 6 letters or digit";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                if (_formKey.currentState!.validate()) {
                                  //
                                  context.read<AuthBloc>().add(LoginAuth(context,
                                      email: _emailController.text, password: _passwordController.text));
                                }
                              },
                              suffixIcon: InkWell(
                                onTap: () {
                                  _obscureText.value = !_obscureText.value;
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }),
                      const Spacer(),
                      state.isLoading!
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : SizedBox(
                              width: kSize.width,
                              child: PrimaryButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      //
                                      context.read<AuthBloc>().add(LoginAuth(context,
                                          email: _emailController.text, password: _passwordController.text));
                                    }
                                  },
                                  label: "Login")),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouterConstant.registerRoute, arguments: [""]);
                        },
                        child: const Text("Not an user? Register."),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
