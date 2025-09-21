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

  Future<UserModel?> fetchUserProfile(String token) async {
    final url = Uri.parse(AppUrls.userProfileUrl);

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // A POST request often needs a body, even if it's empty.
    final body = json.encode({});

    try {
        final response = await http.post(url, headers: headers, body: body);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == true && responseData['data'] != null) {
          return UserModel.fromJson(responseData['data']);
        } else {
          print('API Error Message: ${responseData['message']}');
          return null;
        }
      } else {
        print('HTTP Error: Request failed with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('An exception occurred: $e');
      return null;
    }
  }
}