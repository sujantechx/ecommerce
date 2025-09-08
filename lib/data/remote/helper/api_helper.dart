import 'dart:async';
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
    try {
      var response = await http.post(
          Uri.parse(url),
          body: mBody != null ? jsonEncode(mBody) : null,
          headers: mHeader
      ).timeout(const Duration(seconds: 15)); // <-- ADD THIS LINE

      return parsedResponse(response);

    } on TimeoutException {
      // Now this will be caught if the request takes too long
      throw FetchDataException(desc: "The connection timed out. Please check your internet and try again.");
    } on SocketException {
      throw NoInternetException(desc: "No Internet Connection.");
    }
  }
  dynamic parsedResponse(http.Response res){

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