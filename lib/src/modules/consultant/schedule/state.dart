import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class MentorScheduleState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? scheduleDayTextStyle;
  TextStyle? textFieldTextStyle;
  TextStyle? addButtonTextStyle;
  TextStyle? slotTextStyle;
  TextStyle? previewLabelTextStyle;
  TextStyle? previewValueTextStyle;
  TextStyle? hintTextStyle;

  MentorScheduleState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.semiBold,
        color: Colors.black);
    subHeadingTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.bold,
        color: Colors.black);
    scheduleDayTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.regular,
        color: Colors.black);
    textFieldTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: Colors.black);
    addButtonTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 16.sp,
        color: Colors.white);
    slotTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 12.sp,
        color: Colors.black);
    previewLabelTextStyle = TextStyle(
        fontSize: 10.sp, fontWeight: FontWeight.w400, color: Color(0xff727377));
    previewValueTextStyle = TextStyle(
        fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.black);
    hintTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.regular,
        color: customTextGreyColor);
  }
}
