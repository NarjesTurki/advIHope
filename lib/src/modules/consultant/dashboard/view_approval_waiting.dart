import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class MentorApprovalWaitingView extends StatefulWidget {
  const MentorApprovalWaitingView({Key? key}) : super(key: key);

  @override
  _MentorApprovalWaitingViewState createState() =>
      _MentorApprovalWaitingViewState();
}

class _MentorApprovalWaitingViewState extends State<MentorApprovalWaitingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              customThemeColor,
              customLightThemeColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                    child: InkWell(
                      onTap: () {
                        Get.find<GeneralController>().storageBox.erase();
                        Navigator.pop(context);
                        Get.offAllNamed(PageRoutes.userHome);
                      },
                      child: CircleAvatar(
                        backgroundColor: customTextFieldColor.withOpacity(0.5),
                        radius: 30,
                        child: const Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/waitingImage.svg',
                      width: MediaQuery.of(context).size.width * .5,
                    ),
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LanguageConstant.yourProfileIsUnder.tr,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: SarabunFontFamily.regular,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LanguageConstant.under.tr,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: SarabunFontFamily.extraBold,
                              color: customOrangeColor),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Text(
                          LanguageConstant.review.tr,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: SarabunFontFamily.extraBold,
                              color: customOrangeColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      LanguageConstant.youWillBeNotifiedOnceItGetApprove.tr,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: SarabunFontFamily.regular,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
