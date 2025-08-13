import 'package:flutter/foundation.dart';

class ProviderNav with ChangeNotifier{
  int _curIndex = 0;
  int getCurentPageIndex()=>_curIndex;

  void updatePageIndex({required int index}){
    _curIndex =index;
    notifyListeners();
  }

}