import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class CreateProfileState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? numberTextStyle;
  TextStyle? hintTextStyle;
  TextStyle? textFieldTextStyle;
  TextStyle? stepperTextStyle;
  TextStyle? stepperLabelTextStyle;
  TextStyle? addButtonTextStyle;
  TextStyle? previewLabelTextStyle;
  TextStyle? previewValueTextStyle;
  CreateProfileState() {
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
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 12.sp,
        color: customTextGreyColor);
    textFieldTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 15.sp,
        color: Colors.black);
    stepperTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.regular,
        color: const Color(0xff727377));
    stepperLabelTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.regular,
        color: Colors.white);
    addButtonTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.white);
    previewLabelTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.regular,
        color: const Color(0xff757575));
    previewValueTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.black);
  }
}
