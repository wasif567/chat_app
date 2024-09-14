import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/application/country_bloc/country_bloc.dart';
import 'package:chat/src/presentation/core/widgets/country_dropdown.dart';
import 'package:chat/src/presentation/core/widgets/custom_textfield.dart';
import 'package:chat/src/presentation/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();

  final _obscureText = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted && context.mounted) {
        context.read<CountryBloc>().add(GetCountryEvent());
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullName.dispose();
    _confirmpassword.dispose();
    _mobileNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: kSize.height,
            width: kSize.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Icon(
                    Icons.message,
                    size: kSize.height * 0.1,
                    color: Theme.of(context).primaryColor,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const Text(
                    "Register your Account",
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
                  CustomTextField(
                    hint: 'Confirm Password',
                    controller: _confirmpassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hint: 'Full Name',
                    controller: _fullName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Full Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hint: 'Mobile Number',
                    controller: _mobileNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Mobile Number';
                      }
                      return null;
                    },
                  ),
                  BlocBuilder<CountryBloc, CountryState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: kSize.width,
                        child: CountryDropdown(
                          countryList: state.countryList,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                      width: kSize.width,
                      child: PrimaryButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //
                          }
                        },
                        label: "Register",
                      )),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RouterConstant.loginRoute);
                    },
                    child: const Text("Already an user? Login"),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
