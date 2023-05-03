import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/consultant/schedule/model_get_appointment_types.dart';
import 'package:ista_app/src/modules/consultant/schedule/model_get_available_days.dart';
import 'package:ista_app/src/modules/consultant/schedule/model_get_schedule.dart';
import 'package:ista_app/src/modules/consultant/schedule/state.dart';

class MentorScheduleLogic extends GetxController {
  final MentorScheduleState state = MentorScheduleState();

  final TextEditingController chargesController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  ///---------------------------------------get-appointment-types
  GetAppointmentTypesModel getAppointmentTypesModel =
      GetAppointmentTypesModel();
  String? selectedScheduleType;
  int? selectedScheduleTypeId;
  List<String> scheduleTypeDropDownList = [];
  updateScheduleTypeDropDownList(String newValue) {
    scheduleTypeDropDownList.add(newValue);
    update();
  }

  emptyScheduleTypeDropDownList() {
    scheduleTypeDropDownList = [];
    update();
  }

  ///---------------------------------------save-&-view-schedule
  List<MentorSchedulesFullModel>? forDisplayScheduleList = [];
  updateForDisplayScheduleList(MentorSchedulesFullModel? newValue) {
    forDisplayScheduleList!.add(newValue!);
    update();
  }

  emptyForDisplayScheduleList() {
    forDisplayScheduleList = [];
    update();
  }

  List<MentorWithoutScheduleFullModel>? forDisplayWithoutScheduleList = [];
  updateForDisplayWithoutScheduleList(
      MentorWithoutScheduleFullModel? newValue) {
    forDisplayWithoutScheduleList!.add(newValue!);
    update();
  }

  emptyForDisplayWithoutScheduleList() {
    forDisplayWithoutScheduleList = [];
    update();
  }

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  List slotsList = [];

  ///---------------------------------------get-available-days
  GetAvailableDaysModel getAvailableDaysModel = GetAvailableDaysModel();
  int? selectedDayForScheduleIndex;
  String? selectedAvailableDay;
  List<String> availableDaysList = [];
  updateAvailableDaysList(String? newValue) {
    availableDaysList.add(newValue!);
    update();
  }

  emptyAvailableDaysList() {
    availableDaysList = [];
    update();
  }

  List<DaySelectorForScheduleModel> dayListForHoliday = [
    DaySelectorForScheduleModel(
        title: 'M', slug: 'monday', isSelected: false, isCompleted: false),
    DaySelectorForScheduleModel(
        title: 'T', slug: 'tuesday', isSelected: false, isCompleted: false),
    DaySelectorForScheduleModel(
        title: 'W', slug: 'wednesday', isSelected: false, isCompleted: false),
    DaySelectorForScheduleModel(
        title: 'T', slug: 'thursday', isSelected: false, isCompleted: false),
    DaySelectorForScheduleModel(
        title: 'F', slug: 'friday', isSelected: false, isCompleted: false),
    DaySelectorForScheduleModel(
        title: 'S', slug: 'saturday', isSelected: false, isCompleted: false),
    DaySelectorForScheduleModel(
        title: 'S', slug: 'sunday', isSelected: false, isCompleted: false),
  ];

  int? shiftIndex = 0;
  updateScheduleShiftIndex(int newValue) {
    shiftIndex = newValue;
    update();
  }

  String? selectedTimeForStart;
  String? selectedTimeForStartForCalculate;
  String? selectedTimeForEnd;
  String? selectedTimeForEndForCalculate;

  ///---------------------------------------get-schedule
  GetMentorScheduleModel getMentorScheduleModel = GetMentorScheduleModel();

  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100;

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
}

class DaySelectorForScheduleModel {
  DaySelectorForScheduleModel(
      {this.title, this.slug, this.isSelected, this.isCompleted});

  String? title;
  String? slug;
  bool? isSelected;
  bool? isCompleted;
}
