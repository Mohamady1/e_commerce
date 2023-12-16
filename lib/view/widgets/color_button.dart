import 'package:e_commerce/controller/productpage/product_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as colors;

import 'package:get/get.dart';

class ColorButton extends StatelessWidget {
  final Color color;
  const ColorButton({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final ProductPageController productPageController = Get.find();

    return GestureDetector(
      onTap: () {
        productPageController.selectedColor(color);
        productPageController.productDetail["color"] = color.value;
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            border: productPageController.colorSelected == color
                ? Border.all(color: colors.Colors.redColor, width: 5)
                : null,
            borderRadius: BorderRadius.circular(36),
            color: color),
      ),
    );
  }
}
