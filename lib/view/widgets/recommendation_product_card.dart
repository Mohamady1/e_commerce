import 'package:e_commerce/controller/firebase/cloud_firebase_helper.dart';
import 'package:e_commerce/model/rec_product_model.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;

import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final RecProductModel product;
  const RecommendationCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.Colors.redColor, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                future: CloudFirebaseHelper.getImageUrl(
                    "recommendation/" + product.id.toString()),
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
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    product.name!,
                    style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                  ),
                  Text(
                    product.weight!,
                    style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        fontFamily: "Poppins"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
