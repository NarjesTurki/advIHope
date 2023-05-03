import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class ChatState {
  TextStyle? userNameTextStyle;
  TextStyle? categoryTextStyle;
  TextStyle? dateTimeTextStyle;
  TextStyle? replyTextStyle;
  TextStyle? messageTextStyle;
  TextStyle? textFieldTextStyle;
  ChatState() {
    ///Initialize variable
    userNameTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.extraBold,
      fontSize: 16.sp,
      color: Colors.white,
    );
    categoryTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.light,
      fontSize: 12.sp,
      color: Colors.white,
    );
    dateTimeTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.regular,
      fontSize: 12.sp,
      color: const Color(0xff8F9596),
    );
    replyTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.regular,
      fontSize: 14.sp,
      color: const Color(0xff303639),
    );
    messageTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.regular,
      fontSize: 14.sp,
      color: Colors.white,
    );
    textFieldTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.regular,
      fontSize: 14.sp,
      color: Colors.white,
    );
  }
}
