import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/schedule/logic.dart';
import 'package:ista_app/src/modules/consultant/schedule/model_get_appointment_types.dart';
import 'package:ista_app/src/modules/consultant/schedule/model_get_available_days.dart';
import 'package:ista_app/src/modules/consultant/schedule/model_get_schedule.dart';

getAppointmentTypesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MentorScheduleLogic>().getAppointmentTypesModel =
        GetAppointmentTypesModel.fromJson(response);
    if (Get.find<MentorScheduleLogic>().getAppointmentTypesModel.status ==
        true) {
      ///---appointment-types
      Get.find<MentorScheduleLogic>().emptyScheduleTypeDropDownList();
      for (var element in Get.find<MentorScheduleLogic>()
          .getAppointmentTypesModel
          .data!
          .appointmenttype!) {
        if (element.name!.toUpperCase() != '') {
          Get.find<MentorScheduleLogic>()
              .updateScheduleTypeDropDownList(element.name!.toUpperCase());
        }
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getAvailableDaysRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MentorScheduleLogic>().getAvailableDaysModel =
        GetAvailableDaysModel.fromJson(response);
    if (Get.find<MentorScheduleLogic>().getAvailableDaysModel.status == true) {
      ///---available-days-list
      Get.find<MentorScheduleLogic>().emptyAvailableDaysList();
      for (var element in Get.find<MentorScheduleLogic>()
          .getAvailableDaysModel
          .data!
          .mentorSchedules!) {
        if (element.isHoliday == 0) {
          Get.find<MentorScheduleLogic>()
              .updateAvailableDaysList(element.day!.toUpperCase());
          Get.find<MentorScheduleLogic>()
              .dayListForHoliday[Get.find<MentorScheduleLogic>()
                  .getAvailableDaysModel
                  .data!
                  .mentorSchedules!
                  .indexOf(element)]
              .isSelected = false;
        } else {
          Get.find<MentorScheduleLogic>()
              .dayListForHoliday[Get.find<MentorScheduleLogic>()
                  .getAvailableDaysModel
                  .data!
                  .mentorSchedules!
                  .indexOf(element)]
              .isSelected = true;
        }
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getMentorScheduleRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MentorScheduleLogic>().getMentorScheduleModel =
        GetMentorScheduleModel.fromJson(response);
    if (Get.find<MentorScheduleLogic>().getMentorScheduleModel.status == true) {
      Get.find<MentorScheduleLogic>().emptyForDisplayWithoutScheduleList();
      for (var element in Get.find<MentorScheduleLogic>()
          .getMentorScheduleModel
          .data!
          .mentorWithoutSchedule!) {
        Get.find<MentorScheduleLogic>()
            .updateForDisplayWithoutScheduleList(element);
      }

      Get.find<MentorScheduleLogic>().emptyForDisplayScheduleList();
      for (var element in Get.find<MentorScheduleLogic>()
          .getMentorScheduleModel
          .data!
          .mentorSchedules!) {
        if (element.scheduleSlots!.isNotEmpty) {
          Get.find<MentorScheduleLogic>().updateForDisplayScheduleList(element);
        }
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
