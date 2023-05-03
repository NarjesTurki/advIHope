import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/chat/logic.dart';

sendMessagesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    ///---make-notification
    Get.find<GeneralController>().updateNotificationBody('New Message',
        Get.find<ChatLogic>().messageController.text, null, null, null);
    Get.find<ChatLogic>().messageController.clear();
    if (response['Status'].toString() == 'true') {
      Get.find<ChatLogic>().updateGetMessagesLoader(false);

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
    } else {
      Get.find<ChatLogic>().updateGetMessagesLoader(false);
    }
  } else if (!responseCheck) {
    Get.find<ChatLogic>().updateGetMessagesLoader(false);
  }
}
