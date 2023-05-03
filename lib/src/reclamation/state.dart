import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class ReaclamtionState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? viewAllTextStyle;
  TextStyle? topTitleTextStyle;
  TextStyle? topSubTitleTextStyle;

  ReaclamtionState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 28.sp,
        color: customLightThemeColor);
    subHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 20.sp,
        color: customTextBlackColor);
    viewAllTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12.sp,
        color: customThemeColor,
        decoration: TextDecoration.underline);
    topTitleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 16.sp,
        color: Colors.white);
    topSubTitleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.light,
        fontSize: 12.sp,
        color: Colors.white);
  }
}
