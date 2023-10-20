// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:plant_app/constant/controller.dart';
import 'package:plant_app/constant/imagepath.dart';
import 'package:plant_app/views/login-signup-views/forget_password_view/forget_password_view.dart';
import 'package:plant_app/views/login-signup-views/signup_view/signup_view.dart';
import 'package:plant_app/views/main_menu/drawer/zoom_drawer/zoom_drawer.dart';
import 'package:plant_app/widgets/back_button.dart';
import 'package:plant_app/widgets/background.dart';
import 'package:plant_app/widgets/custom_media_query.dart';
import 'package:plant_app/widgets/custom_button.dart';
import 'package:plant_app/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_app/widgets/custom_snackbar.dart';
import 'package:plant_app/widgets/text_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLogin = false;

  isLoggedin(UserCredential credential) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe == true) {
      await prefs.setBool('isLogin', true);
      await prefs.setString('documentId', credential.user!.uid);
    }
    setState(() {});
  }

  bool isDatahere = true;

  login() async {
    setState(() {
      isDatahere = false;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: AppInit.loginEmailController.text,
          password: AppInit.loginPassController.text);
      CustomSnack.customSnackBar(context, 'Success', 'Login Successfull',
          AnimatedSnackBarType.success);
      isLoggedin(credential);
      await Future.delayed(
        const Duration(milliseconds: 1500),
      );
      AppInit.loginEmailController.clear();
      AppInit.loginPassController.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Zoom(
              documentId: credential.user!.uid,
            );
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(
        () {
          isDatahere = true;
        },
      );
      print(e.code);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        CustomSnack.customSnackBar(
          context,
          'Error',
          'Email or Password is incorrect',
          AnimatedSnackBarType.error,
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        isDatahere = true;
      });
      CustomSnack.customSnackBar(
        context,
        'Error',
        '$e',
        AnimatedSnackBarType.error,
      );
    }
  }

  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  const Background(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 1,
                        image: AssetImage(ImagePath.whiteCard),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                color: AppColor.pc,
                                fontWeight: FontWeight.w600,
                                fontSize: 35,
                              ),
                            ),
                            Media.space(0.005, context),
                            Text(
                              'Login to your account',
                              style: TextStyle(
                                color: AppColor.sct,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Media.space(0.03, context),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomTextField(
                                controller: AppInit.loginEmailController,
                                prefixIcon: const Icon(Icons.person),
                                hintText: 'Email',
                              ),
                            ),
                            Media.space(0.025, context),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomTextField(
                                controller: AppInit.loginPassController,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppColor.pc,
                                ),
                                hintText: 'Password',
                                suffixAfterIcon: Icon(
                                  Icons.password,
                                  color: AppColor.pc,
                                ),
                                suffixBeforeIcon: Icon(
                                  Icons.remove_red_eye,
                                  color: AppColor.pc,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (rememberMe) {
                                        setState(() {
                                          rememberMe = false;
                                        });
                                      } else {
                                        rememberMe = true;
                                        setState(() {});
                                      }
                                    },
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.transparent,
                                            child: rememberMe
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: AppColor.pc,
                                                  )
                                                : Icon(
                                                    Icons.check_circle,
                                                    color: AppColor.pct,
                                                  ),
                                          ),
                                          Text(
                                            'Remember Me',
                                            style: TextStyle(
                                              color: AppColor.sct,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomTextButton(
                                    navigateTo: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ForgetPasswordView();
                                          },
                                        ),
                                      );
                                    },
                                    textColor: AppColor.pc,
                                    buttonText: 'Forgot Password?',
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                            Media.space(0.15, context),
                            CustomButton(
                                isDatahere: isDatahere,
                                height: 45,
                                width: 350,
                                buttonText: 'Login',
                                buttonColor: AppColor.pc,
                                buttonFunction: () {
                                  login();
                                }),
                            Media.space(0.01, context),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Don\'t have account? ',
                                    style: TextStyle(
                                      color: AppColor.sc,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  CustomTextButton(
                                    fontSize: 16,
                                    navigateTo: () {
                                      AppInit.loginEmailController.clear();
                                      AppInit.loginPassController.clear();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const SignUpView();
                                          },
                                        ),
                                      );
                                    },
                                    textColor: AppColor.pc,
                                    buttonText: 'Sign Up',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomIconButton(
                buttonIcon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColor.sc,
                  size: 20,
                ),
                buttonColor: AppColor.pct,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
