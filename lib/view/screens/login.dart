import 'package:e_commerce/controller/firebase/firebase_auth_helper.dart';
import 'package:e_commerce/controller/status_register_controller.dart';
import 'package:e_commerce/view/utils/utils.dart';
import 'package:e_commerce/view/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _userController = TextEditingController();
    TextEditingController _passController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset("assets/animation/login.json",
                  width: 200, height: 200),
              SizedBox(height: 50),
              CustomTextField(
                hintText: "Email",
                controller: _userController,
              ),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    controller: _passController,
                    hintText: "Password",
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "Reset Password",
                          content: CustomTextField(
                              hintText: "Type your Email",
                              controller: _userController),
                          onConfirm: () {
                            FirebaseAuthHelper.sendPasswordResetEmail(
                                _userController.text);
                            _userController.clear();
                            Get.back();
                          },
                          onCancel: () => Get.back());
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: color.Colors.darkGrayColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GetBuilder<RegisterStatusController>(
                init: RegisterStatusController(),
                builder: (controller) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: color.Colors.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () {
                        controller.toggleAuthStatus();
                        try {
                          bool isValid = Utils.loginValidation(
                              _userController.text, _passController.text);

                          if (isValid) {
                            FirebaseAuthHelper.signIn(
                                    _userController.text, _passController.text)
                                .then((credential) {
                              if (credential.user!.emailVerified == true) {
                                Get.offAllNamed("/nav");
                              } else {
                                Get.snackbar("Verify Missing",
                                    "You Must Verify ur Account");
                              }
                              controller.toggleAuthStatus();
                            }).catchError((e) {
                              Get.snackbar("Warn", e.toString());
                              controller.toggleAuthStatus();
                            });
                          } else {
                            Get.snackbar(
                                "Warn", "Fill All Fields or Email is Wrong");
                            controller.toggleAuthStatus();
                          }
                        } catch (e) {
                          Get.snackbar("Error", e.toString());
                          controller.toggleAuthStatus();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: controller.authStatus
                            ? Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 23,
                                    color: color.Colors.whiteColor),
                              )
                            : CircularProgressIndicator(
                                color: color.Colors.whiteColor,
                              ),
                      ));
                },
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed("/signup");
                },
                child: RichText(
                    text: TextSpan(text: "", children: [
                  TextSpan(
                      text: "I don't hava account",
                      style: TextStyle(
                          fontSize: 18, color: color.Colors.blackColor)),
                  TextSpan(
                      text: ' Sign Up',
                      style: TextStyle(
                          color: color.Colors.solidRedColor, fontSize: 18)),
                ])),
              )
            ],
          ),
        ));
  }
}
