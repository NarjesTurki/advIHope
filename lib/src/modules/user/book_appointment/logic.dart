import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/modules/user/appointment_detail/payment/model_stripe_payment.dart';
import 'package:ista_app/src/modules/user/book_appointment/model/book_appointment.dart';
import 'package:ista_app/src/modules/user/book_appointment/model/getAppDetail_forReschedule.dart';
import 'package:ista_app/src/modules/user/book_appointment/model/get_date_schedule.dart';
import 'package:ista_app/src/modules/user/book_appointment/model/get_payment_methods.dart';
import 'package:ista_app/src/modules/user/book_appointment/model/get_schedule_available_days.dart';
import 'package:ista_app/src/modules/user/book_appointment/state.dart';
import 'package:ista_app/src/modules/user/consultant_profile/logic.dart';
import 'package:ista_app/src/modules/user/consultant_profile/model_consultant_profile.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resize/resize.dart';

class BookAppointmentLogic extends GetxController {
  final BookAppointmentState state = BookAppointmentState();

  final consultantProfileLogic = Get.find<ConsultantProfileLogic>();
  GetAppDetailForReschedule getAppDetailForReschedule =
      GetAppDetailForReschedule();
  GetPaymentMethods getPaymentMethods = GetPaymentMethods();
  // GetConfigCredentialModel getConfigCredentialModel = GetConfigCredentialModel();

  var cardNumberMask = MaskTextInputFormatter(mask: '#### #### #### ####');
  var cardExpiryMask = MaskTextInputFormatter(mask: '##/##');
  final TextEditingController paymentAccountNumberTextController =
      TextEditingController();
  final TextEditingController jazzCashCnicTextController =
      TextEditingController();

  //ModelFlutterWave modelFlutterWave = ModelFlutterWave();

  bool? formLoaderController = false;

  updateFormLoaderController(bool? newValue) {
    formLoaderController = newValue;
    update();
  }

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  ScrollController? scrollController2;
  ScrollController? scrollController3;
  bool lastStatus2 = true;
  bool lastStatus = true;
  bool lastStatus3 = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  bool get isShrink2 {
    return scrollController2!.hasClients &&
        scrollController2!.offset > (height - kToolbarHeight);
  }

  void scrollListener2() {
    if (isShrink2 != lastStatus2) {
      lastStatus2 = isShrink2;
      update();
    }
  }

  bool get isShrink3 {
    return scrollController3!.hasClients &&
        scrollController3!.offset > (height - kToolbarHeight);
  }

  void scrollListener3() {
    if (isShrink3 != lastStatus3) {
      lastStatus3 = isShrink3;
      update();
    }
  }

  ///----app-bar-settings-----end

  int? selectedAppointmentTypeID;
  int? selectedAppointmentTypeIndex;

  GetScheduleAvailableDays getScheduleAvailableDays =
      GetScheduleAvailableDays();
  List<DateTime>? availableScheduleDaysList = <DateTime>[];

  bool? calenderLoader = false;

  updateCalenderLoader(bool? newValue) {
    calenderLoader = newValue;
    update();
  }

  GetScheduleSlotsForUserModel getScheduleSlotsForUserModel =
      GetScheduleSlotsForUserModel();
  String selectedDateForAppointment = '';
  String selectedTimeForAppointment = '';
  String selectedEndTimeForAppointment = '';
  ScheduleSlots selectedScheduleSlots = ScheduleSlots();

  bool getScheduleSlotsForMenteeLoader = false;
  updateGetScheduleSlotsForMenteeLoader(bool newValue) {
    getScheduleSlotsForMenteeLoader = newValue;
    update();
  }

  List<GetPaymentMethodData> getPaymentMethodList = [];
  int? paymentId;
  String? paymentName;
  updatePaymentMethodList(GetPaymentMethodData newValue) {
    if (newValue.isDefault == 1) {
      updateSelectedMethod(newValue.id, newValue.name!);
      paymentId = (newValue.id);
      paymentName = (newValue.name);
    }
    getPaymentMethodList.add(newValue);
    update();
  }

  int? appointmentShiftType = 0;

  updateAppointmentShiftType(int? newValue) {
    appointmentShiftType = newValue;
    update();
  }

  int? selectedMethodId = 9190;
  String selectedMethodTitle = '';

  updateSelectedMethod(int? newValue, String title) {
    log(newValue.toString());
    selectedMethodId = newValue;
    selectedMethodTitle = title;
    update();
  }

  List<ScheduleSlots> morningSlots = [];
  updateMorningSlots(ScheduleSlots newValue) {
    morningSlots.add(newValue);
    update();
  }

  emptyMorningSlots() {
    morningSlots = [];
    update();
  }

  List<ScheduleSlots> afterNoonSlots = [];
  updateAfterNoonSlots(ScheduleSlots newValue) {
    afterNoonSlots.add(newValue);
    update();
  }

  emptyAfterNoonSlots() {
    afterNoonSlots = [];
    update();
  }

  List<ScheduleSlots> eveningSlots = [];
  updateEveningSlots(ScheduleSlots newValue) {
    eveningSlots.add(newValue);
    update();
  }

  emptyEveningSlots() {
    eveningSlots = [];
    update();
  }

  List<ShiftType> shiftList = [
    ShiftType(
        title: LanguageConstant.morning.tr,
        image: 'assets/Icons/morningShiftIcon.svg',
        isSelected: true),
    ShiftType(
        title: LanguageConstant.afternoon.tr,
        image: 'assets/Icons/afterNoonShiftIcon.svg',
        isSelected: false),
    ShiftType(
        title: LanguageConstant.evening.tr,
        image: 'assets/Icons/nightShiftIcon.svg',
        isSelected: false),
  ];

  int? selectedPaymentType;
  List<ShiftType> paymentMethodList = [
    ShiftType(
        title: 'stripe', image: 'assets/Icons/stripe.svg', isSelected: false),
    ShiftType(
        title: 'paypal',
        image: 'assets/Icons/paypalPayment.svg',
        isSelected: false),
    ShiftType(
        title: 'easypaisa',
        image: 'assets/Icons/easyIcon.svg',
        isSelected: false),
  ];

  String? selectedFileName;
  FilePickerResult? filePickerResult;

  updateSelectedFileName(String? newValue) {
    selectedFileName = newValue;
    update();
  }

  BookAppointmentModel bookAppointmentModel = BookAppointmentModel();
  TextEditingController questionController = TextEditingController();

  ScheduleTypes? selectMentorAppointmentType;
  updateSelectMentorAppointmentType(ScheduleTypes? newValue) {
    selectMentorAppointmentType = newValue;
    update();
  }

  ModelStripePayment modelStripePayment = ModelStripePayment();

  double myWidth = 0;
  TextEditingController accountCardNumberController = TextEditingController();
  TextEditingController accountCardHolderNameController =
      TextEditingController();
  TextEditingController accountCardExpiresController = TextEditingController();
  TextEditingController accountCardCvcController = TextEditingController();
}

class ShiftType {
  ShiftType({this.title, this.image, this.isSelected});

  String? title;
  String? image;
  bool? isSelected;
}
