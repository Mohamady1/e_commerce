import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthHelper {
  static final firebaseAuth = FirebaseAuth.instance;
  static final bool isAuth = firebaseAuth.currentUser != null;
  static final bool isEmailVerified = firebaseAuth.currentUser!.emailVerified;

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  static Future<UserCredential> signUp(String email, String pass) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'Password should be at least 6 characters';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is badly formatted.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
      return "" as UserCredential;
    }
  }

  static Future signIn(String email, String pass) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
    }
  }

  static Future<void> sendEmailVerification() async {
    firebaseAuth.currentUser!.sendEmailVerification();
  }

  static void sendPasswordResetEmail(String email) {
    firebaseAuth.sendPasswordResetEmail(email: email).then((_) {
      Get.snackbar("Success", "Password reset email sent to $email");
    }).catchError((error) {
      Get.snackbar("Error", "Failed to send password reset email: $error");
    });
  }
}
