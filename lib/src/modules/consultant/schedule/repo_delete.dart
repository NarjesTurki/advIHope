import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/schedule/repo_get.dart';

deleteMentorScheduleRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'] == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      getMethod(
          context,
          getMentorSchedulesUrl,
          {
            'token': '123',
            'mentor_id':
                Get.find<GeneralController>().storageBox.read('userID'),
          },
          false,
          getMentorScheduleRepo);
      Get.snackbar('${LanguageConstant.deleteSuccessfully.tr}!', '',
          colorText: Colors.black, backgroundColor: Colors.white);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
