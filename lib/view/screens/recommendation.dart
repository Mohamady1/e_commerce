import 'package:e_commerce/controller/products_controller.dart';
import 'package:e_commerce/model/rec_product_model.dart';
import 'package:e_commerce/view/widgets/recommendation_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Recommendation extends StatelessWidget {
  Recommendation({super.key});

  final ProductsController _productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<RecProductModel>>(
        future: _productsController.fetchingRecProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<RecProductModel> recProducts = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                return RecommendationCard(product: recProducts[index]);
              },
              itemCount: recProducts.length,
            );
          }
        },
      ),
    );
  }
}
