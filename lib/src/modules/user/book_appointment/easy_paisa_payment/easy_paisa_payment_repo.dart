import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

easyPaisaPaymentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      Get.find<GeneralController>().updateFormLoaderController(false);
      // Get.offAllNamed(PageRoutes.bookingConfirmation);
      log('easyPaisaPaymentRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: '${response['msg']}',
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
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
            title: 'failed!'.tr,
            titleColor: customDialogErrorColor,
            descriptions: 'try_again!'.tr,
            text: 'ok'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/dialog_error.svg',
          );
        });
  }
}
