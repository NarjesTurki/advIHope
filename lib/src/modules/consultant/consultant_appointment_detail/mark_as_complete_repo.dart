import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/get_repo.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/model_mark_as_complete.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/modules/sms/repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

import '../../../controller/general_controller.dart';

markAsCompleteRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<ConsultantAppointmentDetailLogic>().modelMarkAsComplete =
        ModelMarkAsComplete.fromJson(response);

    Get.find<GeneralController>().updateFormLoaderController(false);

    if (Get.find<ConsultantAppointmentDetailLogic>()
            .modelMarkAsComplete
            .status ==
        true) {
      getMethod(
          context,
          getConsultantAllAppointmentsURL,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getConsultantAllAppointmentsRepo);

      ///----send-sms
      postMethod(
          context,
          sendSMSUrl,
          {
            'token': '123',
            'phone': Get.find<SmsLogic>().phoneNumber,
            'message': Get.find<GeneralController>().notificationTitle,
          },
          true,
          sendSMSRepo);

      ///----fcm-send-start
      getMethod(
          context,
          fcmGetUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().userIdForSendNotification
          },
          true,
          getFcmTokenRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar(LanguageConstant.appointmentCompletedSuccessfully.tr, '',
          colorText: Colors.black, backgroundColor: Colors.white);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: customDialogErrorColor,
              descriptions: response['msg'],
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.failed.tr,
            titleColor: customDialogErrorColor,
            descriptions: '${LanguageConstant.tryAgain.tr}!',
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
  }
}
