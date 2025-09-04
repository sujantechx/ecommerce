import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
class ApiHelper {
  getAPI(){}
  postAPI(
  {
    required String url,
    Map<String,String>? mHeader,
    Map<String,dynamic>? mBody
})async{
    try{
      await http.post(Uri.parse(url),
        body:mBody !=null ? jsonEncode(mBody):null,headers: mHeader);
    }on SocketException catch(e){
      throw(e);
    }catch(e){
      throw(e);
    }
  }

}