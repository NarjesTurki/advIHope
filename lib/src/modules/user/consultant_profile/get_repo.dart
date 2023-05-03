import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/consultant_profile/get_mentor_profile_for_mentee_model.dart';
import 'package:ista_app/src/modules/user/consultant_profile/logic.dart';
import 'package:ista_app/src/modules/user/consultant_profile/model_consultant_profile.dart';

getConsultantProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<ConsultantProfileLogic>().consultantProfileModel =
        ConsultantProfileModel.fromJson(response);
    Get.find<ConsultantProfileLogic>().update();
    if (Get.find<ConsultantProfileLogic>()
            .consultantProfileModel
            .status
            .toString() ==
        'true') {
      Get.find<ConsultantProfileLogic>().appointmentTypes.clear();
      for (var element in Get.find<ConsultantProfileLogic>()
          .consultantProfileModel
          .data!
          .userDetail!
          .scheduleTypes!) {
        Get.find<ConsultantProfileLogic>().appointmentTypes.add(element);
      }
      for (var element in Get.find<ConsultantProfileLogic>()
          .consultantProfileModel
          .data!
          .userDetail!
          .withoutScheduleTypes!) {
        Get.find<ConsultantProfileLogic>().appointmentTypes.add(element);
      }
      Get.find<ConsultantProfileLogic>().updateConsultantProfileLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<ConsultantProfileLogic>().updateConsultantProfileLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<ConsultantProfileLogic>().updateConsultantProfileLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getMentorProfileForMenteeRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<ConsultantProfileLogic>().getMentorProfileForMenteeModel =
        GetMentorProfileForMenteeModel.fromJson(response);
    if (Get.find<ConsultantProfileLogic>()
            .getMentorProfileForMenteeModel
            .status ==
        true) {
      Get.find<ConsultantProfileLogic>().updateLoaderForViewProfile(false);
    } else {
      Get.find<ConsultantProfileLogic>().updateLoaderForViewProfile(false);
    }
  } else if (!responseCheck) {
    Get.find<ConsultantProfileLogic>().updateLoaderForViewProfile(false);
  }
}
