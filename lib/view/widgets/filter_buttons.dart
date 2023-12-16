import 'package:e_commerce/controller/home/home_controller.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterButton extends StatelessWidget {
  final String title;
  final int index;
  final Function onPress;
  final HomeController homeController = Get.find();
  FilterButton(
      {required this.title,
      required this.index,
      required this.onPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            foregroundColor: index == homeController.currentIndex
                ? color.Colors.whiteColor
                : color.Colors.darkGrayColor,
            textStyle: TextStyle(fontFamily: "Poppins", fontSize: 20),
            backgroundColor: index == homeController.currentIndex
                ? color.Colors.redColor
                : color.Colors.grayColor),
        onPressed: () => onPress(),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(title),
        ));
  }
}
