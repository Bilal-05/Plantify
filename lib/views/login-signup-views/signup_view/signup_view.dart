// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, sized_box_for_whitespace
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:plant_app/constant/controller.dart';
import 'package:plant_app/constant/imagepath.dart';
import 'package:plant_app/views/login-signup-views/login_view/login_view.dart';
import 'package:plant_app/widgets/back_button.dart';

import 'package:plant_app/widgets/custom_media_query.dart';
import 'package:plant_app/widgets/custom_button.dart';
import 'package:plant_app/widgets/custom_snackbar.dart';
import 'package:plant_app/widgets/custom_textfield.dart';
import 'package:plant_app/widgets/text_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool rememberMe = false;
  bool isDatahere = true;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(UserCredential credential) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(credential.user?.uid.toString())
        .set({
          'full_name': AppInit.signUpFullnameController.text,
          'email': AppInit.signUpEmailController.text,
          'uid': credential.user?.uid.toString()
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  register() async {
    setState(() {
      isDatahere = false;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: AppInit.signUpEmailController.text,
        password: AppInit.signUpPassController.text,
      );
      CustomSnack.customSnackBar(
          context, 'Success', 'User registered', AnimatedSnackBarType.success);
      addUser(credential);
      await Future.delayed(
        const Duration(milliseconds: 100),
      );
      AppInit.signUpEmailController.clear();
      AppInit.signUpPassController.clear();
      AppInit.signUpFullnameController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginView();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(
        () {
          isDatahere = true;
        },
      );
      CustomSnack.customSnackBar(
        context,
        'Error',
        e.message!,
        AnimatedSnackBarType.error,
      );
      // if (e.code == 'email-already-in-use') {
      //   CustomSnack.customSnackBar(
      //     context,
      //     'Error',
      //     'The account already exists for that email.',
      //     AnimatedSnackBarType.error,
      //   );
      // } else if (e.code == 'weak-password') {
      //   CustomSnack.customSnackBar(
      //     context,
      //     'Error',
      //     'The password provided is too weak.',
      //     AnimatedSnackBarType.error,
      //   );
      // }
    } catch (e) {
      setState(() {
        isDatahere = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            color: AppColor.tc,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        color: AppColor.pc,
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                      ),
                    ),
                    Media.space(0.01, context),
                    Text(
                      'Create your new account',
                      style: TextStyle(
                        color: AppColor.sct,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Media.space(0.075, context),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: AppInit.signUpFullnameController,
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Full Name',
                      ),
                    ),
                    Media.space(0.03, context),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: AppInit.signUpEmailController,
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Media.space(0.03, context),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: AppInit.signUpPassController,
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
                    Media.space(0.03, context),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        isDatahere: isDatahere,
                        width: 350,
                        height: 45,
                        buttonText: 'Register',
                        buttonColor: AppColor.pc,
                        buttonFunction: () {
                          register();
                        },
                      ),
                    ),
                    Media.space(0.01, context),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 20, right: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       SizedBox(
                    //         width: 130,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             InkWell(
                    //               onTap: () {
                    //                 if (rememberMe) {
                    //                   setState(() {
                    //                     rememberMe = false;
                    //                   });
                    //                 } else {
                    //                   rememberMe = true;
                    //                   setState(() {});
                    //                 }
                    //               },
                    //               child: CircleAvatar(
                    //                 radius: 13,
                    //                 backgroundColor: Colors.transparent,
                    //                 child: rememberMe
                    //                     ? Icon(
                    //                         Icons.check_circle,
                    //                         color: AppColor.pc,
                    //                       )
                    //                     : Icon(
                    //                         Icons.check_circle,
                    //                         color: AppColor.pct,
                    //                       ),
                    //               ),
                    //             ),
                    //             Text(
                    //               'Remember Me',
                    //               style: TextStyle(
                    //                 color: AppColor.sct,
                    //                 fontWeight: FontWeight.w400,
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       CustomTextButton(
                    //         navigateTo: () {},
                    //         textColor: AppColor.pc,
                    //         buttonText: 'Forgot Password?',
                    //         fontSize: 14,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Media.space(0.05, context),
                    Container(
                      width: 340,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80,
                            height: 2,
                            color: AppColor.sct,
                          ),
                          Text(
                            "Or continue with",
                            style: TextStyle(
                                color: AppColor.sc,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            width: 80,
                            height: 2,
                            color: AppColor.sct,
                          ),
                        ],
                      ),
                    ),
                    Media.space(0.05, context),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(ImagePath.facebook),
                            ),
                          ),
                          InkWell(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(ImagePath.google),
                            ),
                          ),
                          InkWell(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(ImagePath.apple),
                            ),
                          )
                        ],
                      ),
                    ),
                    Media.space(0.070, context),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: AppColor.sc,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CustomTextButton(
                            fontSize: 16,
                            navigateTo: () async {
                              AppInit.signUpEmailController.clear();
                              AppInit.signUpFullnameController.clear();
                              AppInit.signUpPassController.clear();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginView();
                                  },
                                ),
                              );
                            },
                            textColor: AppColor.pc,
                            buttonText: 'Sign In',
                          ),
                        ],
                      ),
                    )
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
      ),
    );
  }
}
