import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/wallet/repo_get.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

depositTransactionJazzcashRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getWalletBalanceUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletBalanceRepo);
      getMethod(
          context,
          getWalletTransactionUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletTransactionRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.back();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: '${LanguageConstant.success.tr}!',
              titleColor: customDialogSuccessColor,
              descriptions: '${LanguageConstant.amountAddedSuccessfully.tr}!',
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_success.svg',
            );
          });
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: customDialogErrorColor,
              descriptions: '${response['msg']}',
              text: LanguageConstant.ok.tr,
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
            title: LanguageConstant.failed.tr,
            titleColor: customDialogErrorColor,
            descriptions: '${LanguageConstant.tryAgain.tr}!',
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/dialog_error.svg',
          );
        });
  }
}

withdrawTransactionRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getWalletBalanceUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletBalanceRepo);
      getMethod(
          context,
          getWalletTransactionUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletTransactionRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar(
          '${LanguageConstant.success.tr}!', response['msg'].toString(),
          colorText: Colors.black, backgroundColor: Colors.white);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar(LanguageConstant.failed.tr, response['msg'].toString(),
          colorText: Colors.black, backgroundColor: Colors.white);
    }
  } else {
    Get.find<GeneralController>().updateFormLoaderController(false);
    Get.snackbar(LanguageConstant.failed.tr, '${LanguageConstant.tryAgain.tr}!',
        colorText: Colors.black, backgroundColor: Colors.white);
  }
}
