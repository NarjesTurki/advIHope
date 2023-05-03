import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class SplashState {
  TextStyle? titleTextStyle;
  TextStyle? subTitleTextStyle;

  SplashState() {
    ///Initialize variables
    titleTextStyle = TextStyle(
        fontSize: 23.sp,
        fontFamily: SarabunFontFamily.bold,
        color: Colors.white);
    subTitleTextStyle = TextStyle(
        fontSize: 17.sp,
        fontFamily: SarabunFontFamily.regular,
        color: Colors.white);
  }
}
