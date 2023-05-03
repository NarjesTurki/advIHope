import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

postBlogRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<CreateBlogLogic>().updateFormLoaderController(false);
  if (responseCheck) {
    print(response);
    if (response["Status"]) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.success.tr,
              titleColor: customDialogSuccessColor,
              descriptions: response['msg'].toString(),
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Get.back();
                Get.back();
                Get.back();
              },
              img: 'assets/Icons/dialog_success.svg',
            );
          });
    }
  }
}
