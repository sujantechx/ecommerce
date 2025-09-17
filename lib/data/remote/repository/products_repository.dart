


import 'dart:developer';

import '../../../domain/constants/app_urls.dart';
import '../../../model/products_model.dart';
import '../helper/api_helper.dart';

class ProductRepository {
  ApiHelper apiHelper;

  ProductRepository({required this.apiHelper});

  Future<dynamic> getProducts(int? catId) async {
    try {
      return await apiHelper.postAPI(
        url: AppUrls.getProductsUrl,
        mBody: catId != null ? {"category_id": catId} : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      // 1. Fetch ALL products, since the API doesn't filter.
      final url = AppUrls.getProductsUrl;
      final response = await apiHelper.getAPI(url: url);

      log("RESPONSE (ALL PRODUCTS): $response");

      ProductDataModel productDataModel = ProductDataModel.fromJson(response);
      List<ProductModel> allProducts = productDataModel.data ?? [];

      // 2. Filter the list here in the app.
      // This keeps only the products where the product's categoryId matches the one we want.
      List<ProductModel> filteredProducts = allProducts.where((product) {
        return product.categoryId.toString() == categoryId;
      }).toList();

      return filteredProducts;

    } catch (e) {
      log("ERROR fetching products for category $categoryId: $e");
      rethrow;
    }
  }}