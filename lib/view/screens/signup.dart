import 'package:e_commerce/view/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: color.Colors.redColor),
                ),
                LottieBuilder.asset(
                  "assets/animation/signup.json",
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            MyForm(),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.offAllNamed("/login");
              },
              child: RichText(
                  text: TextSpan(text: "", children: [
                TextSpan(
                    text: 'Or have account',
                    style: TextStyle(
                        fontSize: 18, color: color.Colors.blackColor)),
                TextSpan(
                    text: ' Login',
                    style: TextStyle(
                        color: color.Colors.solidRedColor, fontSize: 18)),
              ])),
            )
          ],
        ));
  }
}
