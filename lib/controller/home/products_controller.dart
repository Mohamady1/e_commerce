import 'package:e_commerce/controller/api/api_home_products.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  List<ProductModel> products = [];

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
}
