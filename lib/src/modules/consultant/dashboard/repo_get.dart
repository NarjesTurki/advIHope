import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/dashboard/get_ratings_model.dart';
import 'package:ista_app/src/modules/consultant/dashboard/logic.dart';
import 'package:ista_app/src/modules/consultant/dashboard/model_get_appointment_count_mentor.dart';
import 'package:ista_app/src/modules/consultant/dashboard/model_get_today_appointment.dart';

getMentorTodayAppointmentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<DashboardLogic>().getTodayAppointmentModel =
        GetTodayAppointmentModel.fromJson(response);
    if (Get.find<DashboardLogic>().getTodayAppointmentModel.status == true) {
      Get.find<DashboardLogic>().emptyGetTodayAppointmentList();
      if (Get.find<DashboardLogic>()
          .getTodayAppointmentModel
          .data!
          .results!
          .isNotEmpty) {
        for (var element in Get.find<DashboardLogic>()
            .getTodayAppointmentModel
            .data!
            .results!) {
          Get.find<DashboardLogic>().updateGetTodayAppointmentList(element);
        }
        Get.find<DashboardLogic>().updateGetTodayAppointmentLoader(false);

        Get.find<DashboardLogic>().updateRefreshController();
      } else {
        Get.find<DashboardLogic>().updateGetTodayAppointmentLoader(false);
        Get.find<DashboardLogic>().updateRefreshController();
      }
    } else {
      Get.find<DashboardLogic>().updateGetTodayAppointmentLoader(false);
      Get.find<DashboardLogic>().updateRefreshController();
    }
  } else if (!responseCheck) {
    Get.find<DashboardLogic>().updateGetTodayAppointmentLoader(false);
    Get.find<DashboardLogic>().updateRefreshController();
  }
}

getAppointmentCountMentorRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<DashboardLogic>().getAppointmentCountMentorModel =
        GetAppointmentCountMentorModel.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<DashboardLogic>().getAppointmentCountMentorModel.status ==
        true) {
    } else {}
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getRatingMentorRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<DashboardLogic>().getRatingsModel =
        GetRatingsModel.fromJson(response);
    Get.find<DashboardLogic>().updateRatingLoader(false);
    Get.find<DashboardLogic>().updateRefreshController();
    if (Get.find<DashboardLogic>().getRatingsModel.status == true) {
    } else {}
  } else if (!responseCheck) {
    Get.find<DashboardLogic>().updateRefreshController();
    Get.find<DashboardLogic>().updateRatingLoader(false);
  }
}
