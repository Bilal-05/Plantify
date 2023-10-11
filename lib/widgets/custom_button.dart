import 'package:flutter/material.dart';
import '../constant/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function buttonFunction;
  final double width;
  final double height;
  final bool isDatahere;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonFunction,
    required this.width,
    required this.height,
    required this.isDatahere,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        minimumSize: Size(width, height),
        maximumSize: Size(width, height),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () async {
        buttonFunction();
      },
      child: isDatahere
          ? Text(
              buttonText,
              style: TextStyle(color: AppColor.tc, fontSize: 16),
            )
          : CircularProgressIndicator(
              color: AppColor.tc,
            ),
    );
  }
}
