import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/on_board/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class OnBoard4Page extends StatefulWidget {
  const OnBoard4Page({Key? key}) : super(key: key);

  @override
  State<OnBoard4Page> createState() => _OnBoard4PageState();
}

class _OnBoard4PageState extends State<OnBoard4Page> {
  final state = Get.find<OnBoardLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardLogic>(builder: (_onBoardLogic) {
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10.h, 0, 0),
            child: ListView(children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  ///---image

                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.75,
                    width: double.infinity,
                    child: Image.asset('assets/images/onBoard4.png',
                        fit: BoxFit.cover),
                  ),

                  ///---text-area
                  Positioned(
                    bottom: -15.h,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15.w, .0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Ask Your',
                            style: state.firstTitle,
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 10.w),
                            child: Container(
                              color: customOrangeColor,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    40.w, 0, 29.w, 0),
                                child: Text(
                                  LanguageConstant.question.tr,
                                  style: state.firstTitle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'And Quickly Pay The Fee',
                            style: state.subTitle,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              ///---buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///---skip
                    InkWell(
                      onTap: () {
                        Get.find<GeneralController>()
                            .storageBox
                            .write('onBoard', 'true');
                        Get.offAllNamed(PageRoutes.userHome);
                      },
                      child: Text('Skip',
                          style: TextStyle(
                              fontFamily: SarabunFontFamily.medium,
                              fontSize: 14.sp,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white)),
                    ),

                    ///---next
                    InkWell(
                        onTap: () {
                          Get.find<GeneralController>()
                              .storageBox
                              .write('onBoard', 'true');
                          Get.offAllNamed(PageRoutes.userHome);
                        },
                        child: SvgPicture.asset(
                            'assets/Icons/forwardBlackIcon.svg')),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Image.asset(
                  'assets/images/screenPointer4.png',
                  width: 78.h,
                  height: 9.w,
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
