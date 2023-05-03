import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class AllConsultantsState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? tabTextStyle;
  TextStyle? consultantNameTextStyle;
  TextStyle? consultantCategoryTextStyle;

  AllConsultantsState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.bold,
      fontSize: 28.sp,
      color: customLightThemeColor,
    );
    subHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12.sp,
        color: Colors.white);
    tabTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.semiBold,
      fontSize: 14.sp,
      color: customLightThemeColor,
    );
    consultantNameTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.extraBold,
      fontSize: 14.sp,
      color: customTextBlackColor,
    );
    consultantCategoryTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.light,
      fontSize: 11.sp,
      color: customTextBlackColor,
    );
  }
}
