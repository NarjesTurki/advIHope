import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/inapp_web/view.dart';
import 'package:ista_app/src/modules/user/appointment_detail/payment/model_stripe_payment.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/modules/wallet/logic.dart';
import 'package:ista_app/src/modules/wallet/repo_get.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

stripePaymentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response.containsKey('original')) {
      Get.find<WalletLogic>().modelStripePayment =
          ModelStripePayment.fromJson(response);

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

      if (Get.find<WalletLogic>().modelStripePayment.original!.status == true) {
        Get.find<WalletLogic>().myWidth = 0;
        Get.find<WalletLogic>().update();

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
                  Get.back();
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_success.svg',
              );
            });
      } else {
        Get.find<WalletLogic>().myWidth = 0;
        Get.find<WalletLogic>().update();
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
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

      Get.find<WalletLogic>().myWidth = 0;
      Get.find<WalletLogic>().update();
      if (response['authorization_url'] != null) {
        Get.find<GeneralController>().inAppWebService =
            response['authorization_url'];
        Get.off(const InAppWebPage());
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: LanguageConstant.failed.tr,
                titleColor: customDialogErrorColor,
                descriptions: '${response['data']['message']}',
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
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
            img: 'assets/Icons/dialog_error.svg',
          );
        });
  }
}
