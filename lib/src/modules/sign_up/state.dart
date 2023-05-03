import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class SignUpState {
  TextStyle? headingTextStyle;
  TextStyle? captionTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? hintTextStyle;
  TextStyle? forgotTextStyle;
  TextStyle? buttonTextStyle;
  TextStyle? orTextStyle;
  TextStyle? descTextStyle;
  SignUpState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 28.sp,
        color: customTextBlackColor);
    captionTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12.sp,
        color: customLightThemeColor);
    subHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 18.sp,
        color: customTextBlackColor);
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
    forgotTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 14.sp,
        color: customLightThemeColor);
    buttonTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 16.sp,
        color: Colors.white);
    orTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 12.sp,
        color: const Color(0xff9D9D9D));
    descTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 12.sp,
        color: Colors.black);
  }
}
