import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/utils/colors.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(55);

  const MyCustomAppBar({Key? key, this.drawerShow, this.whiteBackground})
      : super(key: key);
  final bool? drawerShow;
  final bool? whiteBackground;

  @override
  Widget build(BuildContext context) {
    return drawerShow!
        ? AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                          color: whiteBackground!
                              ? customIconBackgroundThemeColor
                              : customIconBackgroundWhiteColor,
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: whiteBackground!
                                ? customThemeColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            actions: const [],
          )
        : AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/Icons/blueBackIcon.svg',
                      width: 23.w,
                      height: 23.h,
                    ),
                  ],
                )),
            actions: const [],
          );
  }
}
