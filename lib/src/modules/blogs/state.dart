import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class BlogsState {
  TextStyle? headingTextStyle;
  TextStyle? categoryTextStyle;
  TextStyle? blogCategoryTextStyle;
  TextStyle? blogNameTextStyle;
  TextStyle? authorNameTextStyle;
  TextStyle? blogDescTextStyle;
  TextStyle? blogListTileTitle;
  TextStyle? blogTimeTextStyle;
  BlogsState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
        fontSize: 18.sp,
        fontFamily: SarabunFontFamily.extraBold,
        color: customTextBlackColor);
    categoryTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.extraBold,
        color: Colors.white);
    blogCategoryTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: SarabunFontFamily.medium,
        color: customOrangeColor);
    blogNameTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.semiBold,
        color: customThemeColor);
    authorNameTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.medium,
        color: customTextBlackColor);
    blogDescTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.light,
        color: customTextBlackColor);
    blogListTileTitle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.light,
        color: customTextBlackColor);
    blogTimeTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.light,
        color: customTextBlackColor);
  }
}
