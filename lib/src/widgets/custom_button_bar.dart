import 'package:flutter/material.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';

class MyCustomBottomBar extends StatefulWidget {
  const MyCustomBottomBar(
      {Key? key, required this.title, required this.disable})
      : super(key: key);

  final String? title;
  final bool? disable;

  @override
  _MyCustomBottomBarState createState() => _MyCustomBottomBarState();
}

class _MyCustomBottomBarState extends State<MyCustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: customThemeColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: customThemeColor.withOpacity(0.7),
                    spreadRadius: -18,
                    blurRadius: 30,
                    offset: const Offset(0, 30))
              ]),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.title}',
                        style: TextStyle(
                            fontFamily: SarabunFontFamily.bold,
                            fontSize: 16.sp,
                            color: Colors.white),
                      ),
                      SvgPicture.asset(
                        'assets/Icons/whiteForwardIcon.svg',
                        height: 29.h,
                        width: 29.w,
                      )
                    ],
                  ),
                ),
              ),
              widget.disable!
                  ? Container(
                      color: Colors.white.withOpacity(0.5),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
