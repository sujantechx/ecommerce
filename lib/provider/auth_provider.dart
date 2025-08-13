import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _dummyEmail = "Sujan@gmail.com";
  String _dummyPassword = "123456";

  bool login(String email, String password) {
    return email == _dummyEmail && password == _dummyPassword;
  }

  bool signup(String fullName, String email, String phone, String password) {
    _dummyEmail = email;
    _dummyPassword = password;
    return true; // Always success in dummy
  }

  bool resetPassword(String newPassword) {
    _dummyPassword = newPassword;
    return true;
  }
}
