import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class AboutUsState {
  TextStyle? headingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? subHeadingTextStyle;
  AboutUsState() {
    ///Initialize variables
    headingTextStyle = const TextStyle(
        fontSize: 20,
        fontFamily: SarabunFontFamily.extraBold,
        color: customTextBlackColor);
    descTextStyle = const TextStyle(
        fontSize: 14,
        fontFamily: SarabunFontFamily.regular,
        color: customTextBlackColor);
    subHeadingTextStyle = const TextStyle(
        fontSize: 14, fontFamily: SarabunFontFamily.bold, color: Colors.white);
  }
}
