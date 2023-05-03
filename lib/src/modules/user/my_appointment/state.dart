import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class MyAppointmentState {
  TextStyle? tabBarSelectedTextStyle;
  TextStyle? tabBarUnSelectedTextStyle;
  TextStyle? profileNameTextStyle;
  TextStyle? profileCategoryTextStyle;
  TextStyle? feeTextStyle;
  TextStyle? dateTimeTextStyle;
  TextStyle? statusTextStyle;

  MyAppointmentState() {
    ///Initialize variables
    tabBarSelectedTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 14.sp,
        color: Colors.white);
    tabBarUnSelectedTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 14.sp,
        color: customLightThemeColor);
    profileNameTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 16.sp,
        color: customTextBlackColor);
    profileCategoryTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.light,
        fontSize: 12.sp,
        color: customTextBlackColor);
    feeTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 14.sp,
        color: customTextBlackColor);
    dateTimeTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 14.sp,
        color: Colors.white);
    statusTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 10.sp,
        color: Colors.white);
  }
}
