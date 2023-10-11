import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon buttonIcon;
  final Color buttonColor;
  const CustomIconButton(
      {super.key, required this.buttonIcon, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: buttonColor,
        child: IconButton(
          icon: buttonIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
