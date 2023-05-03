import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class ConsultantProfileState {
  TextStyle? profileNameTextStyle;
  TextStyle? categoryTextStyle;
  TextStyle? headingTextStyle;
  TextStyle? dataTextStyle;
  TextStyle? typesTextStyle;
  TextStyle? tagTextStyle;

  ConsultantProfileState() {
    ///Initialize variables
    profileNameTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 22.sp,
        color: customTextBlackColor);
    categoryTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.light,
        fontSize: 16.sp,
        color: customTextBlackColor);
    headingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 18.sp,
        color: customTextBlackColor);
    dataTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 14.sp,
        color: customTextBlackColor);
    dataTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 14.sp,
        color: customTextBlackColor);
    tagTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.regular,
        color: Colors.white);
  }
}
