import '../../../domain/constants/app_urls.dart';
import '../helper/api_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  final ApiHelper apiHelper;
  OrderRepository({required this.apiHelper});

  Future<Map<String, dynamic>> createOrder({
    required String userId,
    required List<int> productIds,
  }) async {
    Map<String, dynamic> lastResponse = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token', // Add the token here
    };

    for (int productId in productIds) {
      final body = {
        "user_id": userId,
        "product_id": productId,
        "status": 1,
      };

      try {
        final response = await apiHelper.postAPI(
          url: AppUrls.createOrderUrl,
          mBody: body,
          mHeaders: headers, // Pass the headers map here
          isAuth: true, // Keep this true so the broken logic in postApi is skipped
        );

        lastResponse = response;

        if (response['status'] != true) {
          return lastResponse;
        }
      } catch (e) {
        return {'status': false, 'message': e.toString()};
      }
    }

    return lastResponse;
  }
}