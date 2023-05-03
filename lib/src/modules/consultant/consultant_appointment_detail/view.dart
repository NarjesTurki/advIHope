import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/widget/bottom_sheet.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/notification_icon.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../consultant_appointment/widget/appontment_detail_box.dart';
import 'package:resize/resize.dart';

class ConsultantAppointmentDetailPage extends StatefulWidget {
  const ConsultantAppointmentDetailPage({Key? key}) : super(key: key);

  @override
  State<ConsultantAppointmentDetailPage> createState() =>
      _ConsultantAppointmentDetailPageState();
}

class _ConsultantAppointmentDetailPageState
    extends State<ConsultantAppointmentDetailPage> {
  final logic = Get.put(ConsultantAppointmentDetailLogic());

  final state = Get.find<ConsultantAppointmentDetailLogic>().state;

  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ConsultantAppointmentDetailLogic>().scrollController =
        ScrollController()
          ..addListener(
              Get.find<ConsultantAppointmentDetailLogic>().scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateUserIdForSendNotification(
          Get.find<ConsultantAppointmentDetailLogic>()
              .selectedAppointmentData
              .menteeId);
      Get.find<GeneralController>().updateAppointmentIdForSendNotification(
          Get.find<ConsultantAppointmentDetailLogic>()
              .selectedAppointmentData
              .id);
      Get.find<SmsLogic>().updatePhoneNumber(
          Get.find<ConsultantAppointmentDetailLogic>()
                  .selectedAppointmentData
                  .mentee
                  ?.phone ??
              '02158860509');
      // log(' ${Get.find<ConsultantAppointmentDetailLogic>().selectedAppointmentData.mentee?.phone}');
    });
    if (Get.find<ConsultantAppointmentDetailLogic>()
                .selectedAppointmentData
                .date !=
            null &&
        Get.find<ConsultantAppointmentDetailLogic>()
                .selectedAppointmentData
                .time !=
            null) {
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
        Get.find<ConsultantAppointmentDetailLogic>().getAudioDifference();
        Get.find<ConsultantAppointmentDetailLogic>().getVideoDifference();
      });
    }
  }

  @override
  void dispose() {
    Get.find<ConsultantAppointmentDetailLogic>()
        .scrollController!
        .removeListener(
            Get.find<ConsultantAppointmentDetailLogic>().scrollListener);
    Get.find<ConsultantAppointmentDetailLogic>().scrollController!.dispose();
    if (Get.find<ConsultantAppointmentDetailLogic>()
                .selectedAppointmentData
                .date !=
            null &&
        Get.find<ConsultantAppointmentDetailLogic>()
                .selectedAppointmentData
                .time !=
            null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ConsultantAppointmentDetailLogic>(
          builder: (_consultantAppointmentDetailLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _consultantAppointmentDetailLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .28,
                      floating: true,
                      pinned: true,
                      snap: false,
                      elevation: 0,
                      backgroundColor:
                          _consultantAppointmentDetailLogic.isShrink
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
                      actions: const [
                        ///---notifications

                        CustomNotificationIcon()
                      ],
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
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .30,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.w, 25.h, 16.w, 16.h),
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
                                              Text(
                                                LanguageConstant.apptDetail.tr,
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.bold,
                                                    fontSize: 28.sp,
                                                    color:
                                                        customLightThemeColor),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${LanguageConstant.yourAppointmentDetailsWith.tr} ${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.firstName}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .medium,
                                                        fontSize: 12.sp,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          ///---CHAT
                                          (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentStatus! ==
                                                      1) &&
                                                  (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentTypeString!
                                                          .toUpperCase() ==
                                                      'CHAT')
                                              ? PositionedDirectional(
                                                  end: 0,
                                                  top: 45.h,
                                                  child: InkWell(
                                                    onTap: () =>
                                                        _consultantAppointmentDetailLogic
                                                            .chatOnTap(context),
                                                    child: CircleAvatar(
                                                      radius: 20.r,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Center(
                                                          child:
                                                              SvgPicture.asset(
                                                        'assets/Icons/chatIcon.svg',
                                                        height: 15.h,
                                                        width: 15.w,
                                                        color:
                                                            customOrangeColor,
                                                        fit: BoxFit.cover,
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),

                                          ///---VIDEO
                                          (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentStatus! ==
                                                      1) &&
                                                  (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentTypeString!
                                                          .toUpperCase() ==
                                                      'VIDEO')
                                              ? (_consultantAppointmentDetailLogic
                                                          .showVideoCallButton!) &&
                                                      (_consultantAppointmentDetailLogic
                                                              .showAppointment ==
                                                          _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .id)
                                                  ? PositionedDirectional(
                                                      end: 0,
                                                      top: 45.h,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            _consultantAppointmentDetailLogic
                                                                .videoOnTap(
                                                                    context),
                                                        child: CircleAvatar(
                                                          radius: 20.r,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                            'assets/Icons/videoCallIcon.svg',
                                                            height: 15.h,
                                                            width: 15.w,
                                                            color:
                                                                customOrangeColor,
                                                            fit: BoxFit.cover,
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox()
                                              : const SizedBox(),

                                          ///
                                          ///---Live
                                          (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentStatus! ==
                                                      1) &&
                                                  (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentTypeString!
                                                          .toUpperCase() ==
                                                      'LIVE')
                                              ? PositionedDirectional(
                                                  end: 0,
                                                  top: 45.h,
                                                  child: InkWell(
                                                    onTap: () =>
                                                        _consultantAppointmentDetailLogic
                                                            .videoOnTap(
                                                                context),
                                                    child: CircleAvatar(
                                                      radius: 18.r,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Center(
                                                          child:
                                                              SvgPicture.asset(
                                                        'assets/Icons/videoCallIcon.svg',
                                                        height: 15.h,
                                                        width: 15.w,
                                                        color:
                                                            customOrangeColor,
                                                        fit: BoxFit.cover,
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),

                                          ///---AUDIO
                                          (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentStatus! ==
                                                      1) &&
                                                  (_consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentTypeString!
                                                          .toUpperCase() ==
                                                      'AUDIO')
                                              ? _consultantAppointmentDetailLogic
                                                          .showAudioCallButton! &&
                                                      _consultantAppointmentDetailLogic
                                                              .showAppointment ==
                                                          _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .id
                                                  ? PositionedDirectional(
                                                      end: 0,
                                                      top: 45.h,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            _consultantAppointmentDetailLogic
                                                                .audioOnTap(
                                                                    context),
                                                        child: CircleAvatar(
                                                          radius: 20.r,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                            'assets/Icons/audio.svg',
                                                            height: 19.h,
                                                            width: 19.w,
                                                            color:
                                                                customOrangeColor,
                                                            fit: BoxFit.cover,
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox()
                                              : const SizedBox(),
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
                    ),
                  ];
                },
                body: Column(
                  children: [
                    AppointmentDetailBox(
                      image: _consultantAppointmentDetailLogic
                          .selectedAppointmentData.mentee!.imagePath,
                      name: _consultantAppointmentDetailLogic
                                  .selectedAppointmentData.mentee!.firstName ==
                              null
                          ? '...'
                          : '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.firstName} '
                              '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.lastName}',
                      category:
                          '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.email}',
                      fee:
                          '${Get.find<GeneralController>().storageBox.read('currency')}${_consultantAppointmentDetailLogic.selectedAppointmentData.payment!} ${LanguageConstant.fees.tr}',
                      type:
                          '${_consultantAppointmentDetailLogic.selectedAppointmentData.appointmentTypeString}'
                              .capitalizeFirst,
                      typeIcon: Get.find<ConsultantAppointmentLogic>()
                              .imagesForAppointmentTypes[
                          (_consultantAppointmentDetailLogic
                                  .selectedAppointmentData.appointmentTypeId!) -
                              1],
                      date: _consultantAppointmentDetailLogic
                                  .selectedAppointmentData.date ==
                              null
                          ? null
                          : DateFormat('dd/MM/yy').format(DateTime.parse(
                              _consultantAppointmentDetailLogic
                                  .selectedAppointmentData.date!)),
                      time: _consultantAppointmentDetailLogic
                                  .selectedAppointmentData.time ==
                              null
                          ? null
                          : _consultantAppointmentDetailLogic
                              .selectedAppointmentData.time!,
                      rating: _consultantAppointmentDetailLogic
                                  .selectedAppointmentData.rating ==
                              null
                          ? 0
                          : _consultantAppointmentDetailLogic
                              .selectedAppointmentData.rating!
                              .toDouble(),
                      status:
                          _consultantAppointmentDetailLogic.appointmentStatus,
                      color: _consultantAppointmentDetailLogic
                              .colorForAppointmentTypes[
                          _consultantAppointmentDetailLogic.appointmentStatus!],
                    )
                  ],
                )),
            bottomNavigationBar: GestureDetector(
              onTap: () {
                openBottomSheet();
              },
              onVerticalDragStart: (event) {
                openBottomSheet();
              },
              child: Container(
                height: 74.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 15,
                        // offset: Offset(1,5)
                      )
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.r))),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: SvgPicture.asset('assets/Icons/bottomUpArrowIcon.svg'),
                )),
              ),
            ),
          ),
        );
      });
    });
  }

  openBottomSheet() {
    return showCupertinoModalBottomSheet(
        topRadius: Radius.circular(30.r),
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const ModalInsideModalForConsultant());
  }
}
