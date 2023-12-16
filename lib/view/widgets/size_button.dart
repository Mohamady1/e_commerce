import 'package:e_commerce/controller/productpage/product_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';

class SizeButton extends StatelessWidget {
  final String letter;
  final int index;

  const SizeButton({required this.index, required this.letter, super.key});

  @override
  Widget build(BuildContext context) {
    final ProductPageController productPageController = Get.find();

    return GestureDetector(
      onTap: () {
        productPageController.selectedIndex(index);
        productPageController.productDetail["size"] = letter;
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: productPageController.currentIndex == index
                ? color.Colors.redColor
                : color.Colors.whiteColor),
        child: Center(
            child: Text(
          letter,
          style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
        )),
      ),
    );
  }
}
