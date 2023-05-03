import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class OtpState {
  TextStyle? headingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? numberTextStyle;
  OtpState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.extraBold,
        color: customTextBlackColor);
    descTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.regular,
        color: const Color(0xff9D9D9D));
    numberTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.regular,
        color: customThemeColor);
  }
}
