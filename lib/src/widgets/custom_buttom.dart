import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 55.h,
        width: MediaQuery.of(context).size.width * .73,
        decoration: BoxDecoration(
            color: customThemeColor,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: [
              BoxShadow(
                  color: customThemeColor.withOpacity(0.5),
                  spreadRadius: -18,
                  blurRadius: 30,
                  offset: const Offset(0, 35))
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontFamily: SarabunFontFamily.bold,
                    fontSize: 16.sp,
                    color: Colors.white),
              ),
              SvgPicture.asset(
                'assets/Icons/whiteForwardIcon.svg',
                width: 29.w,
                height: 29.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
