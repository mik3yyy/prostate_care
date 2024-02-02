import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:prostate_care/auth/login/login_function.dart';
import 'package:prostate_care/auth/sign_up/sign_up.dart';
import 'package:prostate_care/auth/sign_up/sign_up_function.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/global_comonents/custom_text_button.dart';
import 'package:prostate_care/global_comonents/custom_textfield.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:prostate_care/settings/validators.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 30,
                child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    child: Image.asset('assets/images/auth/bow-2.png')),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Constants.gap(height: 120),
                            Text(
                              "Musa ways!",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Welcome back, enter these details to get in",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Constants.gap(height: 20),
                            CustomTextField(
                              controller: _emailController,
                              hintText: "Enter email address",
                              onChange: () {
                                setState(() {});
                              },
                            ),
                            Constants.gap(height: 20),
                            CustomTextField(
                              controller: _passwordController,
                              obscureText: obscuretext,
                              hintText: "Enter Password",
                              onChange: () {
                                setState(() {});
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscuretext = !obscuretext;
                                  });
                                },
                                icon: obscuretext
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off_outlined),
                              ),
                            ),
                            Constants.gap(height: 20),
                          ],
                        ),
                      ),
                      Constants.gap(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  enable: _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty,
                  onTap: () async {
                    if (_emailController.text.isValidEmail()) {
                      setState(() {
                        loading = true;
                      });

                      await LoginFunction.login(
                          scaffoldKey: scaffoldKey,
                          context: context,
                          email: _emailController.text.toLowerCase(),
                          password: _passwordController.text);
                      setState(() {
                        loading = false;
                      });
                    } else {
                      MyMessageHandler.showSnackBar(
                          scaffoldKey, "Enter Valid Email");
                    }
                  },
                  title: "Sign in",
                  loading: loading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New to ProstrateCARE? "),
                    CustomTextButton(
                      text: "Click here to sign up",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SignUpScreen.id);
                      },
                      color: Constants.teal,
                      underlined: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
