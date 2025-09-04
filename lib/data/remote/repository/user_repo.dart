

import 'package:ecommerce/data/remote/helper/api_helper.dart';

class UserRepo {
  ApiHelper apiHelper;
  UserRepo({required this.apiHelper});
  
  loginUser({required String email,required String pass}){
    try{
      apiHelper.postAPI(url: url)
    }catch(e){
      throw(e);
    }
  }
}