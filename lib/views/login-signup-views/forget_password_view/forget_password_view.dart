// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:plant_app/constant/controller.dart';
import 'package:plant_app/constant/imagepath.dart';
import 'package:plant_app/widgets/back_button.dart';
import 'package:plant_app/widgets/custom_button.dart';
import 'package:plant_app/widgets/custom_snackbar.dart';
import 'package:plant_app/widgets/custom_textfield.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  bool isDatahere = true;

  resetPassword() async {
    try {
      setState(() {
        isDatahere = false;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: AppInit.forgetPassController.text.trim(),
      );
      CustomSnack.customSnackBar(
        context,
        'Success',
        'Password reset email sent. Check your mail.',
        AnimatedSnackBarType.success,
      );
      await Future.delayed(
        Duration(milliseconds: 2000),
      );
      await AppInit.forgetPassController.clear;
      setState(
        () {
          isDatahere = true;
        },
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(
        () {
          isDatahere = true;
        },
      );
      CustomSnack.customSnackBar(
        context,
        'Error',
        e.code,
        AnimatedSnackBarType.error,
      );
    } catch (e) {
      setState(
        () {
          isDatahere = true;
        },
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.tc,
      body: SafeArea(
        child: Stack(
          children: [
            CustomIconButton(
              buttonIcon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.sc,
                size: 20,
              ),
              buttonColor: AppColor.pct,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: 300,
                  child: Lottie.asset(ImagePath.forgetPass),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    'Recieve an email to reset your password',
                    style: TextStyle(
                      color: AppColor.pc,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CustomTextField(
                    controller: AppInit.forgetPassController,
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CustomButton(
                    isDatahere: isDatahere,
                    width: 350,
                    height: 45,
                    buttonText: 'Reset Password',
                    buttonColor: AppColor.pc,
                    buttonFunction: () {
                      resetPassword();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
