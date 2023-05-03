import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class ScheduleInfoState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? numberTextStyle;
  TextStyle? textFieldTextStyle;
  TextStyle? hintTextStyle;
  TextStyle? slotsTitleTextStyle;
  TextStyle? typeTextStyle;
  TextStyle? scheduleDayTextStyle;
  ScheduleInfoState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
        fontSize: 28.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customLightThemeColor);
    subHeadingTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.white);
    descTextStyle = TextStyle(
      fontSize: 10.sp,
      fontFamily: SarabunFontFamily.regular,
      color: Colors.white,
    );
    numberTextStyle = TextStyle(
      fontSize: 14.sp,
      fontFamily: SarabunFontFamily.regular,
      color: Colors.white,
    );
    textFieldTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 15.sp,
        color: Colors.black);
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
    slotsTitleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 16.sp,
        color: customTextBlackColor);
    typeTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 14.sp,
        color: customTextBlackColor);
    scheduleDayTextStyle = const TextStyle(
        fontSize: 14,
        fontFamily: SarabunFontFamily.regular,
        color: customTextBlackColor);
  }
}
