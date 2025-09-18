

import 'dart:convert';

import 'package:ecommerce/data/remote/helper/api_helper.dart';
import 'package:ecommerce/domain/constants/app_urls.dart';
import 'package:http/http.dart' as http;

import '../../../model/user_model.dart';

class UserRepository {
  ApiHelper apiHelper;
  UserRepository({required this.apiHelper});

  Future<dynamic> loginUser({
    required String email,
    required String pass,
  }) async {
    try {
      return await apiHelper.postAPI(
        url: AppUrls.loginUrl,
        mBody: {"email": email, "password": pass},
      );
    } catch (e) {
      rethrow;
    }}
 Future<dynamic> registerUser({
    required String email,
    required String name,
    required String mobNo,
    required String pass,

  })async{
    try{
     return apiHelper.postAPI(url: AppUrls.registerUrl,mBody: {
        "name":name,
        "email":email,
        "mobile_number":mobNo,
        "password":pass,
      });
    }catch(e){
      rethrow;
    }
  }

// Dart

  Future<UserModel?> fetchUserProfile(String token) async {
    final response = await apiHelper.getApi(
      url: AppUrls.userProfileUrl,
      isAuth: true,
      mHeaders: {
        'Authorization': 'Bearer $token',
      },
    );
    print('API response: $response'); // response is already a Map

    if (response['status'] == true && response['data'] != null) {
      return UserModel.fromJson(response['data']);
    }
    return null;
  }

}