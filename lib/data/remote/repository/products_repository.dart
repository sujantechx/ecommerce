


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

  Future<dynamic> fetchProductsByCategory(String categoryId) async {
    try {
      // Your API expects an integer, so we parse the incoming string ID.
      final int? categoryIdInt = int.tryParse(categoryId);

      // If parsing fails (which it shouldn't), you might want to handle it.
      if (categoryIdInt == null) {
        throw Exception("Invalid Category ID format: $categoryId");
      }

      return await apiHelper.postAPI(
        url: AppUrls.getProductsUrl,
        mBody: {"category_id": categoryIdInt},
      );
    } catch (e) {
      // Rethrow the error to be caught by the BLoC.
      rethrow;
    }
  }
}