import 'package:e_commerce/controller/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField(
      {required this.hintText, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (logincontroller) => TextField(
          controller: controller,
          obscureText:
              hintText == "Password" ? logincontroller.isObscure : false,
          decoration: InputDecoration(
            suffixIcon: hintText == "Password"
                ? IconButton(
                    onPressed: () {
                      logincontroller.toggleObscure();
                    },
                    icon: Icon(Icons.visibility))
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: hintText,
          )),
    );
  }
}
