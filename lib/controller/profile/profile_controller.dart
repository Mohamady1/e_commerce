import 'dart:io';

import 'package:e_commerce/controller/firebase/cloud_firebase_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  File? image;
  String? fileName;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      await CloudFirebaseHelper.uploadImage(image!);
      update();
    }
  }
}
