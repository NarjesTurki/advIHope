import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/get_agora_token_model.dart';
import 'package:ista_app/src/modules/agora_call/get_fcm_token_model.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';

getAgoraTokenRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getAgoraTokenModel =
        GetAgoraTokenModel.fromJson(response);
    if (Get.find<GeneralController>().getAgoraTokenModel.status == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.find<GeneralController>().updateCallerType(1);
      if (Get.find<GeneralController>().goForCall!) {
        Get.find<GeneralController>().updateTokenForCall(
            Get.find<GeneralController>().getAgoraTokenModel.data!.token);

        ///---make-notification
        Get.find<GeneralController>().updateNotificationBody(
            'CALLING.....',
            'Your ${Get.find<GeneralController>().storageBox.read('userRole')} is calling you',
            '/videoCall',
            '/mentee/appointment-log-detail/${Get.find<GeneralController>().appointmentIdForSendNotification}'
                '?auth_tocken=${Get.find<GeneralController>().getAgoraTokenModel.data!.token}'
                '&channel_name=${Get.find<GeneralController>().channelForCall}',
            'ring_ring');

        getMethod(
            context,
            fcmGetUrl,
            {
              'token': '123',
              'user_id': Get.find<GeneralController>().userIdForSendNotification
            },
            true,
            getFcmTokenRepo);

        Get.offNamed(PageRoutes.videoCall);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getAgoraTokenForAudioRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getAgoraTokenModel =
        GetAgoraTokenModel.fromJson(response);
    if (Get.find<GeneralController>().getAgoraTokenModel.status == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.find<GeneralController>().updateCallerType(1);
      if (Get.find<GeneralController>().goForCall!) {
        Get.find<GeneralController>().updateTokenForCall(
            Get.find<GeneralController>().getAgoraTokenModel.data!.token);

        ///---make-notification
        Get.find<GeneralController>().updateNotificationBody(
            'CALLING.....',
            'Your ${Get.find<GeneralController>().storageBox.read('userRole')} is calling you',
            '/audioCall',
            '/mentee/appointment-log-detail/${Get.find<GeneralController>().appointmentIdForSendNotification}'
                '?auth_tocken=${Get.find<GeneralController>().getAgoraTokenModel.data!.token}'
                '&channel_name=${Get.find<GeneralController>().channelForCall}',
            'ring_ring');

        getMethod(
            context,
            fcmGetUrl,
            {
              'token': '123',
              'user_id': Get.find<GeneralController>().userIdForSendNotification
            },
            true,
            getFcmTokenRepo);

        Get.offNamed(PageRoutes.audioCall);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

updateFcmTokenRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {}
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getFcmTokenRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getFcmTokenModel =
        GetFcmTokenModel.fromJson(response);
    if (Get.find<GeneralController>().getFcmTokenModel.status == true) {
      for (var element
          in Get.find<GeneralController>().getFcmTokenModel.data!.tokens!) {
        // log('testtting ${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}     ${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.appointmentTypeId}');
        postMethod(
            context,
            fcmService,
            {
              'notification': <String, dynamic>{
                'body': Get.find<GeneralController>().notificationBody,
                'title': Get.find<GeneralController>().notificationTitle,
                'sound': Get.find<GeneralController>().sound,
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "data": Get.find<GeneralController>().notificationRouteWeb,
              },
              'priority': 'high',
              'data': Get.find<GeneralController>().channelForCall != null
                  ? <String, dynamic>{
                      'sound': Get.find<GeneralController>().sound,
                      'routeApp':
                          Get.find<GeneralController>().notificationRouteApp,
                      'channel': Get.find<GeneralController>().channelForCall,
                      'fee': '',
                      'mentee_id': '',
                      'channel_token':
                          Get.find<GeneralController>().tokenForCall,
                    }
                  : <String, dynamic>{
                      'sound': Get.find<GeneralController>().sound,
                      'routeApp':
                          Get.find<GeneralController>().notificationRouteApp,
                      'channel': '',
                      'fee': Get.find<BookAppointmentLogic>()
                                  .selectMentorAppointmentType!
                                  .appointmentTypeId ==
                              6
                          ? Get.find<BookAppointmentLogic>()
                              .selectMentorAppointmentType!
                              .fee
                          : '',
                      'mentee_id': Get.find<BookAppointmentLogic>()
                                  .selectMentorAppointmentType!
                                  .appointmentTypeId ==
                              6
                          ? Get.find<GeneralController>()
                              .storageBox
                              .read('userID')
                          : '',
                      'channel_token': '',
                    },
              'to': element.deviceKey
            },
            false,
            method1);
      }
    } else {}
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

method1(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (response['success'].toString() == '1') {}
}
