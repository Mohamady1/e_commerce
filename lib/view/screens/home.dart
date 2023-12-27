import 'package:e_commerce/controller/firebase/firebase_auth_helper.dart';
import 'package:e_commerce/controller/firebase/cloud_firebase_helper.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/controller/home/home_controller.dart';
import 'package:e_commerce/controller/products_controller.dart';
import 'package:e_commerce/view/widgets/filter_buttons.dart';
import 'package:e_commerce/view/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final ProductsController _productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Find Your Style\n',
                      style: TextStyle(
                          fontSize: 28,
                          color: color.Colors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    TextSpan(
                      text: 'With us',
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.italic,
                          color: color.Colors.redColor),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: CloudFirebaseHelper.getImageUrl("users/" +
                    FirebaseAuthHelper.firebaseAuth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: color.Colors.redColor,
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.network(
                        snapshot.data!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilterButton(
                          index: 0,
                          title: "All",
                          onPress: () {
                            controller.selectedIndex(0);
                          }),
                      FilterButton(
                          index: 1,
                          title: "Men",
                          onPress: () {
                            controller.selectedIndex(1);
                          }),
                      FilterButton(
                          index: 2,
                          title: "Women",
                          onPress: () {
                            controller.selectedIndex(2);
                          }),
                    ],
                  ),
                  Expanded(
                      child: FutureBuilder(
                    future: _productsController
                        .fetchingAllProducts(controller.currentIndex),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: color.Colors.redColor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 350,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            return ProductItem(
                              product: snapshot.data![index],
                              isWishList: false,
                            );
                          },
                          itemCount: snapshot.data!.length,
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Data is Empty",
                          ),
                        );
                      }
                    },
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
