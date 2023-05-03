import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/modules/consultant/schedule_info/state.dart';

class ScheduleInfoLogic extends GetxController {
  final ScheduleInfoState state = ScheduleInfoState();

  String? selectedType;
  List<String> typeDropDownList = [];

  updateTypeDropDownList(String newValue) {
    typeDropDownList.add(newValue);
    update();
  }

  emptyTypeDropDownList() {
    typeDropDownList = [];
    update();
  }

  int? appointmentShiftType = 0;

  updateAppointmentShiftType(int? newValue) {
    appointmentShiftType = newValue;
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

  ///

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

class ShiftType {
  ShiftType({this.title, this.image, this.isSelected});

  String? title;
  String? image;
  bool? isSelected;
}

class DaySelectorForScheduleModel {
  DaySelectorForScheduleModel(
      {this.title, this.slug, this.isSelected, this.isCompleted});

  String? title;
  String? slug;
  bool? isSelected;
  bool? isCompleted;
}
