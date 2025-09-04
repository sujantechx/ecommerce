import 'package:ecommerce/domain/Utils/ui_helper/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_helper.dart';

class UiButtonHelper{
  CustomButtom({
    required VoidCallback callback,
    required String buttonName,
    required Color bgColor,
    required Color fgColor,
    required double? width,
  }){
    return ElevatedButton(onPressed: (){
      callback();
    },style: ElevatedButton.styleFrom(
      backgroundColor:bgColor,
      foregroundColor: fgColor,
      minimumSize: Size(width!, 45),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),),
        child: Text(
          buttonName,
          style: mTextStyle16(mFontWeight: FontWeight.bold,textColor: Colors.white)
        ));
  }

  CustomButtonFlex({required VoidCallback callback, required String buttonName}){
    return SizedBox(
      height: 45,
      width: double.infinity,
      // width: double.infinity,
      child: ElevatedButton(onPressed: (){
        callback();
      },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            buttonName,style: TextStyle(fontSize: 16,color:ColorConstant.white),
          )),
    );
  }
}
class HelperButtonStyle{

 }