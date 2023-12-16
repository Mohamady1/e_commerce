import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/view/widgets/cart_product_item.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FireStoreHelper.getCartProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: color.Colors.redColor,
                      ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.length == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset("assets/animation/cart.json"),
                            Text(
                              "No Products in Cart",
                              style: TextStyle(
                                  fontFamily: "Poppins", fontSize: 25),
                            )
                          ],
                        ),
                      );
                    } else {
                      List<QueryDocumentSnapshot> cartListData =
                          snapshot.data!.docs;

                      List<String> totalPrices = cartListData
                          .map((e) =>
                              (e.data() as Map<String, dynamic>)["totalprice"]
                                  .toString())
                          .toList();

                      double totalPriceSum = totalPrices
                          .map((price) => double.tryParse(price) ?? 0.0)
                          .reduce((value, element) => value + element);

                      String totalPriceString = totalPriceSum.toString();

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: cartListData.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> item = cartListData[index]
                                    .data() as Map<String, dynamic>;
                                return CartProductItem(product: item);
                              },
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: "Poppins"),
                                  ),
                                  Text("\$$totalPriceString",
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: "Poppins"))
                                ],
                              ),
                              Divider(thickness: 3),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        backgroundColor: color.Colors.redColor),
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: "Success",
                                          content: LottieBuilder.asset(
                                              "assets/animation/checkout.json"));
                                      FireStoreHelper.checkOut();
                                    },
                                    child: Text(
                                      "Check Out",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins"),
                                    )),
                              )
                            ],
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
