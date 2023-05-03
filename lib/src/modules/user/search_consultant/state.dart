import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class SearchConsultantState {
  TextStyle? hintTextStyle;
  TextStyle? topTitleTextStyle;
  TextStyle? topSubTitleTextStyle;

  SearchConsultantState() {
    ///Initialize variables
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
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
