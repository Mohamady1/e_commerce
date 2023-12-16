import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool obscure = true;

  Map userData = {
    "username": '',
    "email": '',
    "password": '',
    "confirmPassword": '',
    "weight": '',
    "height": '',
    "age": ''
  };

  toggleObscure() {
    obscure = !obscure;
    update();
  }
}
