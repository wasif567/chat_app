import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/application/auth/auth_bloc.dart';
import 'package:chat/src/application/country_bloc/country_bloc.dart';
import 'package:chat/src/application/user/user_bloc.dart';
import 'package:chat/src/application/user/user_event.dart';
import 'package:chat/src/presentation/core/widgets/country_dropdown.dart';
import 'package:chat/src/presentation/core/widgets/custom_textfield.dart';
import 'package:chat/src/presentation/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final String? email;
  const RegisterPage({super.key, this.email});

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
  final TextEditingController _countryController = TextEditingController();

  final countryCode = ValueNotifier<String>("");

  final _obscureText = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    if (widget.email != null && widget.email!.isNotEmpty) {
      _emailController.text = widget.email!;
    }
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
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isRegistered != null) {
            if (state.isRegistered!) {
              Navigator.pushReplacementNamed(context, RouterConstant.homeRoute);
              context.read<UserBloc>().add(FetchUsers());
            }
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: kSize.height,
                width: kSize.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.1, vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Icon(
                        Icons.message,
                        size: kSize.height * 0.05,
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
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          // Validate the email using regex

                          if (!(value.contains("@") && value.contains(".com"))) {
                            return 'Invalid email address';
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
                                if (value.length < 6) {
                                  return "Password required minimum 6 letters or digit";
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
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Password';
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
                      BlocBuilder<CountryBloc, CountryState>(
                        builder: (context, state) {
                          if (state.countryList != null && state.countryList!.isNotEmpty) {
                            return SizedBox(
                              width: kSize.width,
                              child: CountryDropdown(
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select your Country";
                                  }
                                  return null;
                                },
                                countryList: state.countryList,
                                onChanged: (country) {
                                  if (country != null) {
                                    _countryController.text = country.name.common;
                                    countryCode.value = "${country.idd.root}${country.idd.suffixes.first}";
                                  } else {
                                    _countryController.clear();
                                    countryCode.value = '';
                                  }
                                },
                              ),
                            );
                          } else if (state.isloading != null && state.isloading!) {
                            const Center(
                              child: Text(
                                "Loading...",
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          {
                            return const SizedBox();
                          }
                        },
                      ),
                      const Spacer(),
                      ValueListenableBuilder(
                          valueListenable: countryCode,
                          builder: (context, value, child) {
                            return CustomTextField(
                              hint: 'Mobile Number',
                              prefixIcon: countryCode.value.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                                      child: Text(
                                        value,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : null,
                              controller: _mobileNumber,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Mobile Number';
                                }
                                return null;
                              },
                            );
                          }),
                      state.isLoading != null && state.isLoading!
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
                                    if (countryCode.value.isNotEmpty) {
                                      RegisterAuth registerAuth = RegisterAuth(
                                          fullName: _fullName.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text.trim(),
                                          country: _countryController.text.trim(),
                                          mobileNumber: "${countryCode.value}${_mobileNumber.text.trim()}",
                                          context: context);

                                      context.read<AuthBloc>().add(registerAuth);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Please select country')));
                                    }
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
                      const Spacer(flex: 2),
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
