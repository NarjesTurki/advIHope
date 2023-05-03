import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class WalletState {
  TextStyle? headingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? recordTextStyle;
  TextStyle? transactionTextStyle;
  TextStyle? feeTextStyle;
  TextStyle? dateTextStyle;
  TextStyle? typeTextStyle;
  TextStyle? textFieldTextStyle;
  TextStyle? hintTextStyle;

  WalletState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
      fontSize: 28.sp,
      fontFamily: SarabunFontFamily.bold,
      color: Colors.black,
    );
    descTextStyle = TextStyle(
      fontSize: 12.sp,
      fontFamily: SarabunFontFamily.medium,
      color: Colors.white,
    );
    subHeadingTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.semiBold,
        color: Colors.black);
    recordTextStyle = TextStyle(
      fontSize: 18.sp,
      fontFamily: SarabunFontFamily.extraBold,
      color: customTextBlackColor,
    );
    transactionTextStyle = TextStyle(
      fontSize: 16.sp,
      fontFamily: SarabunFontFamily.extraBold,
      color: customTextBlackColor,
    );
    feeTextStyle = TextStyle(
      fontSize: 14.sp,
      fontFamily: SarabunFontFamily.regular,
      color: customTextBlackColor,
    );
    typeTextStyle = TextStyle(
      fontSize: 10.sp,
      fontFamily: SarabunFontFamily.regular,
      color: customTextBlackColor,
    );
    dateTextStyle = TextStyle(
      fontSize: 14.sp,
      fontFamily: SarabunFontFamily.semiBold,
      color: const Color(0xffA2A7AA),
    );
    textFieldTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 15.sp,
        color: Colors.black);
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
  }
}
