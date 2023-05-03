import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class DashboardState {
  TextStyle? mentorDetailTileTitleTextStyle;
  TextStyle? mentorDetailTileTitle2TextStyle;
  TextStyle? mentorDetailTileTitle3TextStyle;
  TextStyle? appointmentCountTitleTextStyle;
  TextStyle? appointmentCountValueTextStyle;
  TextStyle? headingTextStyle;
  TextStyle? ratingTextStyle;
  TextStyle? appointmentListLabelTextStyle;
  TextStyle? appointmentListValueTextStyle;
  DashboardState() {
    ///Initialize variables
    mentorDetailTileTitleTextStyle = TextStyle(
        fontSize: 13.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customLightThemeColor);
    mentorDetailTileTitle2TextStyle = TextStyle(
        fontSize: 13.sp,
        fontFamily: SarabunFontFamily.light,
        color: customTextBlackColor);
    mentorDetailTileTitle3TextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.light,
        color: customTextBlackColor);
    appointmentCountTitleTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.white);
    appointmentCountValueTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.bold,
        color: Colors.white);
    headingTextStyle = TextStyle(
        fontSize: 20.sp,
        fontFamily: SarabunFontFamily.extraBold,
        color: customTextBlackColor);
    ratingTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.regular,
        color: Colors.black);
    appointmentListLabelTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customThemeColor);
    appointmentListValueTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.medium,
        color: customTextBlackColor);
  }
}
