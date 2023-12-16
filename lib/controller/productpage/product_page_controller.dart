import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPageController extends GetxController {
  Map productDetail = {
    "id": "",
    "name": "",
    "price": "",
    "totalprice": "",
    "color": "",
    "size": "",
    "quantity": 1
  };

  int currentIndex = -1;
  Color? colorSelected;

  void selectedIndex(int index) {
    currentIndex = index;
    update();
  }

  void selectedColor(Color color) {
    colorSelected = color;
    update();
  }
}
