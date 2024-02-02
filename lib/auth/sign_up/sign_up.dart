// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:prostate_care/auth/login/login_screen.dart';
import 'package:prostate_care/auth/sign_up/sign_up_function.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/global_comonents/custom_text_button.dart';
import 'package:prostate_care/global_comonents/custom_textfield.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:prostate_care/settings/validators.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = "/sign_up";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  bool obscuretext = true;
  bool obscuretext2 = true;
  String where = "";
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
                child: Image.asset('assets/images/auth/bow.png'),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Let’s get you in, enter these details to get in",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Constants.gap(height: 30),
                            CustomTextField(
                              controller: _nameController,
                              hintText: "Enter full name, surname first",
                              onChange: () {
                                setState(() {});
                              },
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
                            CustomTextField(
                              controller: _cpasswordController,
                              obscureText: obscuretext2,
                              hintText: "Confirm Password",
                              onChange: () {
                                setState(() {});
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscuretext2 = !obscuretext2;
                                  });
                                },
                                icon: obscuretext2
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off_outlined),
                              ),
                            ),
                            Constants.gap(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Constants.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: where.isNotEmpty
                                        ? Constants.teal
                                        : Constants.grey),
                              ),
                              child: DropDown(
                                isExpanded: true,
                                items: ['Tiktok'],
                                showUnderline: false,
                                hint: Text(
                                    "How did you hear about ProstateCARE?"),
                                icon: Icon(
                                  Icons.expand_more,
                                  color: Constants.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    where = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                  enable: _nameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _cpasswordController.text.isNotEmpty &&
                      where.isNotEmpty,
                  onTap: () async {
                    if (_emailController.text.isValidEmail()) {
                      if (_cpasswordController.text ==
                          _passwordController.text) {
                        setState(() {
                          loading = true;
                        });
                        bool exists = await SignUpFunction.doesEmailExist(
                            _emailController.text);
                        if (exists) {
                          setState(() {
                            loading = false;
                          });
                          MyMessageHandler.showSnackBar(
                              scaffoldKey, "Email exists");
                          return;
                        }

                        User user = User(
                          id: Uuid().v4(),
                          email: _emailController.text.toLowerCase(),
                          fullName: _nameController.text,
                          password:
                              Constants.hashPassword(_passwordController.text),
                          reference: where,
                          image: Constants.profile,
                        );
                        await SignUpFunction.addUserToFirestore(
                            scaffoldKey: scaffoldKey,
                            context: context,
                            user: user);
                        setState(() {
                          loading = false;
                        });
                      } else {
                        MyMessageHandler.showSnackBar(
                            scaffoldKey, "Enter Valid Password");
                      }
                    } else {
                      MyMessageHandler.showSnackBar(
                          scaffoldKey, "Enter Valid Email");
                    }
                  },
                  title: "Sign up",
                  loading: loading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not new to ProstrateCARE? "),
                    CustomTextButton(
                      text: "Click here to sign in",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
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
