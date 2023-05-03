import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class EditUserProfileState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? hintTextStyle;
  TextStyle? textFieldTextStyle;
  TextStyle? hideTextStyle;

  EditUserProfileState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
        fontSize: 28.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customLightThemeColor);
    subHeadingTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.white);
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
    textFieldTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: Colors.black);
    hideTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 19.sp,
        color: Colors.black);
  }
}
