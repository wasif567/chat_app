import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/presentation/core/widgets/custom_textfield.dart';
import 'package:chat/src/presentation/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

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
      body: Form(
        key: _formKey,
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
                  size: kSize.height * 0.1,
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
                      return 'Please enter your email';
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
                          return null;
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
                SizedBox(
                    width: kSize.width,
                    child: PrimaryButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //
                          }
                        },
                        label: "Login")),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouterConstant.registerRoute);
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
  }
}
