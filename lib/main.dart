import 'package:e_commerce/controller/firebase/firebase_auth_helper.dart';
import 'package:e_commerce/view/navigation.dart';
import 'package:e_commerce/view/screens/home.dart';
import 'package:e_commerce/view/screens/login.dart';
import 'package:e_commerce/view/screens/product_page.dart';
import 'package:e_commerce/view/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/view/utils/colors.dart' as color;

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: color.Colors.bg),
      home: (FirebaseAuthHelper.isAuth && FirebaseAuthHelper.isEmailVerified)
          ? NavigationPage()
          : SignUp(),
      getPages: [
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/nav", page: () => NavigationPage()),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/product_page", page: () => ProductPage()),
      ],
    );
  }
}
