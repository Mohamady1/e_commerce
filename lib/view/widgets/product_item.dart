import 'package:e_commerce/controller/firebase/cloud_firebase_helper.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final bool isWishList;

  const ProductItem({required this.isWishList, required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<String>(
          future:
              CloudFirebaseHelper.getImageUrl("home/" + product.id.toString()),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: color.Colors.redColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return GestureDetector(
                onTap: () => Get.toNamed("product_page",
                    arguments: {"data": product, "image": snapshot.data!}),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: color.Colors.redColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 176,
                      height: 256,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Hero(
                            tag: snapshot.data!,
                            child: Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: color.Colors.redColor,
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                isWishList
                                    ? FireStoreHelper.removeFromWishList(
                                            product.id.toString())
                                        .then((value) => Get.snackbar("Success",
                                            "Item Deleted Successfully"))
                                    : FireStoreHelper.addProductToWishlist(
                                            product)
                                        .then((value) =>
                                            Get.snackbar("Done", value));
                              },
                              icon: isWishList
                                  ? Icon(
                                      Icons.delete,
                                      color: color.Colors.whiteColor,
                                    )
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      color: color.Colors.whiteColor,
                                    ),
                            ),
                          )),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        Text(
          Utils.minimizeWord(product.name!),
          style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
        ),
        Text(
          "\$${product.price}",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Poppins",
            color: color.Colors.darkGrayColor,
          ),
        )
      ],
    );
  }
}
