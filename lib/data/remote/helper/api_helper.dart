import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_exception.dart';
class ApiHelper {

    Future<dynamic> getApi({
      required String url,
      Map<String,String>? mHeaders,
      bool isAuth=false,

    })async{
      if(!isAuth){
        mHeaders ??={};

        SharedPreferences prefs=await SharedPreferences.getInstance();
        String token=prefs.getString("token")??"";
        mHeaders["Authorization"]="Bearer$token";
      }
      try{
        var response=await http.get(
          Uri.parse(url),
          headers: mHeaders,
        );
        print("res:${response.body}");
        return parsedResponse(response);
      }on SocketException catch(e){
        throw NoInternetException(desc: "Not connected to network,${e.message}");

      }catch (e){
        rethrow;
      }
    }
  postAPI(
  {
    required String url,
    Map<String,String>? mHeader,
    Map<String,dynamic>? mBody,
    bool isAuth=false
})async{
    if(!isAuth){
      mHeader??={};

    }
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