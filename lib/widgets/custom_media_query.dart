import 'package:flutter/material.dart';

class Media {
  static Widget space(double size, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * size,
    );
  }
}
