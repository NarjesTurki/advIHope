import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/inapp_web/view.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/modules/sms/repo.dart';
import 'package:ista_app/src/modules/user/appointment_detail/logic.dart';
import 'package:ista_app/src/modules/user/appointment_detail/payment/model_stripe_payment.dart';
import 'package:ista_app/src/modules/user/my_appointment/get_repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

stripePaymentRepoForLater(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response.containsKey('original')) {
      Get.find<AppointmentDetailLogic>().modelStripePayment =
          ModelStripePayment.fromJson(response);

      Get.find<GeneralController>().updateFormLoaderController(false);

      if (Get.find<AppointmentDetailLogic>()
              .modelStripePayment
              .original!
              .status ==
          true) {
        Get.find<AppointmentDetailLogic>().myWidth = 0;
        Get.find<AppointmentDetailLogic>().update();

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
              'user_id': Get.find<AppointmentDetailLogic>()
                  .selectedAppointmentData
                  .mentor!
                  .id
            },
            true,
            getFcmTokenRepo);

        getMethod(
            context,
            getUserAllAppointmentsURL,
            {
              'token': '123',
              'mentee_id':
                  Get.find<GeneralController>().storageBox.read('userID')
            },
            true,
            getUserAllAppointmentsRepo);
        Get.back();
        Get.back();
      } else {
        Get.find<AppointmentDetailLogic>().myWidth = 0;
        Get.find<AppointmentDetailLogic>().update();
        Get.find<GeneralController>().updateFormLoaderController(false);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: '${LanguageConstant.failed.tr}!',
                titleColor: customDialogErrorColor,
                descriptions: '${LanguageConstant.tryAgain.tr}!',
                text: LanguageConstant.ok,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

      Get.find<AppointmentDetailLogic>().myWidth = 0;
      Get.find<AppointmentDetailLogic>().update();
      if (response['authorization_url'] != null) {
        Get.find<GeneralController>().inAppWebService =
            response['authorization_url'];
        Get.off(const InAppWebPage());
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: '${LanguageConstant.failed.tr}!',
                titleColor: customDialogErrorColor,
                descriptions: '${response['data']['message']}',
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
    }
  } else {
    Get.find<GeneralController>().updateFormLoaderController(false);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: '${LanguageConstant.failed.tr}!',
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
