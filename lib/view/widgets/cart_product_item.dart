import 'package:e_commerce/controller/firebase/cloud_firebase_helper.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;

class CartProductItem extends StatelessWidget {
  final Map<String, dynamic> product;
  const CartProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String>(
            future: CloudFirebaseHelper.getImageUrl("home/" + product["id"]),
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
                return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: color.Colors.redColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 100,
                    height: 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                          tag: snapshot.data!,
                          child: Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          )),
                    ));
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: Text(
                  product["name"],
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "\$${product["price"]}",
                style:
                    TextStyle(color: color.Colors.darkGrayColor, fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(product["color"])),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: color.Colors.whiteColor),
                    child: Center(
                      child: Text(product["size"]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        FireStoreHelper.removeFromQuantity(product["id"]);
                      },
                      icon: Icon(Icons.remove)),
                  Text(product["quantity"].toString()),
                  IconButton(
                      onPressed: () {
                        FireStoreHelper.addToQuantity(product["id"]);
                      },
                      icon: Icon(Icons.add))
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                FireStoreHelper.removeFromCard(product["id"]);
              },
              icon: Icon(
                Icons.delete,
                color: color.Colors.redColor,
              ))
        ],
      ),
    );
  }
}
