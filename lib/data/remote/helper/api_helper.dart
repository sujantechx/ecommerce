import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;

import 'app_exception.dart';
class ApiHelper {
  getAPI(){}
  postAPI(
  {
    required String url,
    Map<String,String>? mHeader,
    Map<String,dynamic>? mBody
})async{
    try{
          var response = await http.post(Uri.parse(url),

          body:mBody !=null ? jsonEncode(mBody):null,headers: mHeader);
          return parsedResponse(response);

    }on SocketException catch(e){
      throw NoInternetException(desc: "Not connected to network, ${e.message}");
    }catch(e){
      rethrow;
    }
  }
  dynamic parsedResponse(http.Response res){
    /*if(res.statusCode==200){

    } else if(res.statusCode==300){

    }*/

    switch(res.statusCode){

      case 200:
        return jsonDecode(res.body);

      case 300:
        throw FetchDataException(desc: res.body);

      case 400:
        throw BadRequestException(desc: res.body);

      case 500:
      default:
        throw ServerException(desc: res.body);

    }

  }

}