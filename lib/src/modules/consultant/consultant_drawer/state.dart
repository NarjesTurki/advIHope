import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class ConsultantDrawerState {
  TextStyle? nameTextStyle;
  TextStyle? emailTextStyle;
  TextStyle? titleTextStyle;
  ConsultantDrawerState() {
    ///Initialize variables
    nameTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 16.sp,
        color: Colors.black);
    emailTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.light,
        fontSize: 12.sp,
        color: Colors.black);
    titleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 14.sp,
        color: Colors.black);
  }
}
