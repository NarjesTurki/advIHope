import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/book_appointment/post_repo.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:resize/resize.dart';

class AppointmentQuestionPage extends StatefulWidget {
  int? appointmentId;
  int? mentorId;
  bool? showPaymentSection;
  AppointmentQuestionPage(
      {Key? key, this.appointmentId, this.mentorId, this.showPaymentSection})
      : super(key: key);

  @override
  _AppointmentQuestionPageState createState() =>
      _AppointmentQuestionPageState();
}

class _AppointmentQuestionPageState extends State<AppointmentQuestionPage> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  void initState() {
    super.initState();

    Get.find<BookAppointmentLogic>().scrollController2 = ScrollController()
      ..addListener(Get.find<BookAppointmentLogic>().scrollListener2);
    Get.find<BookAppointmentLogic>().selectedPaymentType = null;
    Get.find<BookAppointmentLogic>().questionController.clear();
    if (widget.appointmentId != null) {
      getMethod(
          context,
          getAppointmentsDetailURL,
          {
            'token': 123,
            'appointment_id': widget.appointmentId,
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getAppDetailForReschedule);
    }

    getMethod(
        context,
        getPaymentMethodsUrl,
        {
          'token': 123,
          'platform': 'app',
        },
        true,
        getPaymentMethodsRepo);
  }

  @override
  void dispose() {
    Get.find<BookAppointmentLogic>()
        .scrollController2!
        .removeListener(Get.find<BookAppointmentLogic>().scrollListener2);
    Get.find<BookAppointmentLogic>().scrollController2!.dispose();
    super.dispose();
  }

  bool? disableButton = true;
  bool? wave = false;
  bool? razorPay = false;
  bool? paytm = false;
  bool? wallet = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            inAsyncCall: _generalController.formLoaderController,
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: NestedScrollView(
                  controller: _bookAppointmentLogic.scrollController2,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      MyCustomSliverAppBar(
                        heading: LanguageConstant.bookAppointment.tr,
                        subHeading: LanguageConstant.byJustFewEasySteps.tr,
                        trailing: LanguageConstant.step2Of3.tr,
                        isShrink: _bookAppointmentLogic.isShrink2,
                        fee:
                            '${Get.find<GeneralController>().storageBox.read('currency')}${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].fee}',
                      ),
                    ];
                  },
                  body: Stack(
                    children: [
                      ListView(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 0.h, 15.w, 0),
                          children: [
                            ///---question-area
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 15,
                                      // offset: Offset(1,5)
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.h, horizontal: 20.w),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageConstant.typeYourQuestion.tr,
                                        style: state.headingTextStyle,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      ///---question-field

                                      TextFormField(
                                        controller: _bookAppointmentLogic
                                            .questionController,
                                        keyboardType: TextInputType.text,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          fillColor: const Color.fromARGB(
                                              255, 215, 241, 216),
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 25.h,
                            ),

                            ///---upload-file-area
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 15,
                                      // offset: Offset(1,5)
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.h, horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          LanguageConstant.uploadFile.tr,
                                          style: state.headingTextStyle,
                                        ),
                                        Text(
                                          '  (${LanguageConstant.ifAny.tr})',
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.medium,
                                              fontSize: 12.sp,
                                              color: customTextBlackColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (_bookAppointmentLogic
                                                .selectedFileName ==
                                            null) {
                                          _bookAppointmentLogic
                                                  .filePickerResult =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.any,
                                            // allowedExtensions: ["jpg", "png", "pdf", "doc"],
                                          );
                                          if (_bookAppointmentLogic
                                                  .filePickerResult !=
                                              null) {
                                            final file = File(
                                                _bookAppointmentLogic
                                                    .filePickerResult!
                                                    .files[0]
                                                    .path!);
                                            setState(() {});
                                            int sizeInBytes = file.lengthSync();
                                            double sizeInMb =
                                                sizeInBytes / (1024 * 1024);
                                            if (sizeInMb > 10) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CustomDialogBox(
                                                      title: LanguageConstant
                                                          .failed.tr,
                                                      titleColor:
                                                          customDialogErrorColor,
                                                      descriptions: LanguageConstant
                                                          .fileIsGreaterThan10mb
                                                          .tr,
                                                      text: LanguageConstant
                                                          .ok.tr,
                                                      functionCall: () {
                                                        Navigator.pop(context);
                                                      },
                                                      img:
                                                          'assets/Icons/dialog_error.svg',
                                                    );
                                                  });
                                            } else {
                                              _bookAppointmentLogic
                                                  .updateSelectedFileName(
                                                      _bookAppointmentLogic
                                                          .filePickerResult!
                                                          .files[0]
                                                          .name);
                                              setState(() {});
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 69.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: customLightThemeColor,
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: SvgPicture.asset(
                                                'assets/Icons/dottedBorder.svg',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.fill,
                                                color: customThemeColor,
                                              ),
                                            ),
                                            Center(
                                              child: _bookAppointmentLogic
                                                          .selectedFileName !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              _bookAppointmentLogic
                                                                  .selectedFileName!,
                                                              softWrap: true,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      SarabunFontFamily
                                                                          .medium,
                                                                  fontSize:
                                                                      12.sp,
                                                                  color:
                                                                      customOrangeColor),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              _bookAppointmentLogic
                                                                  .updateSelectedFileName(
                                                                      null);
                                                            },
                                                            child: const Icon(
                                                              Icons.cancel,
                                                              color:
                                                                  customOrangeColor,
                                                              size: 25,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        ColorFiltered(
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  Colors.white,
                                                                  BlendMode
                                                                      .srcIn),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/Icons/upload.svg',
                                                            height: 25.h,
                                                            width: 25.w,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15.w,
                                                        ),
                                                        Text(
                                                          LanguageConstant
                                                              .uploadHere.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .medium,
                                                              fontSize: 12.sp,
                                                              color: Colors
                                                                  .white), //hethi lktiba
                                                        )
                                                      ],
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),

                            ///---payment-method-area
                            widget.showPaymentSection == true
                                ? const SizedBox()
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        border: Border.all(
                                            color: customTextBlackColor,
                                            width: 1)),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.w, 25.h, 20.w, 7.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            LanguageConstant.paymentMethod.tr,
                                            style: state.headingTextStyle,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Wrap(
                                            children: List.generate(
                                                _bookAppointmentLogic
                                                    .getPaymentMethodList
                                                    .length, (index) {
                                              return Padding(
                                                padding: index % 2 == 0
                                                    ? EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0, 0, 8.w, 18.h)
                                                    : EdgeInsetsDirectional
                                                        .fromSTEB(8.w, 0.h, 0.w,
                                                            18.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    // for (var element in _bookAppointmentLogic.paymentMethodList) {
                                                    //   element.isSelected = false;
                                                    // }
                                                    log('${_bookAppointmentLogic.getPaymentMethodList[index].id}');
                                                    log('${_bookAppointmentLogic.getPaymentMethodList[index].name}');

                                                    _bookAppointmentLogic
                                                        .updateSelectedMethod(
                                                            _bookAppointmentLogic
                                                                .getPaymentMethodList[
                                                                    index]
                                                                .id,
                                                            _bookAppointmentLogic
                                                                .getPaymentMethodList[
                                                                    index]
                                                                .name!);
                                                    // _bookAppointmentLogic.selectedPaymentType = index;
                                                    _bookAppointmentLogic
                                                        .update();
                                                    setState(() {
                                                      disableButton = false;
                                                    });

                                                    /// Show flutterwave payment button
                                                    if (_bookAppointmentLogic
                                                        .getPaymentMethodList[
                                                            index]
                                                        .code!
                                                        .contains(
                                                            'flutterwave')) {
                                                      setState(() {
                                                        wave = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        wave = false;
                                                      });
                                                    }

                                                    /// Show razorPay payment button
                                                    if (_bookAppointmentLogic
                                                        .getPaymentMethodList[
                                                            index]
                                                        .code!
                                                        .contains('razorpay')) {
                                                      setState(() {
                                                        razorPay = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        razorPay = false;
                                                      });
                                                    }

                                                    /// Show paytm payment button
                                                    if (_bookAppointmentLogic
                                                        .getPaymentMethodList[
                                                            index]
                                                        .code!
                                                        .contains('paytm')) {
                                                      setState(() {
                                                        paytm = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        paytm = false;
                                                      });
                                                    }

                                                    /// Show wallet payment button
                                                    if (_bookAppointmentLogic
                                                        .getPaymentMethodList[
                                                            index]
                                                        .code!
                                                        .contains('wallet')) {
                                                      setState(() {
                                                        wallet = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        wallet = false;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 61.h,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .38,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: (_bookAppointmentLogic
                                                                            .selectedMethodId ??
                                                                        9091) ==
                                                                    _bookAppointmentLogic
                                                                        .getPaymentMethodList[
                                                                            index]
                                                                        .id
                                                                ? customLightThemeColor
                                                                : Colors.white,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: _bookAppointmentLogic
                                                                        .getPaymentMethodList[
                                                                            index]
                                                                        .isDefault ==
                                                                    1
                                                                ? customLightThemeColor
                                                                    .withOpacity(
                                                                        0.2)
                                                                : Colors.grey
                                                                    .withOpacity(
                                                                        0.2),
                                                            spreadRadius: -2,
                                                            blurRadius: 15,
                                                            // offset: Offset(1,5)
                                                          )
                                                        ]),
                                                    child: _bookAppointmentLogic
                                                            .getPaymentMethodList[
                                                                index]
                                                            .code!
                                                            .contains(
                                                                'braintreePayment')
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            child:
                                                                Image.network(
                                                              '$mediaUrl${_bookAppointmentLogic.getPaymentMethodList[index].imagePath}',
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                            ),
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              _bookAppointmentLogic
                                                                          .getPaymentMethodList[
                                                                              index]
                                                                          .id ==
                                                                      110
                                                                  ? SvgPicture
                                                                      .asset(
                                                                      _bookAppointmentLogic
                                                                          .getPaymentMethodList[
                                                                              index]
                                                                          .imagePath!,
                                                                      width:
                                                                          25.w,
                                                                      height:
                                                                          25.h,
                                                                    )
                                                                  : Image
                                                                      .network(
                                                                      '$mediaUrl${_bookAppointmentLogic.getPaymentMethodList[index].imagePath}',
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .15,
                                                                    ),
                                                            ],
                                                          ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .15),
                          ]),

                      ///---bottom-bar
                      widget.showPaymentSection == true
                          ? Positioned(
                              bottom: 0.h,
                              left: 15.w,
                              right: 15.w,
                              child: InkWell(
                                onTap: () {
                                  Get.find<GeneralController>()
                                      .updateFormLoaderController(true);
                                  print(_bookAppointmentLogic
                                      .selectMentorAppointmentType!
                                      .appointmentType!
                                      .id);
                                  print(_bookAppointmentLogic
                                      .selectMentorAppointmentType!
                                      .appointmentType);
                                  postMethod(
                                      context,
                                      bookAppointmentUrl,
                                      {
                                        'token': '123',
                                        'mentee_id': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .menteeId,
                                        'mentor_id': widget.mentorId,
                                        'payment': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .payment,
                                        'payment_id': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .paymentId,
                                        'questions': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .questions,
                                        'appointment_type_string':
                                            _bookAppointmentLogic
                                                .selectMentorAppointmentType!
                                                .appointmentType!
                                                .name,
                                        'appointment_type_id':
                                            _bookAppointmentLogic
                                                .selectMentorAppointmentType!
                                                .appointmentType!
                                                .id,
                                        'date': _bookAppointmentLogic
                                            .selectedDateForAppointment
                                            .substring(0, 11),
                                        'time': _bookAppointmentLogic
                                            .selectedTimeForAppointment,
                                        'bookAppointmentId':
                                            widget.appointmentId,
                                        'end_time': _bookAppointmentLogic
                                            .selectedEndTimeForAppointment
                                      },
                                      true,
                                      bookRescheduleAppointmentWithoutFileRepo);
                                },
                                child: const MyCustomBottomBar(
                                  title: 'Update',
                                  disable: false,
                                ),
                              ),
                            )

                          ///  wallet
                          // : wallet == true
                          //     ? Positioned(
                          //         bottom: 0.h,
                          //         left: 15.w,
                          //         right: 15.w,
                          //         child: InkWell(
                          //           onTap: () {
                          //             if (_formKey.currentState!.validate()) {
                          //               print("-=-=----=-=-=-=-=-=-=-");
                          //               print(widget.appointmentId);
                          //
                          //               Get.to(WalletPaymentView(appointmentId: widget.appointmentId));
                          //             }
                          //           },
                          //           child: const MyCustomBottomBar(
                          //             title: 'Wallet',
                          //             disable: false,
                          //           ),
                          //         ),
                          //       )

                          : Positioned(
                              bottom: 0.h,
                              left: 15.w,
                              right: 15.w,
                              child: InkWell(
                                onTap: () async {
                                  if (!disableButton! &&
                                      _formKey.currentState!.validate()) {
                                    _generalController
                                        .updateFormLoaderController(true);

                                    dio_instance.FormData formData =
                                        dio_instance.FormData
                                            .fromMap(<String, dynamic>{
                                      'token': '123',
                                      'mentee_id': Get.find<GeneralController>()
                                          .storageBox
                                          .read('userID'),
                                      'mentor_id': Get.find<UserHomeLogic>()
                                          .selectedConsultantID,
                                      'payment': _bookAppointmentLogic
                                          .selectMentorAppointmentType!.fee,
                                      'payment_id':
                                          _bookAppointmentLogic.paymentId,
                                      'questions': _bookAppointmentLogic
                                          .questionController.text,
                                      'appointment_type_string':
                                          _bookAppointmentLogic
                                              .selectMentorAppointmentType!
                                              .appointmentType!
                                              .name,
                                      'appointment_type_id':
                                          _bookAppointmentLogic
                                              .selectMentorAppointmentType!
                                              .appointmentType!
                                              .id,
                                      if (_bookAppointmentLogic
                                              .selectMentorAppointmentType!
                                              .appointmentType!
                                              .isScheduleRequired ==
                                          1)
                                        'date': _bookAppointmentLogic
                                            .selectedDateForAppointment
                                            .substring(0, 11),
                                      if (_bookAppointmentLogic
                                              .selectMentorAppointmentType!
                                              .appointmentType!
                                              .isScheduleRequired ==
                                          1)
                                        'time': _bookAppointmentLogic
                                            .selectedTimeForAppointment,
                                      'end_time': _bookAppointmentLogic
                                          .selectedEndTimeForAppointment,
                                      if (_bookAppointmentLogic
                                              .selectedFileName !=
                                          null)
                                        'book_file': await dio_instance
                                            .MultipartFile.fromFile(
                                          File(_bookAppointmentLogic
                                                  .filePickerResult!
                                                  .files[0]
                                                  .path!)
                                              .path,
                                        )
                                    });

                                    postMethod(context, bookAppointmentUrl,
                                        formData, true, bookAppointmentRepo);
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
          ),
        );
      });
    });
  }
}
