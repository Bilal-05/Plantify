import 'package:flutter/material.dart';

class AppInit {
  static TextEditingController loginEmailController = TextEditingController();
  static TextEditingController loginPassController = TextEditingController();
  static TextEditingController signUpFullnameController =
      TextEditingController();
  static TextEditingController signUpEmailController = TextEditingController();
  static TextEditingController signUpPassController = TextEditingController();
  static TextEditingController forgetPassController = TextEditingController();
}

class SaveData {
  static String signUpEmail = '';
  static String signUpFullname = '';
  static String signUpPass = '';
  static String loginEmail = '';
  static String loginPass = '';
  static String forgetPass = '';
}
