// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:plant_app/views/login-signup-views/login_view/login_view.dart';
import 'package:plant_app/views/login-signup-views/signup_view/signup_view.dart';
import 'package:plant_app/views/main_menu/drawer/zoom_drawer/zoom_drawer.dart';
import 'package:plant_app/widgets/background.dart';
import 'package:plant_app/widgets/custom_button.dart';
import 'package:plant_app/widgets/text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  void initState() {
    super.initState();
    fetchIsLogin();
  }

  String documentId = '';
  bool isLogin = false;

  fetchIsLogin() async {
    await checkIsLogin();
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (isLogin == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Zoom(documentId: documentId);
          },
        ),
      );
    }
  }

  checkIsLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin') ?? isLogin;
    documentId = prefs.getString('documentId') ?? documentId;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLogin == false
        ? Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Background(
                widget: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Text(
                            'The best app for your plants',
                            style: TextStyle(
                                fontSize: 50,
                                color: AppColor.tc,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: 300,
                        child: Column(
                          children: [
                            ClipRRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: CustomButton(
                                  isDatahere: true,
                                  height: 45,
                                  width: 300,
                                  buttonText: 'Sign In',
                                  buttonColor: Colors.white.withOpacity(0.40),
                                  buttonFunction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginView();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextButton(
                              fontSize: 16,
                              navigateTo: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SignUpView();
                                    },
                                  ),
                                );
                              },
                              textColor: AppColor.tc,
                              buttonText: 'Create an account',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppColor.pc,
            body: Center(
              child: CircularProgressIndicator(
                color: AppColor.tc,
              ),
            ),
          );
  }
}
