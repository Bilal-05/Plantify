import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class CustomSnack {
  static void customSnackBar(BuildContext context, String message,
      String submessage, var snackbartype) {
    AnimatedSnackBar.rectangle(
      duration: const Duration(milliseconds: 1000),
      message,
      submessage,
      type: snackbartype,
      brightness: Brightness.dark,
      mobilePositionSettings: const MobilePositionSettings(
        bottomOnAppearance: 100,
      ),
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    ).show(context);
  }
}
