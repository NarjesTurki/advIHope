import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/user/appointment_detail/logic.dart';
import 'package:ista_app/src/modules/user/appointment_detail/widgets/payment_popup.dart';
import 'package:ista_app/src/modules/user/consultant_profile/view.dart';
import 'package:ista_app/src/modules/user/rating/create_rating_repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../controller/general_controller.dart';

class ModalInsideModal extends StatefulWidget {
  const ModalInsideModal({Key? key}) : super(key: key);

  @override
  State<ModalInsideModal> createState() => _ModalInsideModalState();
}

class _ModalInsideModalState extends State<ModalInsideModal> {
  final GlobalKey<FormState> _ratingFormKey = GlobalKey();

  final TextEditingController _commentsController = TextEditingController();

  double? ratingValue = 1;

  @override
  Widget build(BuildContext context) {
    final state = Get.find<AppointmentDetailLogic>().state;
    return GetBuilder<AppointmentDetailLogic>(
        builder: (_appointmentDetailLogic) {
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
                                    _appointmentDetailLogic
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
                                                          _appointmentDetailLogic
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
                                    _appointmentDetailLogic
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
                                                  _appointmentDetailLogic
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
                                            _appointmentDetailLogic
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
                                            _appointmentDetailLogic
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
                                    _appointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                null ||
                                            _appointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                ''
                                        ? const SizedBox()
                                        : Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                launch(_appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .file!
                                                        .contains('assets')
                                                    ? '$mediaUrl/${_appointmentDetailLogic.selectedAppointmentData.file}'
                                                    : '${_appointmentDetailLogic.selectedAppointmentData.file}');
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
                                                    _appointmentDetailLogic
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
                                              '${LanguageConstant.question.tr} ',
                                              style:
                                                  state.sectionLabelTextStyle,
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              _appointmentDetailLogic
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
                                _appointmentDetailLogic.selectedAppointmentData
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
                                                  _appointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .notesConsultant ==
                                                          null
                                                      ? '...'
                                                      : _appointmentDetailLogic
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
                                                    launch(_appointmentDetailLogic
                                                            .selectedAppointmentData
                                                            .fileConsultant!
                                                            .contains('assets')
                                                        ? '$mediaUrl/${_appointmentDetailLogic.selectedAppointmentData.fileConsultant}'
                                                        : '${_appointmentDetailLogic.selectedAppointmentData.fileConsultant}');
                                                  },
                                                  child: Text(
                                                    _appointmentDetailLogic
                                                                .selectedAppointmentData
                                                                .filetypeConsultant ==
                                                            null
                                                        ? '...'
                                                        : _appointmentDetailLogic
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

                        ///---consultant-info
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
                                  LanguageConstant.consultantInfo.tr,
                                  style: state.sectionHeadingTextStyle,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                ///---name-gender-status.
                                Row(
                                  children: [
                                    ///---name
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.name.tr,
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor
                                                        ?.firstName ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.firstName!} '
                                                    '${_appointmentDetailLogic.selectedAppointmentData.mentor!.lastName!}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
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
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor
                                                        ?.gender ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.gender!}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---religion
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.religion.tr,
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor
                                                        ?.religion ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.religion!}',
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

                                ///---phone-city-cnic
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // ///---phone
                                    // Expanded(
                                    //   child: Column(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Text(
                                    //         'Phone',
                                    //         style: state.sectionLabelTextStyle,
                                    //       ),
                                    //       SizedBox(
                                    //         height: 8.h,
                                    //       ),
                                    //       Text(
                                    //         _appointmentDetailLogic
                                    //                     .selectedAppointmentData
                                    //                     .mentor!
                                    //                     .phone ==
                                    //                 null
                                    //             ? '...'
                                    //             : _appointmentDetailLogic
                                    //                 .selectedAppointmentData
                                    //                 .mentor!
                                    //                 .phone!,
                                    //         softWrap: true,
                                    //         overflow: TextOverflow.ellipsis,
                                    //         maxLines: 1,
                                    //         style: state.sectionDataTextStyle,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

                                    ///---reg.date
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.regDate.tr,
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor !=
                                                    null
                                                ? DateFormat('dd/MM/yy').format(
                                                    DateTime.parse(
                                                        '${_appointmentDetailLogic.selectedAppointmentData.mentor?.createdAt}'))
                                                : '',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

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
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor
                                                        ?.city ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.city!}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
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
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor
                                                        ?.userCountry ==
                                                    null
                                                ? '...'
                                                : _appointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .mentor!
                                                    .userCountry!
                                                    .name!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ///---cnic
                                    // Expanded(
                                    //   child: Column(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Text(
                                    //         'CNIC',
                                    //         style: state.sectionLabelTextStyle,
                                    //       ),
                                    //       SizedBox(
                                    //         height: 8.h,
                                    //       ),
                                    //       Text(
                                    //         _appointmentDetailLogic
                                    //                     .selectedAppointmentData
                                    //                     .mentor!
                                    //                     .cnic ==
                                    //                 null
                                    //             ? '...'
                                    //             : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.cnic!}',
                                    //         softWrap: true,
                                    //         overflow: TextOverflow.ellipsis,
                                    //         maxLines: 1,
                                    //         style: state.sectionDataTextStyle,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),

                                ///---reg.date-address
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///---address
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.address.tr,
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor
                                                        ?.address ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.address!}',
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        /// Reschedule Button

                        _appointmentDetailLogic.selectedAppointmentData
                                        .appointmentStatus ==
                                    1 &&
                                _appointmentDetailLogic
                                        .selectedAppointmentData.isPaid ==
                                    1 &&
                                _appointmentDetailLogic
                                        .selectedAppointmentData.reschudlable ==
                                    true
                            ? Center(
                                child: InkWell(
                                  onTap: () {
                                    log('${_appointmentDetailLogic.selectedAppointmentData.mentor!.id}');
                                    // paymentBottomSheetForLater(context);
                                    Get.to(ConsultantProfilePage(
                                        appointmentId: _appointmentDetailLogic
                                            .selectedAppointmentData.id,
                                        mentorId: _appointmentDetailLogic
                                            .selectedAppointmentData.mentor!.id,
                                        reschedule: true));
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        40.w, 0, 40.w, 0),
                                    child: Container(
                                      height: 55.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: customRedColor),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                //  LanguageConstant.payNow.tr,
                                                'Re Schedule',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.bold,
                                                    fontSize: 16.sp,
                                                    color: customRedColor),
                                              ),
                                              SvgPicture.asset(
                                                'assets/Icons/forwardArrowRedIcon.svg',
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
                              )
                            : const SizedBox(),

                        /// pay-now
                        _appointmentDetailLogic
                                    .selectedAppointmentData.isPaid ==
                                1
                            ? const SizedBox()
                            : Center(
                                child: InkWell(
                                  onTap: () {
                                    paymentBottomSheetForLater(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        40.w, 0, 40.w, 0),
                                    child: Container(
                                      height: 55.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: customRedColor),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                LanguageConstant.payNow.tr,
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.bold,
                                                    fontSize: 16.sp,
                                                    color: customRedColor),
                                              ),
                                              SvgPicture.asset(
                                                'assets/Icons/forwardArrowRedIcon.svg',
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
                              ),

                        /// rating button
                        !_appointmentDetailLogic.isRated! &&
                                _appointmentDetailLogic.selectedAppointmentData
                                        .appointmentStatus ==
                                    2
                            ? Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Form(
                                        key: _ratingFormKey,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 30),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: LanguageConstant
                                                          .rate.tr,
                                                      style: TextStyle(
                                                          fontSize: 22.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              customThemeColor)),
                                                  TextSpan(
                                                      text:
                                                          ' ${LanguageConstant.user.tr}',
                                                      style: TextStyle(
                                                          fontSize: 22.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: const Color(
                                                              0xff1B1B1C))),
                                                ])),
                                                const SizedBox(
                                                  height: 22,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: ratingValue!,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    setState(() {
                                                      ratingValue = rating;
                                                    });
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return LanguageConstant
                                                          .fieldRequired.tr.tr;
                                                    }
                                                    return null;
                                                  },
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                  controller:
                                                      _commentsController,
                                                  decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 20),
                                                      fillColor: Colors.grey
                                                          .withOpacity(0.1),
                                                      filled: true,
                                                      hintText: LanguageConstant
                                                          .comments.tr,
                                                      // hintStyle:
                                                      // state.hintTextStyle,
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius: BorderRadius.circular(
                                                              5)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius: BorderRadius.circular(
                                                              5)),
                                                      border: OutlineInputBorder(
                                                          borderSide: const BorderSide(color: Colors.white),
                                                          borderRadius: BorderRadius.circular(5))),
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (_ratingFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          Get.back();
                                                          Get.find<
                                                                  GeneralController>()
                                                              .updateFormLoaderController(
                                                                  true);
                                                          postMethod(
                                                              context,
                                                              createRatingUrl,
                                                              {
                                                                'token': '123',
                                                                'mentee_id':
                                                                    _appointmentDetailLogic
                                                                        .selectedAppointmentData
                                                                        .menteeId,
                                                                'mentor_id':
                                                                    _appointmentDetailLogic
                                                                        .selectedAppointmentData
                                                                        .mentorId,
                                                                'comments':
                                                                    _commentsController
                                                                        .text,
                                                                'rating':
                                                                    ratingValue,
                                                                'appointment_id':
                                                                    _appointmentDetailLogic
                                                                        .selectedAppointmentData
                                                                        .id
                                                              },
                                                              true,
                                                              createRatingRepo);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 47,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .5,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                customThemeColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                          child: Text(
                                                            LanguageConstant
                                                                .submit.tr,
                                                            style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 55.h,
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    decoration: BoxDecoration(
                                      color: customThemeColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LanguageConstant.rateNow.tr,
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
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 15.h,
                        ),

                        ///---invoice
                        _appointmentDetailLogic.selectedAppointmentData
                                    .appointmentStatus! ==
                                2
                            ? Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    launch(
                                        '$downloadAppointmentInvoiceForMenteeUrl/'
                                        '${_appointmentDetailLogic.selectedAppointmentData.id}');
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          40.w, 0, 40.w, 0),
                                      child: Container(
                                        height: 55.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: customRedColor),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  LanguageConstant
                                                      .downloadInvoice.tr,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          SarabunFontFamily
                                                              .bold,
                                                      fontSize: 16.sp,
                                                      color: customRedColor),
                                                ),
                                                SvgPicture.asset(
                                                  'assets/Icons/forwardArrowRedIcon.svg',
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
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 10.h,
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
}
