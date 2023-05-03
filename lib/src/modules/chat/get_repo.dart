import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/chat/fetch_messages_model.dart';
import 'package:ista_app/src/modules/chat/logic.dart';

fetchMessagesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<ChatLogic>().fetchMessagesModel =
        FetchMessagesModel.fromJson(response);
    if (Get.find<ChatLogic>().fetchMessagesModel.status == true) {
      Get.find<ChatLogic>().emptyMessageList();
      for (var element
          in Get.find<ChatLogic>().fetchMessagesModel.data!.messages!) {
        Get.find<ChatLogic>().updateMessageList(element);
      }
      Get.find<ChatLogic>().updateGetMessagesLoader(false);
      Future.delayed(const Duration(seconds: 1)).whenComplete(() =>
          Get.find<ChatLogic>().scrollController!.animateTo(
              Get.find<ChatLogic>().scrollController!.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 500)));
    } else {
      Get.find<ChatLogic>().updateGetMessagesLoader(false);
    }
  } else if (!responseCheck) {
    Get.find<ChatLogic>().updateGetMessagesLoader(false);
  }
}
