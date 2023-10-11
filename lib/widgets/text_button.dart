import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function navigateTo;
  final Color textColor;
  final String buttonText;
  final double fontSize;
  const CustomTextButton({
    super.key,
    required this.navigateTo,
    required this.textColor,
    required this.buttonText, required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo();
      },
      child: Text(
        buttonText,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}
