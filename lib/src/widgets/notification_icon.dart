import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNotificationIcon extends StatelessWidget {
  const CustomNotificationIcon({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 15),
        child: color == null
            ? SvgPicture.asset('assets/Icons/notificationIcon.svg')
            : SvgPicture.asset(
                'assets/Icons/notificationIcon.svg',
                color: color,
              ),
      ),
    );
  }
}
