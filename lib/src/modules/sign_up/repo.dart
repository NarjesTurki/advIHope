import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/sign_up/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

signUpWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (response['Status'].toString() == 'true') {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: '${LanguageConstant.success.tr}!',
              titleColor: customDialogSuccessColor,
              descriptions: LanguageConstant.letsLogin.tr,
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
                Get.back();
              },
              img: 'assets/Icons/dialog_success.svg',
            );
          });
    } else {
      if (response['errors'].containsKey('email')) {
        Get.find<SignUpLogic>().emailValidator = response['errors']['email'][0];
        Get.find<SignUpLogic>().update();
      }
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
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
