import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/modules/consultant/dashboard/logic.dart';
import 'package:ista_app/src/modules/consultant/dashboard/model_approval_check.dart';

getMentorApprovalRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.put(DashboardLogic());
  if (responseCheck) {
    Get.find<DashboardLogic>().mentorApprovalCheckModel =
        MentorApprovalCheckModel.fromJson(response);
    if (Get.find<DashboardLogic>().mentorApprovalCheckModel.status == true) {
      if (Get.find<DashboardLogic>()
              .mentorApprovalCheckModel
              .data!
              .mentor!
              .isProfileCompleted ==
          0) {
        Get.offAllNamed(PageRoutes.createConsultantProfile);
      } else {
        if (Get.find<DashboardLogic>()
                .mentorApprovalCheckModel
                .data!
                .mentor!
                .status ==
            1) {
          Get.find<DashboardLogic>().updateApprovalCheckerApiStopLoader(true);
        }
        Get.find<DashboardLogic>().updateApprovalCheckerApiLoader(false);
      }
    } else {
      Get.find<DashboardLogic>().updateApprovalCheckerApiLoader(false);
    }
  } else if (!responseCheck) {
    Get.find<DashboardLogic>().updateApprovalCheckerApiLoader(false);
  }
}
