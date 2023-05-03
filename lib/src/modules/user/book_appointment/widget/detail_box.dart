import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';

class BookAppointmentDetailBox extends StatelessWidget {
  const BookAppointmentDetailBox({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
          color: customTextFieldColor, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              '$image',
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '$title',
              style: const TextStyle(
                  fontFamily: SarabunFontFamily.regular,
                  fontSize: 14,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
