import 'package:get/get.dart';

class RegisterStatusController extends GetxController {
  bool authStatus = true;

  void toggleAuthStatus() {
    authStatus = !authStatus;
    update();
  }
}
