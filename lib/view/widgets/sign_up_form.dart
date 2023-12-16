import 'package:e_commerce/controller/firebase/firebase_auth_helper.dart';
import 'package:e_commerce/controller/status_register_controller.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/controller/signup/sign_up_controller.dart';
import 'package:e_commerce/view/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';

class MyForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            CustomTextFieldForm(
              labelText: "Username",
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              onSaved: (value) {
                controller.userData["username"] = value!;
              },
            ),
            SizedBox(
              height: 16,
            ),
            CustomTextFieldForm(
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains("@")) {
                  return 'Check Your Email';
                }
                return null;
              },
              onSaved: (value) {
                controller.userData["email"] = value!;
              },
            ),
            SizedBox(height: 16.0),
            GetBuilder<SignUpController>(builder: (controller) {
              return Column(
                children: [
                  CustomTextFieldForm(
                    obscureText: controller.obscure,
                    isPassword: true,
                    labelText: "Password",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return "must be 6 character at least";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.userData["password"] = value!;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFieldForm(
                    obscureText: controller.obscure,
                    isPassword: true,
                    labelText: "Confirm Password",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != controller.userData["password"]) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.userData["confirmPassword"] = value!;
                    },
                  ),
                ],
              );
            }),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CustomTextFieldForm(
                  labelText: "Weight (kg)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userData["weight"] = value!;
                  },
                )),
                SizedBox(width: 16.0),
                Expanded(
                    child: CustomTextFieldForm(
                  labelText: "Height (cm)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userData["height"] = value!;
                  },
                )),
                SizedBox(width: 16.0),
                Expanded(
                    child: CustomTextFieldForm(
                  labelText: "Age",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userData["age"] = value!;
                  },
                )),
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: GetBuilder<RegisterStatusController>(
                init: RegisterStatusController(),
                builder: (fbcontroller) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color.Colors.redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      _formKey.currentState!.save();
                      fbcontroller.toggleAuthStatus();
                      try {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuthHelper.signUp(
                                  controller.userData["email"],
                                  controller.userData["password"])
                              .then((_) {
                            Get.offAllNamed("/login");
                            FirebaseAuthHelper.sendEmailVerification();
                            FireStoreHelper.addNewUser(controller.userData);
                            fbcontroller.toggleAuthStatus();
                          }).catchError((e) {
                            Get.snackbar("Warn", e.toString());
                            fbcontroller.toggleAuthStatus();
                          });
                        } else {
                          Get.snackbar(
                              "Warn", "Fill All Fields or Email is Wrong");
                          fbcontroller.toggleAuthStatus();
                        }
                      } catch (e) {
                        Get.snackbar("Error", e.toString());
                        fbcontroller.toggleAuthStatus();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: fbcontroller.authStatus
                          ? Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 23,
                                color: color.Colors.whiteColor,
                              ),
                            )
                          : CircularProgressIndicator(
                              color: color.Colors.whiteColor,
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
