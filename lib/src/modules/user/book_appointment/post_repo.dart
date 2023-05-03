import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/header.dart';
import 'package:ista_app/src/api_services/logic.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/modules/sms/repo.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:ista_app/src/modules/user/book_appointment/model/book_appointment.dart';
import 'package:ista_app/src/modules/user/book_appointment/model/getAppDetail_forReschedule.dart';
import 'package:ista_app/src/modules/user/book_appointment/model/get_payment_methods.dart';
import 'package:ista_app/src/modules/user/book_appointment/wallet_payment/view.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

bookAppointmentFileRepo(File file1, BuildContext context) async {
  dio_instance.FormData formData =
      dio_instance.FormData.fromMap(<String, dynamic>{
    'token': '123',
    'mentee_id': Get.find<GeneralController>().storageBox.read('userID'),
    'mentor_id': Get.find<UserHomeLogic>().selectedConsultantID,
    'payment':
        Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee,
    'payment_id': Get.find<BookAppointmentLogic>().selectedPaymentType,
    'appointment_type_id': Get.find<BookAppointmentLogic>()
        .selectMentorAppointmentType!
        .appointmentType!
        .id,
    'questions': Get.find<BookAppointmentLogic>().questionController.text,
    'type': 'question',
    'appointment_type_string': Get.find<BookAppointmentLogic>()
        .selectMentorAppointmentType!
        .appointmentType!
        .name,
    'book_file': await dio_instance.MultipartFile.fromFile(
      file1.path,
    )
  });
  dio_instance.Dio dio = dio_instance.Dio();
  setCustomHeader(dio, 'Authorization',
      'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  dio_instance.Response response;
  try {
    response = await dio.post(bookAppointmentUrl, data: formData);
    if (response.statusCode == 200) {
      Get.find<BookAppointmentLogic>().bookAppointmentModel =
          BookAppointmentModel.fromJson(response.data);
      Get.find<GeneralController>().updateFormLoaderController(false);
      if (Get.find<BookAppointmentLogic>().bookAppointmentModel.status ==
          true) {
        if (Get.find<BookAppointmentLogic>().selectedPaymentType == 0) {
          Get.find<GeneralController>().updateFormLoaderController(false);
          Get.toNamed(PageRoutes.paymentStripeView);
        } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 1) {
          Get.find<GeneralController>().updateFormLoaderController(false);
          Get.toNamed(PageRoutes.paymentStripeView);
        } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 2) {
          Get.find<GeneralController>().updateFormLoaderController(false);
          Get.toNamed(PageRoutes.walletPaymentScreen);
        } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 3) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: '${LanguageConstant.info.tr}!',
                  titleColor: customDialogInfoColor,
                  descriptions:
                      '${LanguageConstant.thisPaymentMethodIs.tr}\n${LanguageConstant.notAvailableYet.tr}',
                  text: LanguageConstant.ok.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_Info.svg',
                );
              });
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: '${LanguageConstant.info.tr}!',
                  titleColor: customDialogInfoColor,
                  descriptions:
                      '${LanguageConstant.thisPaymentMethodIs.tr}\n${LanguageConstant.notAvailableYet.tr}',
                  text: LanguageConstant.ok.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_Info.svg',
                );
              });
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
  } on dio_instance.DioError catch (e) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    log('putResponseError---->> $e');
  }
}

bookAppointmentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().bookAppointmentModel =
        BookAppointmentModel.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<BookAppointmentLogic>().bookAppointmentModel.status == true) {
      if (Get.find<BookAppointmentLogic>().selectedMethodTitle == 'wallet') {
        Get.to(WalletPaymentView(
            appointmentId: Get.find<BookAppointmentLogic>()
                .bookAppointmentModel
                .data
                ?.appointmentNo));
      } else if (Get.find<BookAppointmentLogic>().paymentName == 'Stripe') {
        Get.toNamed(PageRoutes.paymentStripeView);
      } else if (Get.find<BookAppointmentLogic>().paymentName == 'paypal') {
        Get.toNamed(PageRoutes.paymentStripeView);
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: '${LanguageConstant.info.tr}!',
                titleColor: customDialogInfoColor,
                descriptions:
                    '${LanguageConstant.thisPaymentMethodIs.tr}\n${LanguageConstant.notAvailableYet.tr}',
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_Info.svg',
              );
            });
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

/// Book Reschedule Appointment Repo

bookRescheduleAppointmentWithoutFileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().bookAppointmentModel =
        BookAppointmentModel.fromJson(response);
    if (Get.find<BookAppointmentLogic>().bookAppointmentModel.status == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);

      Get.offAllNamed(PageRoutes.userHome);
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

/// live appointment request accept repo
///
liveRequestRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().bookAppointmentModel =
        BookAppointmentModel.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<BookAppointmentLogic>().bookAppointmentModel.status == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);

      ///---make-notification
      Get.find<GeneralController>().updateNotificationBody(
          'Your Live Appointment Request Accepted',
          '',
          '/appointmentQuestion',
          'mentee/appointment/log',
          null);
      Get.find<GeneralController>().updateUserIdForSendNotification(
          int.parse(Get.find<GeneralController>().notificationMenteeId!));
      // Get.find<GeneralController>().notificationMenteeId = '';
      Get.find<GeneralController>().notificationFee = null;
      Get.find<GeneralController>().update();

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
            'user_id': Get.find<GeneralController>().notificationMenteeId
          },
          true,
          getFcmTokenRepo);
      Get.back();
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

/// Repo for get appointment detail for Reshedule Appointment

getAppDetailForReschedule(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().getAppDetailForReschedule =
        GetAppDetailForReschedule.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<BookAppointmentLogic>().getAppDetailForReschedule.status ==
        true) {
      Get.find<GeneralController>().updateFormLoaderController(false);

      ///---make-notification
      // Get.find<GeneralController>().updateNotificationBody(
      //     'Your Live Appointment Request Accepted',
      //     '',
      //     '/appointmentQuestion',
      //     'mentee/appointment/log',
      //     null);
      // Get.find<GeneralController>().updateUserIdForSendNotification(
      //     int.parse(Get.find<GeneralController>().notificationMenteeId!));
      // // Get.find<GeneralController>().notificationMenteeId = '';
      // Get.find<GeneralController>().notificationFee = null;
      // Get.find<GeneralController>().update();

      ///----send-sms
      // postMethod(
      //     context,
      //     sendSMSUrl,
      //     {
      //       'token': '123',
      //       'phone': Get.find<SmsLogic>().phoneNumber,
      //       'message': Get.find<GeneralController>().notificationTitle,
      //     },
      //     true,
      //     sendSMSRepo);

      ///----fcm-send-start
      // getMethod(
      //     context,
      //     fcmGetUrl,
      //     {
      //       'token': '123',
      //       'user_id': Get.find<GeneralController>().notificationMenteeId
      //     },
      //     true,
      //     getFcmTokenRepo);
      // Get.back();
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

/// repo for get payment methods

getPaymentMethodsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    log("--=-=-=-=-=--=--=-");
    log(response.toString());
    log("--=-=-=-=-=--=--=-");
    Get.find<BookAppointmentLogic>().getPaymentMethods =
        GetPaymentMethods.fromJson(response);
    if (Get.find<BookAppointmentLogic>().getPaymentMethods.success == true) {
      ///--- Payment Methods
      Get.find<BookAppointmentLogic>().getPaymentMethodList = [];

      for (GetPaymentMethodData element
          in Get.find<BookAppointmentLogic>().getPaymentMethods.data ?? []) {
        Get.find<BookAppointmentLogic>().updatePaymentMethodList(element);
      }
      Get.find<BookAppointmentLogic>().updatePaymentMethodList(
          GetPaymentMethodData(
              id: 110,
              imagePath: 'assets/Icons/walletPayment.svg',
              name: 'wallet',
              code: 'wallet',
              isActive: 1,
              isDefault: 0));

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
