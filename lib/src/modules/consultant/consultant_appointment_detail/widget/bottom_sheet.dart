import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/header.dart';
import 'package:ista_app/src/api_services/logic.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/model_file_attachment.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:resize/resize.dart';

class ModalInsideModalForConsultant extends StatefulWidget {
  const ModalInsideModalForConsultant({Key? key}) : super(key: key);

  @override
  State<ModalInsideModalForConsultant> createState() =>
      _ModalInsideModalForConsultantState();
}

class _ModalInsideModalForConsultantState
    extends State<ModalInsideModalForConsultant> {
  File? degreeImage;
  List degreeImagesList = [];

  GlobalKey<FormState> noteFormKey = GlobalKey();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ConsultantAppointmentDetailLogic>().state;
    return GetBuilder<ConsultantAppointmentDetailLogic>(
        builder: (_consultantAppointmentDetailLogic) {
      return Material(
        child: Container(
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: customTextFieldColor,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30.r))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
              child: Column(
                children: [
                  Center(
                      child: SvgPicture.asset(
                          'assets/Icons/bottomDownArrowIcon.svg')),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        ///---appointment-info
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageConstant.appointmentInfo.tr,
                                  style: state.sectionHeadingTextStyle,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                ///---date-time-reg.
                                Row(
                                  children: [
                                    ///---date
                                    _consultantAppointmentDetailLogic
                                                .selectedAppointmentData.date ==
                                            null
                                        ? const SizedBox()
                                        : Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant.date.tr,
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  DateFormat('dd/MM/yy').format(
                                                      DateTime.parse(
                                                          _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .date!)),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                    ///---time
                                    _consultantAppointmentDetailLogic
                                                .selectedAppointmentData.time ==
                                            null
                                        ? const SizedBox()
                                        : Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant.time.tr,
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                      .selectedAppointmentData
                                                      .time!,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                    ///---reg. no
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.regNo.tr,
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData.id
                                                .toString(),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),

                                ///---type-doc.
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///---type
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.appointmentType.tr,
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData
                                                .appointmentTypeString!
                                                .capitalizeFirst!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---document
                                    _consultantAppointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                null ||
                                            _consultantAppointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                ''
                                        ? const SizedBox()
                                        : Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                launch(_consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .file!
                                                        .contains('assets')
                                                    ? '$mediaUrl/${_consultantAppointmentDetailLogic.selectedAppointmentData.file}'
                                                    : '${_consultantAppointmentDetailLogic.selectedAppointmentData.file}');
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    LanguageConstant
                                                        .document.tr,
                                                    style: state
                                                        .sectionLabelTextStyle,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .fileType!,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: state
                                                        .sectionDataTextStyle!
                                                        .copyWith(
                                                            color:
                                                                customLightThemeColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),

                                ///---question.
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ///---question
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              LanguageConstant.question.tr,
                                              style:
                                                  state.sectionLabelTextStyle,
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              _consultantAppointmentDetailLogic
                                                  .selectedAppointmentData
                                                  .questions!,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: state.sectionDataTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),

                                SizedBox(
                                  height: 18.h,
                                ),

                                ///---- attachment and notes
                                _consultantAppointmentDetailLogic
                                            .selectedAppointmentData
                                            .appointmentStatus ==
                                        2
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ///---Notes
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  // LanguageConstant.city.tr,
                                                  'Note',
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .notesConsultant ==
                                                          null
                                                      ? '...'
                                                      : _consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .notesConsultant!,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                          ///---Attachment
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  // LanguageConstant.country.tr,
                                                  'Attachment',
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    launch(_consultantAppointmentDetailLogic
                                                            .selectedAppointmentData
                                                            .fileConsultant!
                                                            .contains('assets')
                                                        ? '$mediaUrl/${_consultantAppointmentDetailLogic.selectedAppointmentData.fileConsultant}'
                                                        : '${_consultantAppointmentDetailLogic.selectedAppointmentData.fileConsultant}');
                                                  },
                                                  child: Text(
                                                    _consultantAppointmentDetailLogic
                                                                .selectedAppointmentData
                                                                .filetypeConsultant ==
                                                            null
                                                        ? '...'
                                                        : _consultantAppointmentDetailLogic
                                                            .selectedAppointmentData
                                                            .filetypeConsultant!,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: state
                                                        .sectionDataTextStyle!
                                                        .copyWith(
                                                            color:
                                                                customLightThemeColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer()
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///---user-info
                        _consultantAppointmentDetailLogic
                                    .selectedAppointmentData
                                    .mentee!
                                    .mentee!
                                    .identityHidden ==
                                1
                            ? Text(
                                LanguageConstant.userProfileIsHidden.tr,
                                style: TextStyle(
                                    fontFamily: SarabunFontFamily.extraBold,
                                    fontSize: 18.sp,
                                    color: customThemeColor),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageConstant.userInfo.tr,
                                        style: state.sectionHeadingTextStyle,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      ///---name-gender-status.
                                      Row(
                                        children: [
                                          ///---first-name
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant.firstName.tr,
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .mentee!
                                                              .firstName ==
                                                          null
                                                      ? '...'
                                                      : _consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .mentee!
                                                          .firstName!,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                          ///---last-name
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant.lastName.tr,
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .mentee!
                                                              .lastName ==
                                                          null
                                                      ? '...'
                                                      : _consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .mentee!
                                                          .lastName!,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                          ///---gender
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant.gender.tr,
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .mentee!
                                                              .gender ==
                                                          null
                                                      ? '...'
                                                      : '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.gender!}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),

                                      ///---city-cnic
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ///---city
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant.city.tr,
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .mentee!
                                                              .city ==
                                                          null
                                                      ? '...'
                                                      : '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.city!}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                          ///---country
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant.country.tr,
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .mentee!
                                                              .userCountry ==
                                                          null
                                                      ? '...'
                                                      : _consultantAppointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .mentee!
                                                          .userCountry!
                                                          .name!,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20.h,
                        ),

                        _consultantAppointmentDetailLogic
                                        .selectedAppointmentData
                                        .appointmentStatus ==
                                    0 &&
                                _consultantAppointmentDetailLogic
                                        .selectedAppointmentData.isPaid ==
                                    1
                            ? Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 30, 0, 10),
                                child: Row(
                                  children: [
                                    ///---action
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                /// Accept Button
                                                child: InkWell(
                                                  onTap: () {
                                                    ///---make-notification
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateNotificationBody(
                                                            'Your Appointment is Accepted',
                                                            '',
                                                            null,
                                                            'mentee/appointment/log',
                                                            null);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateUserIdForSendNotification(
                                                            _consultantAppointmentDetailLogic
                                                                .selectedAppointmentData
                                                                .menteeId);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateFormLoaderController(
                                                            true);
                                                    Get.find<
                                                            ConsultantAppointmentLogic>()
                                                        .updateGetUserAppointmentLoader(
                                                            true);
                                                    Get.back();
                                                    Get.back();
                                                    postMethod(
                                                        context,
                                                        mentorChangeAppointmentStatusUrl,
                                                        {
                                                          'token': '123',
                                                          'id': _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .id,
                                                          'status': 1
                                                        },
                                                        true,
                                                        mentorAcceptAppointmentRepo);
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                        color: customThemeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 5, 10, 5),
                                                      child: Center(
                                                        child: Text(
                                                          LanguageConstant
                                                              .accept.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .bold,
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    ///---make-notification
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateNotificationBody(
                                                            'Your Appointment is Cancelled',
                                                            '',
                                                            null,
                                                            'mentee/appointment/log',
                                                            null);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateUserIdForSendNotification(
                                                            _consultantAppointmentDetailLogic
                                                                .selectedAppointmentData
                                                                .menteeId);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateFormLoaderController(
                                                            true);
                                                    Get.find<
                                                            ConsultantAppointmentLogic>()
                                                        .updateGetUserAppointmentLoader(
                                                            true);
                                                    Get.back();
                                                    Get.back();
                                                    postMethod(
                                                        context,
                                                        mentorChangeAppointmentStatusUrl,
                                                        {
                                                          'token': '123',
                                                          'id': _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .id,
                                                          'status': 3
                                                        },
                                                        true,
                                                        mentorRejectAppointmentRepo);
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 5, 10, 5),
                                                      child: Center(
                                                        child: Text(
                                                          LanguageConstant
                                                              .reject.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .bold,
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),

                        _consultantAppointmentDetailLogic
                                        .selectedAppointmentData
                                        .appointmentStatus ==
                                    1 &&
                                _consultantAppointmentDetailLogic
                                        .selectedAppointmentData.is_archieve ==
                                    0
                            ? Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 30.h, 0, 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        log('this is ${_consultantAppointmentDetailLogic.selectedAppointmentData.id}');
                                        customDialogForNotes(context);
                                        // ///---make-notification
                                        // Get.find<GeneralController>()
                                        //     .updateNotificationBody(
                                        //         'Your Appointment is Completed',
                                        //         '',
                                        //         null,
                                        //         'mentee/appointment/log',
                                        //         null);
                                        // Get.find<GeneralController>()
                                        //     .updateUserIdForSendNotification(
                                        //         _consultantAppointmentDetailLogic
                                        //             .selectedAppointmentData
                                        //             .menteeId);
                                        // Get.find<GeneralController>()
                                        //     .updateFormLoaderController(true);
                                        // Get.find<ConsultantAppointmentLogic>()
                                        //     .updateGetUserAppointmentLoader(true);
                                        // Get.back();
                                        // Get.back();
                                        // postMethod(
                                        //     context,
                                        //     markAsCompleteAppointmentUrl,
                                        //     {
                                        //       'token': '123',
                                        //       'appointment_id': Get.find<
                                        //               ConsultantAppointmentDetailLogic>()
                                        //           .selectedAppointmentData
                                        //           .id,
                                        //     },
                                        //     true,
                                        //     mentorCompleteAppointmentRepo);
                                        // // postMethod(
                                        // //     context,
                                        // //     mentorChangeAppointmentStatusUrl,
                                        // //     {
                                        // //       'token': '123',
                                        // //       'id':
                                        // //           _consultantAppointmentDetailLogic
                                        // //               .selectedAppointmentData.id,
                                        // //       'status': 2
                                        // //     },
                                        // //     true,
                                        // //     mentorCompleteAppointmentRepo);
                                      },
                                      child: Container(
                                        height: 55.h,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .45,
                                        decoration: BoxDecoration(
                                          color: customThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  LanguageConstant
                                                      .markAsComplete.tr,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          SarabunFontFamily
                                                              .bold,
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
                                      ),
                                    ),
                                    SizedBox(width: 6.w),

                                    /// Archive Button
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Get.find<GeneralController>()
                                              .updateFormLoaderController(true);
                                          Get.find<ConsultantAppointmentLogic>()
                                              .updateGetUserAppointmentLoader(
                                                  true);
                                          Get.back();
                                          Get.back();
                                          postMethod(
                                              context,
                                              mentorArchivedAppointmentUrl,
                                              {
                                                'token': '123',
                                                'appointment_id':
                                                    _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .id,
                                                'mentor_id':
                                                    _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentorId,
                                              },
                                              true,
                                              mentorArchiveAppointmentRepo);
                                        },
                                        child: Container(
                                          height: 55.h,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .45,
                                          decoration: BoxDecoration(
                                            color: customThemeColor,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    //  LanguageConstant.markAsComplete.tr,
                                                    'Mark as Archive',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .bold,
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
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        _consultantAppointmentDetailLogic
                                    .selectedAppointmentData.is_archieve ==
                                1

                            /// Un Archive Button

                            ? InkWell(
                                onTap: () {
                                  Get.find<GeneralController>()
                                      .updateFormLoaderController(true);
                                  Get.find<ConsultantAppointmentLogic>()
                                      .updateGetUserAppointmentLoader(true);
                                  Get.back();
                                  Get.back();
                                  postMethod(
                                      context,
                                      mentorUnArchivedAppointmentUrl,
                                      {
                                        'token': '123',
                                        'appointment_id':
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData.id,
                                        'mentor_id':
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData
                                                .mentorId,
                                      },
                                      true,
                                      mentorUnArchiveAppointmentRepo);
                                },
                                child: Container(
                                  height: 55.h,
                                  width:
                                      MediaQuery.of(context).size.width * .45,
                                  decoration: BoxDecoration(
                                    color: customThemeColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            //  LanguageConstant.markAsComplete.tr,
                                            'Mark as UnArchive',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.bold,
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
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }

  /// Dialog for notes and attachment
  customDialogForNotes(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: GetBuilder<ConsultantAppointmentDetailLogic>(
                  builder: (_consultantAppointmentDetailLogic) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: noteFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 3,
                                blurRadius: 9,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  //  LanguageConstant.withdrawRequest.tr,
                                  'Attachment Request',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 15, 15, 15),
                          child: TextFormField(
                            style: TextStyle(
                                fontFamily: SarabunFontFamily.regular,
                                fontSize: 16.sp,
                                color: Colors.black),
                            controller: noteController,
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  25.w, 15.h, 25.w, 15.h),
                              hintText:
                                  // LanguageConstant.addAmount.tr,
                                  'Note',
                              hintStyle: TextStyle(
                                  fontFamily: SarabunFontFamily.regular,
                                  fontSize: 16.sp,
                                  color: customTextGreyColor),
                              fillColor: customTextFieldColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: customLightThemeColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return LanguageConstant.fieldRequired.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    imagePickerDialog(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: customTextFieldColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.r))),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.w, 10.h, 10.w, 10.h),
                                      child: Center(
                                        child: Text(
                                          'file',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              _consultantAppointmentDetailLogic.fileName == null
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Text(
                                        '${_consultantAppointmentDetailLogic.fileName}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: Colors.black),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /// cancel
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  LanguageConstant.cancel.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: customThemeColor),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),

                              /// submit
                              InkWell(
                                onTap: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if (noteFormKey.currentState!.validate()) {
                                    if (degreeImage != null) {
                                      _consultantAppointmentDetailLogic
                                          .updateFormLoaderController(true);
                                      fileAttachmentRepo(degreeImage);
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                              title: LanguageConstant.sorry.tr,
                                              titleColor:
                                                  customDialogErrorColor,
                                              descriptions:
                                                  // LanguageConstant
                                                  //     .uploadYourDegreePicture.tr,
                                                  'Upload Any Attachment',
                                              text: LanguageConstant.ok.tr,
                                              functionCall: () {
                                                Navigator.pop(context);
                                              },
                                              img:
                                                  'assets/Icons/dialog_error.svg',
                                            );
                                          });
                                    }
                                  }
                                },
                                child: Text(
                                  LanguageConstant.submit.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: customThemeColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          });
        });
  }

  /// Image picker Dialog
  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<ConsultantAppointmentDetailLogic>(
              builder: (_consultantAppointmentDetailLogic) {
            return CupertinoAlertDialog(
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      setState(() {
                        degreeImagesList = [];
                      });
                      degreeImagesList.add(await ImagePickerGC.pickImage(
                          enableCloseButton: true,
                          context: context,
                          source: ImgSource.Camera,
                          barrierDismissible: true,
                          imageQuality: 10,
                          maxWidth: 400,
                          maxHeight: 600));
                      if (degreeImagesList.isNotEmpty) {
                        setState(() {
                          degreeImage = File(degreeImagesList[0].path);
                          _consultantAppointmentDetailLogic.fileName =
                              degreeImage!.path.split('-').last;
                          _consultantAppointmentDetailLogic.update();
                        });
                      }
                    },
                    child: Text(
                      LanguageConstant.camera.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    )),
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      setState(() {
                        degreeImagesList = [];
                      });
                      degreeImagesList.add(await ImagePickerGC.pickImage(
                          enableCloseButton: true,
                          context: context,
                          source: ImgSource.Gallery,
                          barrierDismissible: true,
                          imageQuality: 10,
                          maxWidth: 400,
                          maxHeight: 600));

                      if (degreeImagesList.isNotEmpty) {
                        setState(() {
                          degreeImage = File(degreeImagesList[0].path);
                          _consultantAppointmentDetailLogic.fileName =
                              degreeImage!.path.split('_').last;
                          _consultantAppointmentDetailLogic.update();
                        });
                      }
                    },
                    child: Text(
                      LanguageConstant.gallery.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    )),
              ],
            );
          });
        });
  }

  /// Image sent repo

  fileAttachmentRepo(File? file1) async {
    dio_instance.FormData formData =
        dio_instance.FormData.fromMap(<String, dynamic>{
      'notes': noteController.text,
      'appointmentId': Get.find<ConsultantAppointmentDetailLogic>()
          .selectedAppointmentData
          .id,
      'file': await dio_instance.MultipartFile.fromFile(
        file1!.path,
      )
    });
    dio_instance.Dio dio = dio_instance.Dio();
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
    dio_instance.Response response;
    try {
      log('testing it ${file1.path}');

      response = await dio.post(fileAttachmentUrl, data: formData);

      if (response.statusCode == 200) {
        Get.find<ConsultantAppointmentDetailLogic>().modelFileAttachment =
            ModelFileAttachment.fromJson(response.data);
        if (Get.find<ConsultantAppointmentDetailLogic>()
                .modelFileAttachment
                .status ==
            true) {
          // Get.find<EditConsultantProfileLogic>().updateForDisplayEducationList(
          //     Get.find<EditConsultantProfileLogic>()
          //         .educationInfoPostModel
          //         .data!
          //         .education);
          // Get.snackbar('${LanguageConstant.addedSuccessfully.tr}!', '',
          //     colorText: Colors.black, backgroundColor: Colors.white);

          Get.find<GeneralController>().updateFormLoaderController(false);
          setState(() {
            noteController.clear();
            Get.find<ConsultantAppointmentDetailLogic>().fileName = null;
            degreeImage = null;
            log('testing message.... ${response.data['message']}');
          });
          Get.find<GeneralController>().updateNotificationBody(
              'Your Appointment is Completed',
              '',
              null,
              'mentee/appointment/log',
              null);
          Get.find<GeneralController>().updateUserIdForSendNotification(
              ConsultantAppointmentDetailLogic()
                  .selectedAppointmentData
                  .menteeId);
          Get.find<GeneralController>().updateFormLoaderController(true);
          Get.find<ConsultantAppointmentLogic>()
              .updateGetUserAppointmentLoader(true);
          Get.back();
          Get.back();
          Get.back();
          postMethod(
              context,
              markAsCompleteAppointmentUrl,
              {
                'token': '123',
                'appointment_id': Get.find<ConsultantAppointmentDetailLogic>()
                    .selectedAppointmentData
                    .id,
              },
              true,
              mentorCompleteAppointmentRepo);
        } else {
          Get.find<GeneralController>().updateFormLoaderController(false);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: LanguageConstant.failed.tr,
                  titleColor: customDialogErrorColor,
                  descriptions: LanguageConstant.tryAgain.tr,
                  text: LanguageConstant.ok.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_error.svg',
                );
              });
        }
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: LanguageConstant.failed.tr,
                titleColor: customDialogErrorColor,
                descriptions: LanguageConstant.tryAgain.tr,
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
    } on dio_instance.DioError catch (e) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      log('testing....$e');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: customDialogErrorColor,
              descriptions: LanguageConstant.tryAgain.tr,
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
      log('ResponseError $fileAttachmentUrl-->> $e');
    }
  }
}
