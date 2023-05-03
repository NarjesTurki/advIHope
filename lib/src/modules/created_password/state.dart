import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class CreatedPasswordState {
  TextStyle? headingTextStyle;
  TextStyle? subheadingTextStyle;
  CreatedPasswordState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
        fontSize: 28.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customTextBlackColor);
    subheadingTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.medium,
        color: customOrangeColor);
  }
}
