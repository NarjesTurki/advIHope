import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/home/get_repo.dart';

changeMentorOnlineStatusRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getUserProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
    } else {}
  } else if (!responseCheck) {}
}

goLiveRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getUserProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

inActiveLiveRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getUserProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

logOutRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
    } else {}
  } else if (!responseCheck) {}
}
