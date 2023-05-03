import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/get_repo.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:ista_app/src/modules/user_profile/repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class EditConsultantProfilePage extends StatefulWidget {
  const EditConsultantProfilePage({Key? key}) : super(key: key);

  @override
  State<EditConsultantProfilePage> createState() =>
      _EditConsultantProfilePageState();
}

class _EditConsultantProfilePageState extends State<EditConsultantProfilePage> {
  final logic = Get.put(EditConsultantProfileLogic());

  final state = Get.find<EditConsultantProfileLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoaderController(true);
    });
    Get.find<EditConsultantProfileLogic>().scrollController = ScrollController()
      ..addListener(Get.find<EditConsultantProfileLogic>().scrollListener);
    Get.find<EditConsultantProfileLogic>().stepperScrollController =
        ScrollController();

    Get.find<EditConsultantProfileLogic>().emptyOccupationDropDownList();
    Get.find<EditConsultantProfileLogic>().emptyCountryDropDownList();
    Get.find<EditConsultantProfileLogic>().emptyCityDropDownList();
    Get.find<EditConsultantProfileLogic>().emptyDegreeDropDownList();
    Get.find<EditConsultantProfileLogic>().emptyForDisplayEducationList();

    Get.find<EditConsultantProfileLogic>().getSetData(context);

    getMethod(
        context,
        getUserProfileUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getUserProfileForEditRepo);
    getMethod(context, mentorProfileGenericDataUrl, {'token': '123'}, false,
        getGenericDataRepo);

    getMethod(context, mentorParentCategoryDataUrl, {'token': '123'}, false,
        getParentCategoryRepo);
  }

  @override
  void dispose() {
    Get.find<EditConsultantProfileLogic>()
        .scrollController!
        .removeListener(Get.find<EditConsultantProfileLogic>().scrollListener);
    Get.find<EditConsultantProfileLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<EditConsultantProfileLogic>(
          builder: (_editConsultantProfileLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: customThemeColor,
            body: NestedScrollView(
                controller: _editConsultantProfileLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .32,
                      floating: true,
                      pinned: true,
                      snap: false,
                      elevation: 0,
                      backgroundColor: _editConsultantProfileLogic.isShrink
                          ? customThemeColor
                          : Colors.transparent,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width:
                                        MediaQuery.of(context).size.width * .1,
                                    height: MediaQuery.of(context).size.height *
                                        .35,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.w, 25.h, 0.w, 16.h),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w),
                                                child: Text(
                                                    LanguageConstant
                                                        .editProfile.tr,
                                                    style: TextStyle(
                                                        fontSize: 28.sp,
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .bold,
                                                        color: Colors.white)),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w),
                                                child: Text(
                                                    LanguageConstant
                                                        .editYourProfile.tr,
                                                    style: state
                                                        .subHeadingTextStyle),
                                              ),

                                              ///---stepper
                                              Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(5.w,
                                                                  20.h, 5.w, 0),
                                                      child: SizedBox(
                                                        height: 85.h,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: ListView(
                                                            controller:
                                                                _editConsultantProfileLogic
                                                                    .stepperScrollController,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children:
                                                                List.generate(
                                                              _editConsultantProfileLogic
                                                                  .stepperList
                                                                  .length,
                                                              (index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (_editConsultantProfileLogic
                                                                            .stepperList[
                                                                                index]
                                                                            .isCompleted! ||
                                                                        _editConsultantProfileLogic
                                                                            .stepperList[index]
                                                                            .isSelected!) {
                                                                      _editConsultantProfileLogic
                                                                          .updateStepperIndex(
                                                                              index);
                                                                    }
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .25,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            index == 0
                                                                                ? const Spacer()
                                                                                : Expanded(
                                                                                    child: Container(
                                                                                      height: 5.h,
                                                                                      color: _editConsultantProfileLogic.stepperList[index - 1].isCompleted! ? customGreenColor : Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            CircleAvatar(
                                                                              radius: 18.r,
                                                                              backgroundColor: !_editConsultantProfileLogic.stepperList[index].isCompleted!
                                                                                  ? _editConsultantProfileLogic.stepperList[index].isSelected!
                                                                                      ? customOrangeColor
                                                                                      : Colors.white
                                                                                  : customGreenColor,
                                                                              child: _editConsultantProfileLogic.stepperList[index].isCompleted!
                                                                                  ? const Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.white,
                                                                                      size: 20,
                                                                                    )
                                                                                  : Text(
                                                                                      _editConsultantProfileLogic.stepperList[index].stepperLabel!,
                                                                                      style: state.stepperTextStyle!.copyWith(
                                                                                          color: !_editConsultantProfileLogic.stepperList[index].isCompleted!
                                                                                              ? _editConsultantProfileLogic.stepperList[index].isSelected!
                                                                                                  ? Colors.white
                                                                                                  : const Color(0xff727377)
                                                                                              : Colors.white),
                                                                                    ),
                                                                            ),
                                                                            index == _editConsultantProfileLogic.stepperList.length - 1
                                                                                ? const SizedBox()
                                                                                : Expanded(
                                                                                    child: Container(
                                                                                      height: 5.h,
                                                                                      color: _editConsultantProfileLogic.stepperList[index + 1].isSelected!
                                                                                          ? customGreenColor
                                                                                          : _editConsultantProfileLogic.stepperList[index + 1].isCompleted!
                                                                                              ? customGreenColor
                                                                                              : Colors.white,
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4.h,
                                                                        ),
                                                                        Text(
                                                                          _editConsultantProfileLogic
                                                                              .stepperList[index]
                                                                              .title!,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              state.stepperLabelTextStyle,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            )),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: customTextFieldColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r)),
                      child: _editConsultantProfileLogic
                          .consultantProfileNavigation(
                              _editConsultantProfileLogic.stepperIndex,
                              context),
                    ))),
          ),
        );
      });
    });
  }
}
