import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class OnBoardState {
  TextStyle? firstTitle;
  TextStyle? secondTitle;
  TextStyle? subTitle;
  OnBoardState() {
    ///Initialize variables

    firstTitle = TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 36.sp,
        color: Colors.white);
    secondTitle = TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 34.sp,
        color: Colors.white);
    subTitle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 14.sp,
        color: Colors.white);
  }
}
