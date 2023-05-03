import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/logic.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_post_account_info.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_post_general_info.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_post_skill_info.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

mentorGeneralInfo2Repo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().generalInfoPostModel =
        GeneralInfoPostModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().generalInfoPostModel.status == true) {
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
          .isSelected = false;
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
          .isCompleted = true;
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex! + 1]
          .isSelected = true;
      Get.find<CreateProfileLogic>().updateStepperIndex(1);
      Get.snackbar('${LanguageConstant.profileUpdatedSuccessfully.tr}!', '',
          colorText: Colors.black, backgroundColor: Colors.white);
      Get.find<GeneralController>().updateFormLoaderController(false);
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

mentorSkillInfoRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().skillInfoPostModel =
        SkillInfoPostModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().skillInfoPostModel.status == true) {
      Get.snackbar('${LanguageConstant.skillAddedSuccessfully.tr}!', '',
          colorText: Colors.black, backgroundColor: Colors.white);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

mentorAccountInfoRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().accountInfoPostModel =
        AccountInfoPostModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().accountInfoPostModel.status == true) {
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
          .isSelected = false;
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
          .isCompleted = true;
      postMethod(
          context,
          mentorProfileStatusUrl,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          mentorProfileStatusChangeRepo);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

mentorProfileStatusChangeRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      Get.find<CreateProfileLogic>().showConfirmation = true;
      Get.find<CreateProfileLogic>().update();
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
