import 'package:e_commerce/controller/signup/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;

import 'package:get/get.dart';

class CustomTextFieldForm extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isPassword;
  final Function(String?) validator;
  final Function(String?) onSaved;

  const CustomTextFieldForm({
    Key? key,
    required this.labelText,
    required this.keyboardType,
    this.obscureText = false,
    this.isPassword = false,
    required this.validator,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: color.Colors.blackColor),
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: color.Colors.redColor)),
        suffixIconColor: color.Colors.redColor,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  controller.toggleObscure();
                },
                icon: Icon(Icons.remove_red_eye),
              )
            : null,
      ),
      validator: (value) => validator(value),
      onSaved: (value) => onSaved(value),
    );
  }
}
