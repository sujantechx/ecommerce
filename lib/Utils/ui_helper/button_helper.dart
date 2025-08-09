 import 'package:ecommerce/Utils/ui_helper/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_helper.dart';

class UiButtonHelper{
  CustomButtomFlex({
    required VoidCallback callback,
    required String buttonName,
    double? height, double? width

  }){
    return SizedBox(
      height: height,
      width: width,
      // width: double.infinity,
      // width: double.infinity,
      child: ElevatedButton(onPressed: (){
        callback();
      },
          style: ElevatedButton.styleFrom(

              backgroundColor:ColorConstant.orange,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
          child: Text(
            buttonName,
            style: mTextStyle16(mFontWeight: FontWeight.bold,textColor: Colors.white)
            // TextStyle(fontSize: 15,color:ColorConstant.white),
          )),
    );
  }

  CustomButtom({required VoidCallback callback, required String buttonName}){
    return SizedBox(
      height: 45,
      width: double.infinity,
      // width: double.infinity,
      child: ElevatedButton(onPressed: (){
        callback();
      },
          style: ElevatedButton.styleFrom(
              backgroundColor:ColorConstant.orange,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
          child: Text(
            buttonName,style: TextStyle(fontSize: 16,color:ColorConstant.white),
          )),
    );
  }
}
