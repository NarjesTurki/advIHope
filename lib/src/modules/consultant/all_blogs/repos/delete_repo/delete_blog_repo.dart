import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/all_blogs_logic.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/repos/get_repo/get_blog_repo.dart';

///-------- remove-product-item-API-call
deleteBlogRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<AllBlogsLogic>().updateFormLoaderController(false);
  if (responseCheck) {
    // {"Status":true,"success":1,"msg":"Blog Successfully Deleted"}
    if (response["Status"]) {
      Get.find<AllBlogsLogic>().updateAllConsultantBlogsLoader(false);
      getMethod(
          Get.context!,
          consultantBlogUrl,
          {
            'token': 123,
            'platform': 'app',
            "user_id": Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getAllBlogsRepo);
      Get.snackbar(
          '${LanguageConstant.success.tr}!', response['msg'].toString(),
          colorText: Colors.black, backgroundColor: Colors.white);
      log('--->>Blog Remove From list');
      return;
    }
    Get.snackbar(LanguageConstant.failed.tr, response['msg'].toString(),
        colorText: Colors.black, backgroundColor: Colors.white);
  }
}
