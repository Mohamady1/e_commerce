import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/controller/productpage/product_page_controller.dart';
import 'package:e_commerce/view/widgets/color_button.dart';
import 'package:e_commerce/view/widgets/size_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)!.settings.arguments as Map;
    final ProductPageController productPageController =
        Get.put(ProductPageController());

    productPageController.productDetail["name"] = route["data"].name;
    productPageController.productDetail["price"] =
        route["data"].price.toString();
    productPageController.productDetail["totalprice"] =
        route["data"].price.toString();
    productPageController.productDetail["id"] = route["data"].id.toString();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: route["image"],
            child: Image.network(
              route["image"],
              fit: BoxFit.cover,
              width: 418,
              height: 450,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    child: Text(
                      route["data"].name,
                      style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "\$${route["data"].price.toString()}",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Size",
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<ProductPageController>(
                  builder: (controller) {
                    return Row(
                      children: [
                        SizeButton(
                          index: 0,
                          letter: "S",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizeButton(
                          index: 1,
                          letter: "M",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizeButton(
                          index: 2,
                          letter: "L",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizeButton(
                          index: 3,
                          letter: "XL",
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Color",
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<ProductPageController>(
                  builder: (controller) {
                    return Row(
                      children: [
                        ColorButton(color: color.Colors.blackColor),
                        SizedBox(
                          width: 5,
                        ),
                        ColorButton(color: color.Colors.solidRedColor),
                        SizedBox(
                          width: 5,
                        ),
                        ColorButton(color: color.Colors.grayColor),
                        SizedBox(
                          width: 5,
                        ),
                        ColorButton(color: color.Colors.blueColor),
                        SizedBox(
                          width: 5,
                        ),
                        ColorButton(color: color.Colors.greenColor),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: color.Colors.redColor),
                      onPressed: () {
                        if (productPageController.currentIndex == -1 ||
                            productPageController.colorSelected == null) {
                          Get.snackbar("Warning", "Fill All Fields");
                        } else {
                          FireStoreHelper.addProductToCart(
                                  productPageController.productDetail)
                              .then((_) {
                            Get.snackbar(
                                "Success", "Added To Cart Successfully");
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 25, fontFamily: "Poppins"),
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
