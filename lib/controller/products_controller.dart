import 'package:e_commerce/controller/api/api_home_products.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/model/rec_product_model.dart';
import 'package:e_commerce/view/utils/utils.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  List<ProductModel> products = [];
  List<RecProductModel> recproducts = [];

  Future<List<ProductModel>> fetchingAllProducts(int productFilter) async {
    try {
      products = (await Api().fetchingAllProducts())
          .map((e) => ProductModel.fromJson(e))
          .toList();

      List<ProductModel> filteredProducts = products.where((product) {
        if (productFilter == 0) {
          return true;
        } else if (productFilter == 1) {
          return product.gender == "men";
        } else {
          return product.gender == "women";
        }
      }).toList();

      return filteredProducts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RecProductModel>> fetchingRecProducts() async {
    try {
      String weight = await FireStoreHelper.getUserWeight();
      if (weight != "") {
        recproducts = (await Api().fetchRecommendedProducts())
            .map((e) => RecProductModel.fromJson(e))
            .toList();

        List<RecProductModel> filteredProducts = recproducts.where((product) {
          return Utils.equivalentWeights(product.weight!, int.parse(weight));
        }).toList();
        return filteredProducts;
      } else {
        recproducts.clear();
        return recproducts;
      }
    } catch (e) {
      rethrow;
    }
  }
}
