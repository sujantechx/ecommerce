

import 'package:http/http.dart' as _apiHelper;

import '../../../domain/constants/app_urls.dart';
import '../helper/api_helper.dart';

class CartRepository{
  ApiHelper apiHelper;

  CartRepository({required this.apiHelper});

  Future<dynamic> addToCart({required int productId, required int qty}) async{

    try{
      return await apiHelper.postAPI(url: AppUrls.addToCartUrl, mBody: {
        "product_id":productId,
        "quantity":qty
      });
    } catch(e){
      rethrow;
    }

  }

  Future<void> updateCartQuantity({

    required String cartItemId,
    required String action, // e.g., "increment" or "decrement"
  }) async {
    try {
      await apiHelper.postAPI(
        url: AppUrls.updateCartQuantityUrl,
        mBody: {
          'cart_item_id': cartItemId,
          'action': action,
        },
        isAuth: true,
      );
    } catch (e) {
      rethrow;
    }
  }
  ///fetchCart
  fetchCart() async{
    try{
      return await apiHelper.getAPI(url: AppUrls.fetchCartUrl);
    } catch(e){
      rethrow;
    }
  }
  Future<dynamic> removeFromCart({required String cartItemId}) async{
    try{
      return await apiHelper.postAPI(url: AppUrls.deleteCartUrl, mBody: {
        "cart_item_id":cartItemId,
      });
    } catch(e){
      rethrow;
    }
  }
}
