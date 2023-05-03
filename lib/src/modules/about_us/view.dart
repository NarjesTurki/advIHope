import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/about_us/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:resize/resize.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final logic = Get.put(AboutUsLogic());

  final state = Get.find<AboutUsLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<AboutUsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<AboutUsLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<AboutUsLogic>()
        .scrollController!
        .removeListener(Get.find<AboutUsLogic>().scrollListener);
    Get.find<AboutUsLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<AboutUsLogic>(builder: (_aboutUsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _aboutUsLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header

                    MyCustomSliverAppBar(
                      heading: LanguageConstant.aboutUs.tr,
                      subHeading:
                          LanguageConstant.getKnowAboutOurVisionAndMission.tr,
                      isShrink: _aboutUsLogic.isShrink,
                    ),
                  ];
                },
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                          child: Text(
                            LanguageConstant.ourVision.tr,
                            style: state.headingTextStyle,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(end: 14.w),
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                    'Pellentesque sem elit, tempus ac justo eu, pellentesque laoreet velit. '
                                    'Suspendisse lobortis a lacus quis pretium. Aliquam posuere auctor fermentum.',
                                    // softWrap: true,
                                    // overflow: TextOverflow.ellipsis,
                                    // maxLines: 5,
                                    // textAlign: TextAlign.justify,
                                    style: state.descTextStyle,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 28.w),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 14.w),
                                  child: SizedBox(
                                    // height: 149.h,
                                    width: 136.w,
                                    child: Image.asset(
                                      'assets/images/vision.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 36.h),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  (MediaQuery.of(context).size.width * .5 / 2) +
                                      15,
                                  0,
                                  0,
                                  0),
                              child: Text(
                                LanguageConstant.ourMission.tr,
                                style: state.headingTextStyle,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.w, 0, 16.w, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(end: 28.w),
                                      child: SizedBox(
                                        // height: 149.h,
                                        width: 136.w,
                                        child: Image.asset(
                                          'assets/images/mission.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 15.w),
                                  Expanded(
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                      'Pellentesque sem elit, tempus ac justo eu, pellentesque laoreet velit. '
                                      'Suspendisse lobortis a lacus quis pretium. Aliquam posuere auctor fermentum.',
                                      // softWrap: true,
                                      // overflow: TextOverflow.ellipsis,
                                      // maxLines: 5,
                                      // textAlign: TextAlign.justify,
                                      style: state.descTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 50.h),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                          child: Text(
                            LanguageConstant.whyChooseUs.tr,
                            style: state.headingTextStyle,
                          ),
                        ),
                        SizedBox(height: 23.h),
                        Column(
                          children: [
                            Container(
                              color: customThemeColor,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 16.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 74,
                                            color: customThemeColor,
                                            child: SvgPicture.asset(
                                                'assets/Icons/check-circle.svg')),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: customLightThemeColor,
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ///---heading
                                            Text(
                                              LanguageConstant.easySignUp.tr,
                                              style: state.subHeadingTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),

                                            ///---detail
                                            Text(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sem elit, '
                                                      'tempus ac justo eu, pellentesque laoreet'
                                                  .tr,
                                              style: state.descTextStyle
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey,
                            ),
                            Container(
                              color: customThemeColor,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 16.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 74,
                                            color: customThemeColor,
                                            child: SvgPicture.asset(
                                                'assets/Icons/user-badged.svg')),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: customLightThemeColor,
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ///---heading
                                            Text(
                                              LanguageConstant
                                                  .professionalConsultants.tr,
                                              style: state.subHeadingTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),

                                            ///---detail
                                            Text(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sem elit, '
                                                      'tempus ac justo eu, pellentesque laoreet'
                                                  .tr,
                                              style: state.descTextStyle
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      });
    });
  }
}
