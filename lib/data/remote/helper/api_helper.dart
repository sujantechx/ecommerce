import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_exception.dart';

class ApiHelper {
  Future<dynamic> getAPI({
    required String url,
    Map<String, String>? mHeaders,
    bool isAuth = false,
  }) async{
    if (!isAuth) {
      mHeaders ??= {};

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaders["Authorization"] = "Bearer $token";
    }

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: mHeaders,
      );

      print("res : ${response.body}");
      return parsedResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(desc: "Not connected to network, ${e.message}");
    } catch (e) {
      rethrow;
    }

  }

  Future<dynamic> getApi({
    required String url,
    Map<String, String>? mHeaders,
    bool isAuth = false,
  }) async
  {
    mHeaders ??= {};

    if (isAuth) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaders["Authorization"] = "Bearer $token";
    }

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: mHeaders,
      );

      print("res : ${response.body}");
      return parsedResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(desc: "Not connected to network, ${e.message}");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postAPI({
    required String url,
    Map<String, String>? mHeaders,
    Map<String, dynamic>? mBody,
    bool isAuth = false,
  }) async {
    if (!isAuth) {
      mHeaders ??= {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaders["Authorization"] = "Bearer $token";
    }
    try {
      var response = await http.post(
        Uri.parse(url),
        body: mBody != null ? jsonEncode(mBody) : null,
        headers: mHeaders,
      );
      print("res : ${response.body}");
      return parsedResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(desc: "Not connected to network, ${e.message}");
    } catch (e) {
      rethrow;
    }
  }

  dynamic parsedResponse(http.Response res) {
    /*if(res.statusCode==200){

    } else if(res.statusCode==300){

    }*/

    switch (res.statusCode) {
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