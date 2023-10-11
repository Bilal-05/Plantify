import 'package:flutter/material.dart';
import 'package:plant_app/constant/imagepath.dart';

class Background extends StatelessWidget {
  final Widget? widget;
  const Background({super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePath.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: widget,
    );
  }
}
