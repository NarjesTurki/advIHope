import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';

import 'more_appointment_consultant_model.dart';

getConsultantAllAppointmentsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<ConsultantAppointmentLogic>().updateRefreshController();
  Get.find<ConsultantAppointmentLogic>().updateGetUserAppointmentLoader(false);

  Get.find<GeneralController>().updateFormLoaderController(false);
  if (responseCheck) {
    Get.find<ConsultantAppointmentLogic>().getConsultantAppointmentModel =
        GetConsultantAppointmentModel.fromJson(response);
    // Get.find<ConsultantAppointmentLogic>().update();
    // if (Get.find<ConsultantAppointmentLogic>().getConsultantAppointmentModel.status??false) {}
  }
}

getConsultantAllAppointmentsMoreRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<ConsultantAppointmentLogic>().updateRefreshController();
  Get.find<ConsultantAppointmentLogic>()
      .updateGetUserAppointmentMoreLoader(false);
  Get.find<GeneralController>().updateFormLoaderController(false);

  if (responseCheck) {
    Get.find<ConsultantAppointmentLogic>().moreConsultantAppointmentModel =
        MoreConsultantAppointmentModel.fromJson(response);

    if ((Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .status ??
            false) &&
        (Get.find<ConsultantAppointmentLogic>()
                    .moreConsultantAppointmentModel
                    .data
                    ?.appointments
                    ?.data ??
                [])
            .isNotEmpty) {
      if (Get.find<ConsultantAppointmentLogic>()
              .moreConsultantAppointmentModel
              .data!
              .appointments!
              .data![0]
              .appointmentStatus ==
          0) {
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .pendingAppointments!
                .currentPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .currentPage;
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .pendingAppointments!
                .lastPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .lastPage;
        for (var element in Get.find<ConsultantAppointmentLogic>()
            .moreConsultantAppointmentModel
            .data!
            .appointments!
            .data!) {
          Get.find<ConsultantAppointmentLogic>()
              .getConsultantAppointmentModel
              .data!
              .pendingAppointments!
              .data!
              .add(element);
        }
        return;
      }
      if (Get.find<ConsultantAppointmentLogic>()
              .moreConsultantAppointmentModel
              .data!
              .appointments!
              .data![0]
              .appointmentStatus ==
          1) {
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .acceptedAppointments!
                .currentPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .currentPage;
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .acceptedAppointments!
                .lastPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .lastPage;
        for (var element in Get.find<ConsultantAppointmentLogic>()
            .moreConsultantAppointmentModel
            .data!
            .appointments!
            .data!) {
          Get.find<ConsultantAppointmentLogic>()
              .getConsultantAppointmentModel
              .data!
              .acceptedAppointments!
              .data!
              .add(element);
        }
        return;
      }
      if (Get.find<ConsultantAppointmentLogic>()
              .moreConsultantAppointmentModel
              .data!
              .appointments!
              .data![0]
              .appointmentStatus ==
          2) {
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .completedAppointments!
                .currentPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .currentPage;
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .completedAppointments!
                .lastPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .lastPage;
        for (var element in Get.find<ConsultantAppointmentLogic>()
            .moreConsultantAppointmentModel
            .data!
            .appointments!
            .data!) {
          Get.find<ConsultantAppointmentLogic>()
              .getConsultantAppointmentModel
              .data!
              .completedAppointments!
              .data!
              .add(element);
        }
        return;
      }
      if (Get.find<ConsultantAppointmentLogic>()
              .moreConsultantAppointmentModel
              .data!
              .appointments!
              .data![0]
              .appointmentStatus ==
          3) {
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .cancelledAppointments!
                .currentPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .currentPage;
        Get.find<ConsultantAppointmentLogic>()
                .getConsultantAppointmentModel
                .data!
                .cancelledAppointments!
                .lastPage =
            Get.find<ConsultantAppointmentLogic>()
                .moreConsultantAppointmentModel
                .data!
                .appointments!
                .lastPage;
        for (var element in Get.find<ConsultantAppointmentLogic>()
            .moreConsultantAppointmentModel
            .data!
            .appointments!
            .data!) {
          Get.find<ConsultantAppointmentLogic>()
              .getConsultantAppointmentModel
              .data!
              .cancelledAppointments!
              .data!
              .add(element);
        }
        return;
      }
    }
  }
}
