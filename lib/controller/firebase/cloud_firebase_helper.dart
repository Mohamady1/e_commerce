import 'dart:io';

import 'package:e_commerce/controller/firebase/firebase_auth_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudFirebaseHelper {
  static final ref = FirebaseStorage.instance;
  static final userId = FirebaseAuthHelper.firebaseAuth.currentUser!.uid;

  static Future<String> getImageUrl(String imagePath) async {
    final path = ref.ref().child(imagePath + ".png");
    final url = await path.getDownloadURL();
    return url;
  }

  static Future uploadImage(File file) async {
    ref.ref("users/" + userId + ".png").putFile(file);
  }
}
