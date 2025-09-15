


import '../../../domain/constants/app_urls.dart';
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
}