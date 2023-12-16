import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:e_commerce/view/utils/colors.dart' as color;

class Wishlist extends StatelessWidget {
  Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FireStoreHelper.getWishlist(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: color.Colors.redColor,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/animation/wishlist.json",
                        height: 250, width: 250),
                    Text(
                      "No Wishlist add your style",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 25),
                    )
                  ],
                ),
              );
            } else {
              List<QueryDocumentSnapshot> wishlistData = snapshot.data!.docs;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 350,
                  crossAxisSpacing: 20,
                ),
                itemCount: wishlistData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item =
                      wishlistData[index].data() as Map<String, dynamic>;
                  return ProductItem(
                    product: ProductModel.fromJson(item),
                    isWishList: true,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
