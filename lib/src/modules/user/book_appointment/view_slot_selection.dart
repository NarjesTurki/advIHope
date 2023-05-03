import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/logic.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/modules/sms/repo.dart';
import 'package:ista_app/src/modules/user/book_appointment/get_repo.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/book_appointment/view_appointment_question.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SlotSelection extends StatefulWidget {
  int? appointmentId;
  int? mentorId;
  bool? reschedule;
  SlotSelection({Key? key, this.appointmentId, this.mentorId, this.reschedule})
      : super(key: key);

  @override
  State<SlotSelection> createState() => _SlotSelectionState();
}

class _SlotSelectionState extends State<SlotSelection> {
  final logic = Get.put(BookAppointmentLogic());

  final state = Get.find<BookAppointmentLogic>().state;

  bool? live = false;
  bool? chat = false;

  @override
  void initState() {
    super.initState();

    Get.find<BookAppointmentLogic>().scrollController = ScrollController()
      ..addListener(Get.find<BookAppointmentLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<BookAppointmentLogic>()
        .scrollController!
        .removeListener(Get.find<BookAppointmentLogic>().scrollListener);
    Get.find<BookAppointmentLogic>().scrollController!.dispose();
    super.dispose();
  }

  bool? disableButton = true;
  int? selectedSlotID;
  int? selectedSlotIndex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                controller: _bookAppointmentLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: LanguageConstant.bookAppointment.tr,
                      subHeading: LanguageConstant.byJustFewEasySteps.tr,
                      trailing: LanguageConstant.step1Of3.tr,
                      isShrink: _bookAppointmentLogic.isShrink,
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    ListView(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0),
                        children: [
                          ///---type-heading
                          Text(
                            LanguageConstant.selectOptions.tr,
                            style: state.headingTextStyle,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),

                          ///---types
                          Wrap(
                            children: List.generate(
                                _bookAppointmentLogic.consultantProfileLogic
                                    .appointmentTypes.length, (index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 18.w, 11.h),
                                child: InkWell(
                                  onTap: () {
                                    if (_bookAppointmentLogic
                                            .consultantProfileLogic
                                            .appointmentTypes[index]
                                            .appointmentTypeId ==
                                        6) {
                                      setState(() {
                                        live = true;
                                      });
                                    } else {
                                      setState(() {
                                        live = false;
                                      });
                                    }

                                    /// for chat
                                    if (_bookAppointmentLogic
                                            .consultantProfileLogic
                                            .appointmentTypes[index]
                                            .appointmentTypeId ==
                                        3) {
                                      setState(() {
                                        chat = true;
                                      });
                                    } else {
                                      setState(() {
                                        chat = false;
                                      });
                                    }
                                    if (_bookAppointmentLogic
                                            .consultantProfileLogic
                                            .appointmentTypes[index]
                                            .appointmentType!
                                            .isScheduleRequired ==
                                        1) {
                                      setState(() {
                                        disableButton = true;
                                      });
                                      _bookAppointmentLogic.morningSlots
                                          .clear();
                                      _bookAppointmentLogic.afterNoonSlots
                                          .clear();
                                      _bookAppointmentLogic.eveningSlots
                                          .clear();
                                      _bookAppointmentLogic
                                              .selectedAppointmentTypeID =
                                          _bookAppointmentLogic
                                              .consultantProfileLogic
                                              .appointmentTypes[index]
                                              .appointmentTypeId;
                                      _bookAppointmentLogic
                                          .selectedAppointmentTypeIndex = index;
                                      _bookAppointmentLogic
                                          .updateSelectMentorAppointmentType(
                                              _bookAppointmentLogic
                                                  .consultantProfileLogic
                                                  .appointmentTypes[index]);
                                      _bookAppointmentLogic.update();
                                      _bookAppointmentLogic
                                          .updateCalenderLoader(true);
                                      widget.mentorId != null
                                          ? getMethod(
                                              context,
                                              getScheduleAvailableDaysURL,
                                              {
                                                'token': '123',
                                                'mentor_id': widget.mentorId,
                                                'appointment_type_id':
                                                    _bookAppointmentLogic
                                                        .consultantProfileLogic
                                                        .appointmentTypes[index]
                                                        .appointmentTypeId,
                                              },
                                              true,
                                              getScheduleAvailableDaysRepo)
                                          : getMethod(
                                              context,
                                              getScheduleAvailableDaysURL,
                                              {
                                                'token': '123',
                                                'mentor_id':
                                                    Get.find<UserHomeLogic>()
                                                        .selectedConsultantID,
                                                'appointment_type_id':
                                                    _bookAppointmentLogic
                                                        .consultantProfileLogic
                                                        .appointmentTypes[index]
                                                        .appointmentTypeId,
                                              },
                                              true,
                                              getScheduleAvailableDaysRepo);
                                    } else {
                                      setState(() {
                                        disableButton = false;
                                      });
                                      _bookAppointmentLogic.morningSlots
                                          .clear();
                                      _bookAppointmentLogic.afterNoonSlots
                                          .clear();
                                      _bookAppointmentLogic.eveningSlots
                                          .clear();
                                      _bookAppointmentLogic
                                              .selectedAppointmentTypeID =
                                          _bookAppointmentLogic
                                              .consultantProfileLogic
                                              .appointmentTypes[index]
                                              .appointmentTypeId;
                                      _bookAppointmentLogic
                                          .selectedAppointmentTypeIndex = index;
                                      _bookAppointmentLogic
                                          .updateSelectMentorAppointmentType(
                                              _bookAppointmentLogic
                                                  .consultantProfileLogic
                                                  .appointmentTypes[index]);
                                      _bookAppointmentLogic.update();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: _bookAppointmentLogic
                                                    .selectedAppointmentTypeID ==
                                                _bookAppointmentLogic
                                                    .consultantProfileLogic
                                                    .appointmentTypes[index]
                                                    .appointmentTypeId
                                            ? customLightThemeColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _bookAppointmentLogic
                                                        .selectedAppointmentTypeID ==
                                                    _bookAppointmentLogic
                                                        .consultantProfileLogic
                                                        .appointmentTypes[index]
                                                        .appointmentTypeId
                                                ? customLightThemeColor
                                                    .withOpacity(0.6)
                                                : Colors.grey.withOpacity(0.2),
                                            spreadRadius: -2,
                                            blurRadius: 15,
                                            // offset: Offset(1,5)
                                          )
                                        ]),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 13.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[index].appointmentTypeId! - 1]}',
                                                height: 12.h,
                                                width: 19.w,
                                                color: _bookAppointmentLogic
                                                            .selectedAppointmentTypeID ==
                                                        _bookAppointmentLogic
                                                            .consultantProfileLogic
                                                            .appointmentTypes[
                                                                index]
                                                            .appointmentTypeId
                                                    ? Colors.white
                                                    : customThemeColor,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                _bookAppointmentLogic
                                                    .consultantProfileLogic
                                                    .appointmentTypes[index]
                                                    .appointmentType!
                                                    .name!
                                                    .toString()
                                                    .capitalizeFirst!,
                                                style: _bookAppointmentLogic
                                                            .selectedAppointmentTypeID ==
                                                        _bookAppointmentLogic
                                                            .consultantProfileLogic
                                                            .appointmentTypes[
                                                                index]
                                                            .appointmentTypeId
                                                    ? state.typeTextStyle!
                                                        .copyWith(
                                                            color: Colors.white)
                                                    : state.typeTextStyle,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 28.w),
                                            child: Text(
                                              '${Get.find<GeneralController>().storageBox.read('currency')}${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[index].fee}',
                                              style: _bookAppointmentLogic
                                                          .selectedAppointmentTypeID ==
                                                      _bookAppointmentLogic
                                                          .consultantProfileLogic
                                                          .appointmentTypes[
                                                              index]
                                                          .appointmentTypeId
                                                  ? state.typePriceTextStyle!
                                                      .copyWith(
                                                          color: Colors.white)
                                                  : state.typePriceTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          /// to hide calendar
                          live == false
                              ?

                              ///---calender
                              _bookAppointmentLogic.calenderLoader!
                                  ? SkeletonLoader(
                                      period: const Duration(seconds: 2),
                                      highlightColor: Colors.grey,
                                      direction: SkeletonDirection.ltr,
                                      builder: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                      ))
                                  : _bookAppointmentLogic
                                              .getScheduleAvailableDays.data ==
                                          null
                                      ? const SizedBox()
                                      : Container(
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: -2,
                                                  blurRadius: 15,
                                                  // offset: Offset(1,5)
                                                )
                                              ]),
                                          child: _getCustomizedDatePicker(
                                              _bookAppointmentLogic
                                                  .availableScheduleDaysList!),
                                        )
                              : const SizedBox(),

                          SizedBox(
                            height: 30.h,
                          ),

                          ///---shift-heading

                          _bookAppointmentLogic.morningSlots.isEmpty &&
                                  _bookAppointmentLogic
                                      .afterNoonSlots.isEmpty &&
                                  _bookAppointmentLogic.eveningSlots.isEmpty &&
                                  !_bookAppointmentLogic
                                      .getScheduleSlotsForMenteeLoader
                              ? const SizedBox()
                              : _bookAppointmentLogic
                                      .getScheduleSlotsForMenteeLoader
                                  ? SkeletonLoader(
                                      period: const Duration(seconds: 2),
                                      highlightColor: Colors.grey,
                                      direction: SkeletonDirection.ltr,
                                      builder: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 15.h,
                                            width: 80.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: List.generate(3, (index) {
                                              return Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0, 0, 11.w, 0.h),
                                                  child: Container(
                                                    height: 78.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Wrap(
                                            children: List.generate(6, (index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 10, 6),
                                                child: Container(
                                                  height: 30,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant.selectShift.tr,
                                          style: state.headingTextStyle,
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),

                                        ///---shift
                                        Row(
                                          children: List.generate(
                                              _bookAppointmentLogic
                                                  .shiftList.length, (index) {
                                            return Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 11.w, 0.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    for (var element
                                                        in _bookAppointmentLogic
                                                            .shiftList) {
                                                      element.isSelected =
                                                          false;
                                                    }
                                                    _bookAppointmentLogic
                                                        .shiftList[index]
                                                        .isSelected = true;
                                                    _bookAppointmentLogic
                                                        .updateAppointmentShiftType(
                                                            index);
                                                    _bookAppointmentLogic
                                                        .update();
                                                  },
                                                  child: Container(
                                                    height: 78.h,
                                                    decoration: BoxDecoration(
                                                        color: _bookAppointmentLogic
                                                                    .appointmentShiftType ==
                                                                index
                                                            ? customLightThemeColor
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: _bookAppointmentLogic
                                                                        .appointmentShiftType ==
                                                                    index
                                                                ? customLightThemeColor
                                                                    .withOpacity(
                                                                        0.5)
                                                                : Colors.grey
                                                                    .withOpacity(
                                                                        0.2),
                                                            spreadRadius: -2,
                                                            blurRadius: 15,
                                                            // offset: Offset(1,5)
                                                          )
                                                        ]),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 14.w,
                                                              vertical: 13.h),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            _bookAppointmentLogic
                                                                        .appointmentShiftType ==
                                                                    index
                                                                ? SvgPicture
                                                                    .asset(
                                                                    '${_bookAppointmentLogic.shiftList[index].image}',
                                                                    color: Colors
                                                                        .white,
                                                                    height:
                                                                        20.h,
                                                                    width: 20.w,
                                                                  )
                                                                : SvgPicture
                                                                    .asset(
                                                                    '${_bookAppointmentLogic.shiftList[index].image}',
                                                                    height:
                                                                        20.h,
                                                                    width: 20.w,
                                                                  ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Text(
                                                              '${_bookAppointmentLogic.shiftList[index].title}',
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: _bookAppointmentLogic
                                                                          .appointmentShiftType ==
                                                                      index
                                                                  ? state
                                                                      .typeTextStyle!
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .white)
                                                                  : state
                                                                      .typeTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),

                                        SizedBox(
                                          height: 25.h,
                                        ),

                                        ///---morning-slots
                                        _bookAppointmentLogic
                                                    .appointmentShiftType ==
                                                0
                                            ? _bookAppointmentLogic
                                                    .morningSlots.isEmpty
                                                ? Text(
                                                    LanguageConstant
                                                        .noSlotsAvailable.tr,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .regular,
                                                        fontSize: 16.sp,
                                                        color:
                                                            customTextBlackColor),
                                                  )
                                                : Wrap(
                                                    children: List.generate(
                                                        _bookAppointmentLogic
                                                            .morningSlots
                                                            .length,
                                                        (secondIndex) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 6.w, 6.h),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (_bookAppointmentLogic
                                                                    .morningSlots[
                                                                        secondIndex]
                                                                    .isBooked ==
                                                                1) {
                                                              return;
                                                            }
                                                            setState(() {
                                                              selectedSlotID =
                                                                  _bookAppointmentLogic
                                                                      .morningSlots[
                                                                          secondIndex]
                                                                      .id!;
                                                              _bookAppointmentLogic
                                                                      .selectedTimeForAppointment =
                                                                  _bookAppointmentLogic
                                                                      .morningSlots[
                                                                          secondIndex]
                                                                      .startTime!;
                                                              _bookAppointmentLogic
                                                                      .selectedEndTimeForAppointment =
                                                                  _bookAppointmentLogic
                                                                      .morningSlots[
                                                                          secondIndex]
                                                                      .endTime!;
                                                              disableButton =
                                                                  false;
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: _bookAppointmentLogic.morningSlots[secondIndex].isBooked ==
                                                                            1
                                                                        ? Colors
                                                                            .redAccent
                                                                        : _bookAppointmentLogic.morningSlots[secondIndex].id ==
                                                                                selectedSlotID
                                                                            ? customThemeColor
                                                                            : Colors
                                                                                .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100)),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          11.w,
                                                                          4.h,
                                                                          11.w,
                                                                          4.h),
                                                              child: Text(
                                                                '${_bookAppointmentLogic.morningSlots[secondIndex].startTime}',
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                style: state.shiftTitleTextStyle!.copyWith(
                                                                    color: _bookAppointmentLogic.morningSlots[secondIndex].id ==
                                                                                selectedSlotID ||
                                                                            _bookAppointmentLogic.morningSlots[secondIndex].isBooked ==
                                                                                1
                                                                        ? Colors
                                                                            .white
                                                                        : null),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )
                                            : const SizedBox(),

                                        ///---afternoon-slots
                                        _bookAppointmentLogic
                                                    .appointmentShiftType ==
                                                1
                                            ? _bookAppointmentLogic
                                                    .afterNoonSlots.isEmpty
                                                ? Text(
                                                    LanguageConstant
                                                        .noSlotsAvailable.tr,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .regular,
                                                        fontSize: 16.sp,
                                                        color:
                                                            customTextBlackColor),
                                                  )
                                                : Wrap(
                                                    children: List.generate(
                                                        _bookAppointmentLogic
                                                            .afterNoonSlots
                                                            .length,
                                                        (secondIndex) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 6.w, 6.h),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (_bookAppointmentLogic
                                                                    .afterNoonSlots[
                                                                        secondIndex]
                                                                    .isBooked ==
                                                                1) {
                                                              return;
                                                            }
                                                            setState(() {
                                                              selectedSlotID =
                                                                  _bookAppointmentLogic
                                                                      .afterNoonSlots[
                                                                          secondIndex]
                                                                      .id!;
                                                              _bookAppointmentLogic
                                                                      .selectedTimeForAppointment =
                                                                  _bookAppointmentLogic
                                                                      .afterNoonSlots[
                                                                          secondIndex]
                                                                      .startTime!;
                                                              _bookAppointmentLogic
                                                                      .selectedEndTimeForAppointment =
                                                                  _bookAppointmentLogic
                                                                      .afterNoonSlots[
                                                                          secondIndex]
                                                                      .endTime!;
                                                              disableButton =
                                                                  false;
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: _bookAppointmentLogic.afterNoonSlots[secondIndex].isBooked ==
                                                                            1
                                                                        ? Colors
                                                                            .redAccent
                                                                        : _bookAppointmentLogic.afterNoonSlots[secondIndex].id ==
                                                                                selectedSlotID
                                                                            ? customThemeColor
                                                                            : Colors
                                                                                .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100)),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          11.w,
                                                                          4.h,
                                                                          11.w,
                                                                          4.h),
                                                              child: Text(
                                                                '${_bookAppointmentLogic.afterNoonSlots[secondIndex].startTime}',
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                style: state.shiftTitleTextStyle!.copyWith(
                                                                    color: _bookAppointmentLogic.afterNoonSlots[secondIndex].id ==
                                                                                selectedSlotID ||
                                                                            _bookAppointmentLogic.afterNoonSlots[secondIndex].isBooked ==
                                                                                1
                                                                        ? Colors
                                                                            .white
                                                                        : null),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )
                                            : const SizedBox(),

                                        ///---evening-slots
                                        _bookAppointmentLogic
                                                    .appointmentShiftType ==
                                                2
                                            ? _bookAppointmentLogic
                                                    .eveningSlots.isEmpty
                                                ? Text(
                                                    LanguageConstant
                                                        .noSlotsAvailable.tr,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .regular,
                                                        fontSize: 16.sp,
                                                        color:
                                                            customTextBlackColor),
                                                  )
                                                : Wrap(
                                                    children: List.generate(
                                                        _bookAppointmentLogic
                                                            .eveningSlots
                                                            .length,
                                                        (secondIndex) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 6.w, 6.h),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (_bookAppointmentLogic
                                                                    .eveningSlots[
                                                                        secondIndex]
                                                                    .isBooked ==
                                                                1) {
                                                              return;
                                                            }
                                                            setState(() {
                                                              selectedSlotID =
                                                                  _bookAppointmentLogic
                                                                      .eveningSlots[
                                                                          secondIndex]
                                                                      .id!;
                                                              _bookAppointmentLogic
                                                                      .selectedTimeForAppointment =
                                                                  _bookAppointmentLogic
                                                                      .eveningSlots[
                                                                          secondIndex]
                                                                      .startTime!;
                                                              _bookAppointmentLogic
                                                                      .selectedEndTimeForAppointment =
                                                                  _bookAppointmentLogic
                                                                      .eveningSlots[
                                                                          secondIndex]
                                                                      .endTime!;
                                                              disableButton =
                                                                  false;
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: _bookAppointmentLogic.eveningSlots[secondIndex].isBooked ==
                                                                            1
                                                                        ? Colors
                                                                            .redAccent
                                                                        : _bookAppointmentLogic.eveningSlots[secondIndex].id ==
                                                                                selectedSlotID
                                                                            ? customThemeColor
                                                                            : Colors
                                                                                .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100)),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          11.w,
                                                                          4.h,
                                                                          11.w,
                                                                          4.h),
                                                              child: Text(
                                                                '${_bookAppointmentLogic.eveningSlots[secondIndex].startTime}',
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                style: state.shiftTitleTextStyle!.copyWith(
                                                                    color: _bookAppointmentLogic.eveningSlots[secondIndex].id ==
                                                                                selectedSlotID ||
                                                                            _bookAppointmentLogic.eveningSlots[secondIndex].isBooked ==
                                                                                1
                                                                        ? Colors
                                                                            .white
                                                                        : null),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )
                                            : const SizedBox(),
                                        // Wrap(
                                        //   children: List.generate(15, (secondIndex) {
                                        //     return Padding(
                                        //       padding: EdgeInsets.fromLTRB(0, 0, 12.w, 6),
                                        //       child: InkWell(
                                        //         onTap: () {
                                        //           setState(() {
                                        //             selectedSlotIndex = secondIndex;
                                        //           });
                                        //           setState(() {
                                        //             disableButton = false;
                                        //           });
                                        //         },
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //               color: selectedSlotIndex == secondIndex
                                        //                   ? customLightThemeColor
                                        //                   : Colors.white,
                                        //               borderRadius:
                                        //               BorderRadius.circular(100)),
                                        //           child: Padding(
                                        //             padding: EdgeInsets.fromLTRB(
                                        //                 11.w, 4.h, 11.w, 4.h),
                                        //             child: Text(
                                        //               '07:50 pm',
                                        //               textDirection: TextDirection.ltr,
                                        //               style: selectedSlotIndex == secondIndex
                                        //                   ? state.shiftTitleTextStyle!
                                        //                   .copyWith(color: Colors.white)
                                        //                   : state.shiftTitleTextStyle,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                        //   }),
                                        // ),
                                      ],
                                    ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                          ),
                        ]),

                    /// bottom bar
                    widget.reschedule == true
                        ? Positioned(
                            bottom: 0.h,
                            left: 15.w,
                            right: 15.w,
                            child: InkWell(
                              onTap: () {
                                print("object 1");
                                print("object 1 ${widget.appointmentId}");
                                // return;
                                if (!disableButton!) {
                                  Get.to(AppointmentQuestionPage(
                                      appointmentId: widget.appointmentId,
                                      mentorId: widget.mentorId,
                                      showPaymentSection: true));
                                }
                              },
                              child: MyCustomBottomBar(
                                title: 'Update',
                                //LanguageConstant.continueText.tr,
                                disable: disableButton!,
                              ),
                            ),
                          )
                        : live == true
                            ? Positioned(
                                bottom: 0.h,
                                left: 15.w,
                                right: 15.w,
                                child: InkWell(
                                  onTap: () {
                                    print("object 2");
                                    // return;
                                    log('testing notification sent');
                                    Get.back();
                                    Get.find<GeneralController>()
                                        .channelForCall = null;
                                    Get.find<GeneralController>().update();

                                    ///---make-notification
                                    Get.find<GeneralController>()
                                        .updateNotificationBody(
                                            'New Appointment Are You Live!',
                                            '',
                                            '/requestForLive',
                                            'mentee/appointment/log',
                                            null);
                                    Get.find<GeneralController>()
                                        .updateUserIdForSendNotification(
                                            ConsultantAppointmentDetailLogic()
                                                .selectedAppointmentData
                                                .mentorId);

                                    ///----send-sms
                                    postMethod(
                                        context,
                                        sendSMSUrl,
                                        {
                                          'token': '123',
                                          'phone':
                                              Get.find<SmsLogic>().phoneNumber,
                                          'message':
                                              Get.find<GeneralController>()
                                                  .notificationTitle,
                                        },
                                        true,
                                        sendSMSRepo);

                                    ///----fcm-send-start
                                    getMethod(
                                        context,
                                        fcmGetUrl,
                                        {
                                          'token': '123',
                                          'user_id': Get.find<UserHomeLogic>()
                                              .selectedConsultantID
                                        },
                                        true,
                                        getFcmTokenRepo);
                                    Get.snackbar('your Request is Pending!', '',
                                        colorText: Colors.black,
                                        backgroundColor: Colors.white);
                                  },
                                  child: MyCustomBottomBar(
                                    title: 'continue',
                                    // LanguageConstant.continueText.tr,
                                    disable: disableButton!,
                                  ),
                                ),
                              )

                            ///---bottom-bar
                            : Positioned(
                                bottom: 0.h,
                                left: 15.w,
                                right: 15.w,
                                child: InkWell(
                                  onTap: () {
                                    print("object 3");
                                    print("object  ${widget.appointmentId}");
                                    // return;
                                    if (!disableButton!) {
                                      Get.to(AppointmentQuestionPage(
                                          appointmentId: widget.appointmentId,
                                          mentorId: 0,
                                          showPaymentSection: false));
                                    }
                                  },
                                  child: MyCustomBottomBar(
                                    title: LanguageConstant.continueText.tr,
                                    disable: disableButton!,
                                  ),
                                ),
                              )
                  ],
                )),
          ),
        );
      });
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        Get.find<BookAppointmentLogic>().selectedDateForAppointment =
            args.value.toString();
        setState(() {
          selectedSlotID = null;
        });
        Get.find<BookAppointmentLogic>()
            .updateGetScheduleSlotsForMenteeLoader(true);
        Get.find<BookAppointmentLogic>().emptyMorningSlots();
        Get.find<BookAppointmentLogic>().emptyAfterNoonSlots();
        Get.find<BookAppointmentLogic>().emptyEveningSlots();
        widget.mentorId != null
            ? getMethod(
                context,
                getScheduleSlotsForMenteeUrl,
                {
                  'token': '123',
                  'mentor_id': widget.mentorId,
                  'date': Get.find<BookAppointmentLogic>()
                      .selectedDateForAppointment
                      .substring(0, 11),
                  'appointment_type_id':
                      Get.find<BookAppointmentLogic>().selectedAppointmentTypeID
                },
                true,
                getScheduleSlotsRepo)
            : getMethod(
                context,
                getScheduleSlotsForMenteeUrl,
                {
                  'token': '123',
                  'mentor_id': Get.find<UserHomeLogic>().selectedConsultantID,
                  'date': Get.find<BookAppointmentLogic>()
                      .selectedDateForAppointment
                      .substring(0, 11),
                  'appointment_type_id':
                      Get.find<BookAppointmentLogic>().selectedAppointmentTypeID
                },
                true,
                getScheduleSlotsRepo);
        Get.find<BookAppointmentLogic>().update();
      }
    });
  }

  SfDateRangePicker _getCustomizedDatePicker(List<DateTime> specialDates) {
    return SfDateRangePicker(
      selectionShape: DateRangePickerSelectionShape.rectangle,
      selectionColor: customThemeColor,
      selectionTextStyle: TextStyle(
          fontFamily: SarabunFontFamily.regular,
          fontSize: 14.sp,
          color: Colors.white),
      onSelectionChanged: _onSelectionChanged,
      enablePastDates: false,
      showNavigationArrow: true,
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 90)),
      backgroundColor: Colors.white,
      headerStyle: DateRangePickerHeaderStyle(
        textStyle: TextStyle(
            fontFamily: SarabunFontFamily.extraBold,
            fontSize: 18.sp,
            color: customTextBlackColor),
      ),
      monthCellStyle: DateRangePickerMonthCellStyle(
        specialDatesDecoration: const MonthCellDecoration(
            borderColor: null,
            backgroundColor: customLightThemeColor,
            showIndicator: true,
            indicatorColor: customThemeColor),
        // textStyle: TextStyle(color: const Color(0xffe2d7fe), fontSize: 14),
        specialDatesTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: SarabunFontFamily.regular),
        // todayTextStyle: TextStyle(color: highlightColor, fontSize: 14)
      ),
      // yearCellStyle: DateRangePickerYearCellStyle(
      //   todayTextStyle: TextStyle(color: highlightColor, fontSize: 14),
      //   textStyle: TextStyle(color: cellTextColor, fontSize: 14),
      //   disabledDatesTextStyle: TextStyle(color: const Color(0xffe2d7fe)),
      //   leadingDatesTextStyle:
      //       TextStyle(color: cellTextColor.withOpacity(0.5), fontSize: 14),
      // ),
      todayHighlightColor: customLightThemeColor,
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: TextStyle(
                fontFamily: SarabunFontFamily.medium,
                fontSize: 16.sp,
                color: customTextBlackColor)),
        // dayFormat: 'EEE',
        showTrailingAndLeadingDates: false,
        specialDates: specialDates,
      ),
    );
  }
}

class MonthCellDecoration extends Decoration {
  const MonthCellDecoration(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MonthCellDecorationPainter(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        showIndicator: showIndicator,
        indicatorColor: indicatorColor);
  }
}

class _MonthCellDecorationPainter extends BoxPainter {
  _MonthCellDecorationPainter(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    _drawDecoration(canvas, bounds);
  }

  void _drawDecoration(Canvas canvas, Rect bounds) {
    final Paint paint = Paint()..color = backgroundColor!;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bounds, const Radius.circular(10)), paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    if (borderColor != null) {
      paint.color = borderColor!;
      canvas.drawRRect(
          RRect.fromRectAndRadius(bounds, const Radius.circular(10)), paint);
    }
    if (showIndicator) {
      paint.color = indicatorColor!;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bounds.right - 6, bounds.top + 6), 2.5, paint);
    }
  }
}
