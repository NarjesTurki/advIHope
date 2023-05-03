import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/login/logic.dart';
import 'package:ista_app/src/modules/login/login_otp_model.dart';
import 'package:ista_app/src/modules/login/model.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

loginWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<LoginLogic>().loginModel = LoginModel.fromJson(response);
    if (Get.find<LoginLogic>().loginModel.status.toString() == 'true') {
      Get.find<GeneralController>()
          .storageBox
          .write('authToken', Get.find<LoginLogic>().loginModel.accessToken);
      Get.find<GeneralController>()
          .storageBox
          .write('userID', Get.find<LoginLogic>().loginModel.data!.user!.id);

      if (Get.find<LoginLogic>().loginModel.data!.role == 'Mentee') {
        Get.find<GeneralController>()
            .storageBox
            .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);

        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.offAllNamed(PageRoutes.userHome);
      } else {
        Get.find<GeneralController>()
            .storageBox
            .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);

        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.offAllNamed(PageRoutes.consultantDashboard);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: customDialogErrorColor,
              descriptions: '${Get.find<LoginLogic>().loginModel.msg}',
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
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

loginSignupOtpRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    print(response);
    Get.find<LoginLogic>().loginOtpModel = LoginOtpModel.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);

    if (Get.find<LoginLogic>().loginOtpModel.status == true) {
      ///--------------------------------------------------------------------------------------------
      // Get.find<GeneralController>().storageBox.write(
      //     'userId', Get.find<LoginLogic>().loginModel.data!.userDetail![0].id);
      // Get.find<GeneralController>().storageBox.write(
      //     'authToken', Get.find<LoginLogic>().loginModel.data!.accessToken);
      //
      // if (Get.find<LoginLogic>().loginModel.data!.role == 'Mentee') {
      //   Get.find<GeneralController>()
      //       .storageBox
      //       .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);
      //
      //   Get.offAllNamed(PageRoutes.bottomNavBar);
      //   log('loginSignupRepoMentee ------>> ${Get.find<LoginLogic>().loginModel.data}');
      // } else {
      //   Get.find<GeneralController>()
      //       .storageBox
      //       .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);
      //
      //   Get.offAllNamed(PageRoutes.mentorBottomNavBar);
      //   log('loginSignupRepoMentor ------>> ${Get.find<LoginLogic>().loginModel.data}');
      // }

      ///--------------------------------------------------------------------------------------------
      Get.find<LoginLogic>()
          .otpFunction(Get.find<LoginLogic>().loginPhoneNumber, context);
      Get.find<LoginLogic>().loginTimerAnimationController!.reverse(
          from: Get.find<LoginLogic>().loginTimerAnimationController!.value ==
                  0.0
              ? 1.0
              : Get.find<LoginLogic>().loginTimerAnimationController!.value);
      Get.find<LoginLogic>().updateOtpSendCheckerLogin(true);

      log('loginSignupRepo ------>> ${Get.find<LoginLogic>().loginOtpModel.data}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: '${Get.find<LoginLogic>().loginOtpModel.msg}',
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
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
    log('Exception........................');
  }
}
