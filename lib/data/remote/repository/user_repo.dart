

import 'package:ecommerce/data/remote/helper/api_helper.dart';
import 'package:ecommerce/domain/constants/app_urls.dart';

class UserRepo {
  ApiHelper apiHelper;
  UserRepo({required this.apiHelper});
  
  loginUser({required String email,required String pass}){
    try{
      apiHelper.postAPI(url: AppUrls.loginUrl,mBody: {
        "email":email,
        "password":pass,
      });
    }catch(e){
      throw(e);
    }
  }
  registerUser({
    required String email,
    required String name,
    required String mobNo,
    required String pass,

  }){
    try{
      apiHelper.postAPI(url: AppUrls.registerUrl,mBody: {
        "name":name,
        "email":email,
        "mobile_number":mobNo,
        "password":pass,
      });
    }catch(e){
      throw(e);
    }
  }
}