import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/inapp_web/view.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/modules/sms/repo.dart';
import 'package:ista_app/src/modules/user/appointment_detail/payment/model_stripe_payment.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

stripePaymentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response.containsKey('original')) {
      Get.find<BookAppointmentLogic>().modelStripePayment =
          ModelStripePayment.fromJson(response);
      Get.find<GeneralController>().updateFormLoaderController(false);
      if (Get.find<BookAppointmentLogic>()
              .modelStripePayment
              .original!
              .status ==
          true) {
        /// Notification
        ///---make-notification
        Get.find<GeneralController>().updateNotificationBody(
            'New Appointment For You',
            '',
            null,
            'mentee/appointment/log',
            null);

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
              'user_id': Get.find<UserHomeLogic>().selectedConsultantID
            },
            true,
            getFcmTokenRepo);
        Get.find<BookAppointmentLogic>().myWidth = 0;
        Get.find<BookAppointmentLogic>().update();
        Get.offAllNamed(PageRoutes.appointmentConfirmation);
      } else {
        Get.find<BookAppointmentLogic>().myWidth = 0;
        Get.find<BookAppointmentLogic>().update();
        Get.find<GeneralController>().updateFormLoaderController(false);
        showDialog(
            context: context,
            barrierDismissible: false,
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
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

      Get.find<BookAppointmentLogic>().myWidth = 0;
      Get.find<BookAppointmentLogic>().update();
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
