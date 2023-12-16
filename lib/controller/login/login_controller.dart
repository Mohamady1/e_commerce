import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isObscure = true;

  toggleObscure() {
    isObscure = !isObscure;
    update();
  }
}
