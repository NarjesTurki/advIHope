import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class ContactUsState {
  TextStyle? titleTextStyle;
  TextStyle? subTitleTextStyle;
  ContactUsState() {
    ///Initialize variables

    titleTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.white);
    subTitleTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.regular,
        color: Colors.white);
  }
}
