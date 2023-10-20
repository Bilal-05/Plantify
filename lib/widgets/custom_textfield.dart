// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:string_validator/string_validator.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Icon prefixIcon;
  final Icon? suffixBeforeIcon;
  final Icon? suffixAfterIcon;
  final String hintText;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.suffixBeforeIcon,
    this.suffixAfterIcon,
    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText = false;
  late bool isValid = false;
  @override
  void initState() {
    super.initState();
    if (widget.hintText == 'Password') {
      setState(() {
        obscureText = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          TextField(
            keyboardType: widget.keyboardType,
            obscureText: obscureText,
            style: TextStyle(color: AppColor.pc),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: AppColor.pc),
              prefixIconColor: AppColor.pc,
              prefixIcon: widget.prefixIcon,
              fillColor: AppColor.pct,
              suffixIcon: widget.hintText == 'Password'
                  ? InkWell(
                      onTap: () {
                        if (obscureText == true) {
                          setState(() {
                            obscureText = false;
                          });
                        } else {
                          obscureText = true;
                          setState(() {});
                        }
                      },
                      child: obscureText
                          ? widget.suffixBeforeIcon
                          : widget.suffixAfterIcon,
                    )
                  : isValid
                      ? Icon(
                          Icons.check,
                          color: AppColor.pc,
                        )
                      : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColor.pct,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColor.pct,
                ),
              ),
            ),
            onChanged: widget.hintText == 'Email'
                ? (value) {
                    isValid = isEmail(widget.controller.text);
                    setState(() {});
                  }
                : null,
            controller: widget.controller,
            onSubmitted: (String value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
