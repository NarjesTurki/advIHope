import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/schedule/logic.dart';
import 'package:ista_app/src/modules/consultant/schedule/repo_delete.dart';
import 'package:ista_app/src/modules/consultant/schedule/repo_get.dart';
import 'package:ista_app/src/modules/consultant/schedule/repo_post.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart' as intl;
import 'package:resize/resize.dart';

import '../../../api_services/urls.dart';

class ScheduleCreatePage extends StatefulWidget {
  const ScheduleCreatePage({Key? key}) : super(key: key);

  @override
  _ScheduleCreatePageState createState() => _ScheduleCreatePageState();
}

class _ScheduleCreatePageState extends State<ScheduleCreatePage> {
  final logic = Get.put(MentorScheduleLogic());
  final state = Get.find<MentorScheduleLogic>().state;

  final GlobalKey<FormState> _scheduleInfoFormKey = GlobalKey();

  final timeFormat = intl.DateFormat.jm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<MentorScheduleLogic>().scrollController = ScrollController()
      ..addListener(Get.find<MentorScheduleLogic>().scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoaderController(true);
    });
    getMethod(context, getAppointmentTypeUrl, {'token': '123'}, false,
        getAppointmentTypesRepo);

    getMethod(
        context,
        getMentorSchedulesUrl,
        {
          'token': '123',
          'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
        },
        false,
        getMentorScheduleRepo);
  }

  bool timeValidator = false;

  @override
  void dispose() {
    Get.find<MentorScheduleLogic>()
        .scrollController!
        .removeListener(Get.find<MentorScheduleLogic>().scrollListener);
    Get.find<MentorScheduleLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (_generalController) => GetBuilder<MentorScheduleLogic>(
        builder: (_mentorScheduleLogic) => ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          inAsyncCall: _generalController.formLoaderController,
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: customThemeColor,
              body: NestedScrollView(
                  controller: _mentorScheduleLogic.scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      SliverAppBar(
                        expandedHeight:
                            MediaQuery.of(context).size.height * .27,
                        floating: true,
                        pinned: true,
                        snap: false,
                        elevation: 0,
                        backgroundColor: _mentorScheduleLogic.isShrink
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
                              SvgPicture.asset(
                                  'assets/Icons/whiteBackArrow.svg'),
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
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .3,
                                      fit: BoxFit.cover,
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
                                                  LanguageConstant
                                                      .mySchedule.tr,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          SarabunFontFamily
                                                              .bold,
                                                      fontSize: 28.sp,
                                                      color:
                                                          customLightThemeColor),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  LanguageConstant
                                                      .consultantManageYourSchedule
                                                      .tr,
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
                    decoration: const BoxDecoration(
                        color: customTextFieldColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0))),
                    child: SingleChildScrollView(
                        child: Form(
                      key: _scheduleInfoFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),

                          ///---type-charges
                          Row(
                            children: [
                              ///---type
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.w, 0, 9.w, 0),
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        onTap: () {
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        },
                                        hint: Text(
                                          LanguageConstant
                                              .selectType.tr.capitalizeFirst!,
                                          style: state.hintTextStyle,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.w, 14.h, 15.w, 14.h),
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color:
                                                      customLightThemeColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                        ),
                                        isExpanded: true,
                                        focusColor: Colors.white,
                                        style: state.textFieldTextStyle,
                                        iconEnabledColor: customThemeColor,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        iconSize: 25,
                                        value: _mentorScheduleLogic
                                            .selectedScheduleType,
                                        items: _mentorScheduleLogic
                                            .scheduleTypeDropDownList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: state.textFieldTextStyle,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _mentorScheduleLogic
                                                .chargesController
                                                .clear();
                                            _mentorScheduleLogic
                                                .selectedScheduleType = value;
                                            for (var element
                                                in _mentorScheduleLogic
                                                    .getAppointmentTypesModel
                                                    .data!
                                                    .appointmenttype!) {
                                              if (element.name!.toUpperCase() ==
                                                  value) {
                                                _mentorScheduleLogic
                                                        .selectedScheduleTypeId =
                                                    element.id;
                                              }
                                            }
                                          });
                                          Get.find<GeneralController>()
                                              .updateFormLoaderController(true);
                                          getMethod(
                                              context,
                                              getAvailableDaysUrl,
                                              {
                                                'token': '123',
                                                'mentor_id': Get.find<
                                                        GeneralController>()
                                                    .storageBox
                                                    .read('userID'),
                                                'appointment_type_id':
                                                    _mentorScheduleLogic
                                                        .selectedScheduleTypeId,
                                              },
                                              false,
                                              getAvailableDaysRepo);
                                        },
                                        validator: (String? value) {
                                          if (value == null) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              ///---charges
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      9.w, 0, 15.w, 0),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6),
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                    style: state.textFieldTextStyle,
                                    controller:
                                        _mentorScheduleLogic.chargesController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              25.w, 15.h, 25.w, 15.h),
                                      hintText: LanguageConstant
                                          .enterCharges.tr.capitalizeFirst,
                                      hintStyle: state.hintTextStyle,
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: customLightThemeColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .fieldRequired.tr;
                                      } else if (int.parse(value.toString()) <
                                          100) {
                                        return '${LanguageConstant.minChargesIs.tr}\n${LanguageConstant.rs.tr}. 100'
                                            .tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///---holiday-selector
                          _mentorScheduleLogic.selectedScheduleType == null
                              ? const SizedBox()
                              : _mentorScheduleLogic
                                          .getAppointmentTypesModel
                                          .data!
                                          .appointmenttype![_mentorScheduleLogic
                                              .scheduleTypeDropDownList
                                              .indexOf(_mentorScheduleLogic
                                                  .selectedScheduleType!)]
                                          .isScheduleRequired ==
                                      0
                                  ? const SizedBox()
                                  : Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.w, 20.h, 15.w, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            LanguageConstant.selectHoliday.tr,
                                            style: state.headingTextStyle,
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 30.h,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: List.generate(
                                                    _mentorScheduleLogic
                                                        .dayListForHoliday
                                                        .length, (index) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 12.w, 0),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            _generalController
                                                                .updateFormLoaderController(
                                                                    true);
                                                            setState(() {
                                                              _mentorScheduleLogic
                                                                      .dayListForHoliday[
                                                                          index]
                                                                      .isSelected =
                                                                  !_mentorScheduleLogic
                                                                      .dayListForHoliday[
                                                                          index]
                                                                      .isSelected!;
                                                            });

                                                            Map<String, dynamic>
                                                                tempHolidayMap =
                                                                {};

                                                            for (var element
                                                                in _mentorScheduleLogic
                                                                    .dayListForHoliday) {
                                                              setState(() {
                                                                tempHolidayMap[
                                                                        '${element.slug}'] =
                                                                    element.isSelected!
                                                                        ? 1
                                                                        : 0;
                                                              });
                                                            }
                                                            postMethod(
                                                                context,
                                                                markDayHolidayUrl,
                                                                {
                                                                  'token':
                                                                      '123',
                                                                  'mentor_id': Get
                                                                          .find<
                                                                              GeneralController>()
                                                                      .storageBox
                                                                      .read(
                                                                          'userID'),
                                                                  'appointment_type_id':
                                                                      _mentorScheduleLogic
                                                                          .selectedScheduleTypeId,
                                                                  'availability':
                                                                      tempHolidayMap
                                                                },
                                                                true,
                                                                markHolidayPostRepo);
                                                          },
                                                          child: Container(
                                                            decoration: _mentorScheduleLogic
                                                                    .dayListForHoliday[
                                                                        index]
                                                                    .isSelected!
                                                                ? BoxDecoration(
                                                                    color:
                                                                        customThemeColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(4
                                                                            .r),
                                                                    border: Border.all(
                                                                        color:
                                                                            customThemeColor))
                                                                : BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(4
                                                                            .r),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black)),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          12.w,
                                                                          1.h,
                                                                          12.w,
                                                                          1.h),
                                                              child: Text(
                                                                '${_mentorScheduleLogic.dayListForHoliday[index].title}',
                                                                style: _mentorScheduleLogic
                                                                        .dayListForHoliday[
                                                                            index]
                                                                        .isSelected!
                                                                    ? state
                                                                        .scheduleDayTextStyle!
                                                                        .copyWith(
                                                                            color: Colors
                                                                                .white)
                                                                    : state
                                                                        .scheduleDayTextStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ))
                                        ],
                                      ),
                                    ),
                          SizedBox(
                            height: 20.h,
                          ),

                          ///---generate-slots
                          _mentorScheduleLogic.selectedScheduleType == null
                              ? const SizedBox()
                              : _mentorScheduleLogic
                                          .getAppointmentTypesModel
                                          .data!
                                          .appointmenttype![_mentorScheduleLogic
                                              .scheduleTypeDropDownList
                                              .indexOf(_mentorScheduleLogic
                                                  .selectedScheduleType!)]
                                          .isScheduleRequired ==
                                      0

                                  ///---save-button-for-without-schedule
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 30.h, 0, 30.h),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            log('testing it ');
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }

                                            if (_scheduleInfoFormKey
                                                .currentState!
                                                .validate()) {
                                              _generalController
                                                  .updateFormLoaderController(
                                                      true);
                                              postMethod(
                                                  context,
                                                  saveMentorChatFeeUrl,
                                                  {
                                                    'token': '123',
                                                    'mentor_id': Get.find<
                                                            GeneralController>()
                                                        .storageBox
                                                        .read('userID'),
                                                    'appointment_type_id':
                                                        _mentorScheduleLogic
                                                            .selectedScheduleTypeId,
                                                    'fee': _mentorScheduleLogic
                                                        .chargesController.text
                                                  },
                                                  true,
                                                  saveSchedulePostRepo);
                                            }
                                          },
                                          child: Container(
                                            height: 40.h,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            decoration: BoxDecoration(
                                                color: customLightThemeColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),
                                            child: Center(
                                              child: Text(
                                                LanguageConstant.save.tr,
                                                style: state.addButtonTextStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30.r))),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.w, 30.h, 15.w, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              LanguageConstant
                                                  .generateSlotsAutomatically
                                                  .tr,
                                              style: state.headingTextStyle,
                                            ),
                                            SizedBox(
                                              height: 12.h,
                                            ),

                                            ///---day-duration
                                            Row(
                                              children: [
                                                ///---day
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          onTap: () {
                                                            FocusScopeNode
                                                                currentFocus =
                                                                FocusScope.of(
                                                                    context);
                                                            if (!currentFocus
                                                                .hasPrimaryFocus) {
                                                              currentFocus
                                                                  .unfocus();
                                                            }
                                                          },
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            contentPadding:
                                                                EdgeInsets.symmetric(
                                                                    vertical:
                                                                        12.h,
                                                                    horizontal:
                                                                        10.0.w),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            customThemeColor)),
                                                            errorBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .red)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            customLightThemeColor)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color:
                                                                            customLightThemeColor)),
                                                          ),
                                                          focusColor:
                                                              Colors.white,
                                                          hint: const Text(
                                                              'Select Day'),
                                                          isExpanded: true,
                                                          style: state
                                                              .scheduleDayTextStyle,
                                                          iconEnabledColor:
                                                              customThemeColor,
                                                          icon: const Icon(Icons
                                                              .keyboard_arrow_down),
                                                          value: _mentorScheduleLogic
                                                              .selectedAvailableDay,
                                                          items: _mentorScheduleLogic
                                                              .availableDaysList
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: state
                                                                    .scheduleDayTextStyle,
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (String? value) {
                                                            _mentorScheduleLogic
                                                                .slotsList
                                                                .clear();
                                                            setState(() {
                                                              _mentorScheduleLogic
                                                                      .selectedAvailableDay =
                                                                  value;
                                                            });
                                                          },
                                                          validator:
                                                              (String? value) {
                                                            if (value == null) {
                                                              return LanguageConstant
                                                                  .fieldRequired
                                                                  .tr;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(start: 5.w),
                                                      child: Text(
                                                        LanguageConstant
                                                            .selectDay.tr,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: state
                                                            .subHeadingTextStyle,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                                const SizedBox(
                                                  width: 10,
                                                ),

                                                ///---duration
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    TextFormField(
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            3),
                                                        FilteringTextInputFormatter
                                                            .allow(
                                                                RegExp("[0-9]"))
                                                      ],
                                                      style: state
                                                          .scheduleDayTextStyle,
                                                      controller:
                                                          _mentorScheduleLogic
                                                              .durationController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      cursorColor: Colors.black,
                                                      cursorWidth: 1,
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        hintText: 'Duration',
                                                        suffixIcon: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                LanguageConstant
                                                                    .minute.tr,
                                                                style: state
                                                                    .scheduleDayTextStyle),
                                                          ],
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12.h,
                                                                    horizontal:
                                                                        30.w),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        customThemeColor)),
                                                        errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        customLightThemeColor)),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color:
                                                                        customLightThemeColor)),
                                                      ),
                                                      onChanged: (v) {
                                                        setState(() {
                                                          _mentorScheduleLogic
                                                              .slotsList
                                                              .clear();
                                                        });
                                                      },
                                                      validator:
                                                          (String? value) {
                                                        if (value!.isEmpty) {
                                                          return LanguageConstant
                                                              .fieldRequired.tr;
                                                        } else if (int.parse(
                                                                _mentorScheduleLogic
                                                                    .durationController
                                                                    .text) <
                                                            5) {
                                                          return LanguageConstant
                                                              .slotMustBeGreaterThan5Minutes
                                                              .tr;
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(start: 5.w),
                                                      child: Text(
                                                        LanguageConstant
                                                            .slotDuration.tr,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: state
                                                            .subHeadingTextStyle,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12.h,
                                            ),

                                            ///---times
                                            Row(
                                              children: [
                                                ///---start-time
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        /// for focus out
                                                        FocusScopeNode
                                                            currentFocus =
                                                            FocusScope.of(
                                                                context);
                                                        if (!currentFocus
                                                            .hasPrimaryFocus) {
                                                          currentFocus
                                                              .unfocus();
                                                        } else {}
                                                        final picked =
                                                            await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    TimeOfDay
                                                                        .now(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    Widget?
                                                                        child) {
                                                                  return Theme(
                                                                    data: ThemeData(
                                                                        colorScheme:
                                                                            ColorScheme.fromSwatch().copyWith(primary: customThemeColor)),
                                                                    child:
                                                                        MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: false),
                                                                      child:
                                                                          child!,
                                                                    ),
                                                                  );
                                                                });
                                                        String hour;
                                                        // if (picked!.hour
                                                        //         .toString()
                                                        //         .length <
                                                        //     2) {
                                                        //   hour = picked.hour.toString();
                                                        //   hour = '0' + hour;
                                                        if (picked != null) {
                                                          setState(() {
                                                            _mentorScheduleLogic
                                                                .slotsList
                                                                .clear();
                                                            _mentorScheduleLogic
                                                                    .selectedTimeForStartForCalculate =
                                                                DateTimeField
                                                                        .convert(
                                                                            picked)
                                                                    .toString()
                                                                    .substring(
                                                                        11);

                                                            _mentorScheduleLogic
                                                                    .selectedTimeForStart =
                                                                picked.format(
                                                                    context);
                                                            log('This is start time: ${picked.hour}');
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                          height: 45.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                              border: Border.all(
                                                                  color: timeValidator &&
                                                                          _mentorScheduleLogic.selectedTimeForStart ==
                                                                              null
                                                                      ? Colors
                                                                          .red
                                                                      : customLightThemeColor)),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            25.w,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  _mentorScheduleLogic
                                                                              .selectedTimeForStart ==
                                                                          null
                                                                      ? ''
                                                                      : '${_mentorScheduleLogic.selectedTimeForStart}',
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  style: state
                                                                      .scheduleDayTextStyle,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                    timeValidator &&
                                                            _mentorScheduleLogic
                                                                    .selectedTimeForStart ==
                                                                null
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        7.w,
                                                                        5.h,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  LanguageConstant
                                                                      .fieldRequired
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          SarabunFontFamily
                                                                              .regular,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                          .red),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(start: 5.w),
                                                      child: Text(
                                                        LanguageConstant
                                                            .startTime.tr,
                                                        style: state
                                                            .subHeadingTextStyle,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                                const SizedBox(
                                                  width: 10,
                                                ),

                                                ///---end-time
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        final picked =
                                                            await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    TimeOfDay
                                                                        .now(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    Widget?
                                                                        child) {
                                                                  return Theme(
                                                                    data: ThemeData(
                                                                        colorScheme:
                                                                            ColorScheme.fromSwatch().copyWith(primary: customThemeColor)),
                                                                    child:
                                                                        MediaQuery(
                                                                      data: MediaQuery.of(
                                                                              context)
                                                                          .copyWith(
                                                                              alwaysUse24HourFormat: false),
                                                                      child:
                                                                          child!,
                                                                    ),
                                                                  );
                                                                });

                                                        if (picked != null) {
                                                          setState(() {
                                                            _mentorScheduleLogic
                                                                .slotsList
                                                                .clear();
                                                            _mentorScheduleLogic
                                                                    .selectedTimeForEndForCalculate =
                                                                DateTimeField
                                                                        .convert(
                                                                            picked)
                                                                    .toString()
                                                                    .substring(
                                                                        11);
                                                            _mentorScheduleLogic
                                                                    .selectedTimeForEnd =
                                                                picked.format(
                                                                    context);
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                          height: 45.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                              border: Border.all(
                                                                  color: timeValidator &&
                                                                          _mentorScheduleLogic.selectedTimeForEnd ==
                                                                              null
                                                                      ? Colors
                                                                          .red
                                                                      : customLightThemeColor)),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            25.w,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  _mentorScheduleLogic
                                                                              .selectedTimeForEnd ==
                                                                          null
                                                                      ? ''
                                                                      : '${_mentorScheduleLogic.selectedTimeForEnd}',
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  style: state
                                                                      .scheduleDayTextStyle,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                    timeValidator &&
                                                            _mentorScheduleLogic
                                                                    .selectedTimeForEnd ==
                                                                null
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        7.w,
                                                                        5.h,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  LanguageConstant
                                                                      .fieldRequired
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          SarabunFontFamily
                                                                              .regular,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                          .red),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(start: 5.w),
                                                      child: Text(
                                                        LanguageConstant
                                                            .endTime.tr,
                                                        style: state
                                                            .subHeadingTextStyle,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),

                                            ///---generate-slot-button
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 30.h, 0, 0),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    FocusScopeNode
                                                        currentFocus =
                                                        FocusScope.of(context);
                                                    if (!currentFocus
                                                        .hasPrimaryFocus) {
                                                      currentFocus.unfocus();
                                                    }

                                                    if (_scheduleInfoFormKey
                                                            .currentState!
                                                            .validate() &&
                                                        _mentorScheduleLogic
                                                                .selectedTimeForEnd !=
                                                            null &&
                                                        _mentorScheduleLogic
                                                                .selectedTimeForStart !=
                                                            null) {
                                                      setState(() {
                                                        timeValidator = false;
                                                      });
                                                      final startTime = TimeOfDay(
                                                          hour: int.parse(
                                                              _mentorScheduleLogic
                                                                  .selectedTimeForStartForCalculate!
                                                                  .substring(
                                                                      0, 2)
                                                                  .toString()),
                                                          minute: int.parse(
                                                              _mentorScheduleLogic
                                                                  .selectedTimeForStartForCalculate!
                                                                  .substring(
                                                                      3, 5)
                                                                  .toString()));
                                                      final endTime = TimeOfDay(
                                                          hour: int.parse(
                                                              _mentorScheduleLogic
                                                                  .selectedTimeForEndForCalculate!
                                                                  .substring(
                                                                      0, 2)
                                                                  .toString()),
                                                          minute: int.parse(
                                                              _mentorScheduleLogic
                                                                  .selectedTimeForEndForCalculate!
                                                                  .substring(
                                                                      3, 5)
                                                                  .toString()));
                                                      final step = Duration(
                                                          minutes: int.parse(
                                                              _mentorScheduleLogic
                                                                  .durationController
                                                                  .text
                                                                  .toString()));

                                                      _mentorScheduleLogic.slotsList =
                                                          _mentorScheduleLogic
                                                              .getTimes(
                                                                  startTime,
                                                                  endTime,
                                                                  step)
                                                              .map((tod) =>
                                                                  tod.format(
                                                                      context))
                                                              .toList();
                                                      setState(() {
                                                        _mentorScheduleLogic
                                                                .slotsList
                                                                .length =
                                                            _mentorScheduleLogic
                                                                    .slotsList
                                                                    .length -
                                                                1;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        timeValidator = true;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .45,
                                                    decoration: BoxDecoration(
                                                        color: _mentorScheduleLogic
                                                                .slotsList
                                                                .isEmpty
                                                            ? customLightThemeColor
                                                            : Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r)),
                                                    child: Center(
                                                      child: Text(
                                                        LanguageConstant
                                                            .generateSlot.tr,
                                                        style: state
                                                            .addButtonTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),

                                            ///---slots
                                            _mentorScheduleLogic
                                                    .slotsList.isEmpty
                                                ? const SizedBox()
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        LanguageConstant
                                                            .slotsCreated.tr,
                                                        style: state
                                                            .headingTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Wrap(
                                                        children: List.generate(
                                                            _mentorScheduleLogic
                                                                .slotsList
                                                                .length,
                                                            (index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    7,
                                                                    14,
                                                                    7),
                                                            child: Container(
                                                              color:
                                                                  customTextFieldColor,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        8,
                                                                        10,
                                                                        8),
                                                                child: Text(
                                                                    '${_mentorScheduleLogic.slotsList[index]}',
                                                                    textDirection:
                                                                        TextDirection
                                                                            .ltr,
                                                                    style: state
                                                                        .slotTextStyle),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  ),

                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                          ///---save-button-for-schedule
                          _mentorScheduleLogic.slotsList.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 30),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }

                                        _generalController
                                            .updateFormLoaderController(true);
                                        postMethod(
                                            context,
                                            saveMentorSchedulesUrl,
                                            {
                                              'token': '123',
                                              'mentor_id':
                                                  Get.find<GeneralController>()
                                                      .storageBox
                                                      .read('userID'),
                                              'appointment_type_id':
                                                  _mentorScheduleLogic
                                                      .selectedScheduleTypeId,
                                              'fee': _mentorScheduleLogic
                                                  .chargesController.text,
                                              'day': _mentorScheduleLogic
                                                  .selectedAvailableDay,
                                              'interval': _mentorScheduleLogic
                                                  .durationController.text,
                                              'slots':
                                                  _mentorScheduleLogic.slotsList
                                            },
                                            true,
                                            saveSchedulePostRepo);
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        decoration: BoxDecoration(
                                            color: customLightThemeColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(
                                            LanguageConstant.save.tr,
                                            style: state.addButtonTextStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                          ///---added-record-preview
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 0, 15, 20),
                              child: Wrap(
                                children: List.generate(
                                    _mentorScheduleLogic
                                        .forDisplayWithoutScheduleList!
                                        .length, (index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 15, 7, 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ///---type
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .type.tr,
                                                          style: state
                                                              .previewLabelTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          _mentorScheduleLogic
                                                                  .scheduleTypeDropDownList[
                                                              _mentorScheduleLogic
                                                                      .forDisplayWithoutScheduleList![
                                                                          index]
                                                                      .appointmentTypeId! -
                                                                  1],
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: state
                                                              .previewValueTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  ///---fee-day
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .charges.tr,
                                                          style: state
                                                              .previewLabelTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          '${_mentorScheduleLogic.forDisplayWithoutScheduleList![index].fee}',
                                                          style: state
                                                              .previewValueTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _generalController
                                                          .updateFormLoaderController(
                                                              true);
                                                      postMethod(
                                                          context,
                                                          deleteMentorScheduleUrl,
                                                          {
                                                            'token': '123',
                                                            'id': _mentorScheduleLogic
                                                                .forDisplayWithoutScheduleList![
                                                                    index]
                                                                .id,
                                                            'appointment_type_id':
                                                                _mentorScheduleLogic
                                                                    .forDisplayWithoutScheduleList![
                                                                        index]
                                                                    .appointmentTypeId
                                                          },
                                                          true,
                                                          deleteMentorScheduleRepo);
                                                      setState(() {});
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .all(8.0),
                                                      child: SvgPicture.asset(
                                                          'assets/Icons/deleteIcon.svg'),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              const SizedBox(
                                                height: 14,
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                }),
                              )),
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 0, 15, 20),
                              child: Wrap(
                                children: List.generate(
                                    _mentorScheduleLogic.forDisplayScheduleList!
                                        .length, (index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(15, 15, 7, 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ///---type
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .type.tr,
                                                          style: state
                                                              .previewLabelTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          _mentorScheduleLogic
                                                                  .scheduleTypeDropDownList[
                                                              _mentorScheduleLogic
                                                                      .forDisplayScheduleList![
                                                                          index]
                                                                      .appointmentTypeId! -
                                                                  1],
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: state
                                                              .previewValueTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .charges.tr,
                                                          style: state
                                                              .previewLabelTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          '${_mentorScheduleLogic.forDisplayScheduleList![index].fee}',
                                                          style: state
                                                              .previewValueTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _generalController
                                                          .updateFormLoaderController(
                                                              true);
                                                      postMethod(
                                                          context,
                                                          deleteMentorScheduleUrl,
                                                          {
                                                            'token': '123',
                                                            'id': _mentorScheduleLogic
                                                                .forDisplayScheduleList![
                                                                    index]
                                                                .id
                                                          },
                                                          true,
                                                          deleteMentorScheduleRepo);
                                                      setState(() {});
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .all(8.0),
                                                      child: SvgPicture.asset(
                                                          'assets/Icons/deleteIcon.svg'),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              const SizedBox(
                                                height: 14,
                                              ),

                                              ///---fee-day
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .day.tr,
                                                          style: state
                                                              .previewLabelTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          _mentorScheduleLogic
                                                              .forDisplayScheduleList![
                                                                  index]
                                                              .day!
                                                              .toUpperCase(),
                                                          style: state
                                                              .previewValueTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                LanguageConstant.slots.tr,
                                                style:
                                                    state.previewLabelTextStyle,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Wrap(
                                                children: List.generate(
                                                    _mentorScheduleLogic
                                                        .forDisplayScheduleList![
                                                            index]
                                                        .scheduleSlots!
                                                        .length, (innerIndex) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 7, 14, 7),
                                                    child: Container(
                                                      color:
                                                          customTextFieldColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 8, 10, 8),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                '${_mentorScheduleLogic.forDisplayScheduleList![index].scheduleSlots![innerIndex].startTime}',
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                style: state
                                                                    .slotTextStyle),
                                                            // InkWell(
                                                            //     onTap: () {
                                                            //       log('--->>>Deactivate');
                                                            //     },
                                                            //     child:
                                                            //         const Padding(
                                                            //       padding:
                                                            //           EdgeInsets
                                                            //               .fromLTRB(
                                                            //                   5,
                                                            //                   0,
                                                            //                   10,
                                                            //                   0),
                                                            //       child: Icon(
                                                            //         Icons.clear,
                                                            //         color: Colors
                                                            //             .red,
                                                            //         size: 20,
                                                            //       ),
                                                            //     ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                }),
                              )),
                        ],
                      ),
                    )),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
