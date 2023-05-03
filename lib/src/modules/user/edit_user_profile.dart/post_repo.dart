import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/header.dart';
import 'package:ista_app/src/api_services/logic.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/logic.dart';
import 'package:ista_app/src/modules/user/home/get_repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:dio/dio.dart' as dio_instance;

menteeUpdateProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getMenteeProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: '${LanguageConstant.success.tr}!',
              titleColor: customDialogSuccessColor,
              descriptions: LanguageConstant.profileUpdatedSuccessfully.tr,
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
                Get.back();
              },
              img: 'assets/Icons/dialog_success.svg',
            );
          });
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      showDialog(
          context: Get.context!,
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
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    showDialog(
        context: Get.context!,
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
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

menteeUpdateProfileImageRepo(File? file1) async {
  dio_instance.FormData formData =
      dio_instance.FormData.fromMap(<String, dynamic>{
    'token': '123',
    'user_id': Get.find<GeneralController>().storageBox.read('userID'),
    'first_name': Get.find<EditUserProfileLogic>().firstNameController.text,
    'last_name': Get.find<EditUserProfileLogic>().lastNameController.text,
    'gender': Get.find<EditUserProfileLogic>().selectedGender,
    'country': Get.find<EditUserProfileLogic>()
        .menteeProfileGenericDataModel
        .data!
        .countries![Get.find<EditUserProfileLogic>()
            .countryDropDownList
            .indexOf(Get.find<EditUserProfileLogic>().selectedCountry!)]
        .id,
    'city': Get.find<EditUserProfileLogic>().selectedCity,
    'image': await dio_instance.MultipartFile.fromFile(
      file1!.path,
    )
  });
  dio_instance.Dio dio = dio_instance.Dio();
  setCustomHeader(dio, 'Authorization',
      'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  dio_instance.Response response;
  try {
    response = await dio.post(updateMenteeProfileUrl, data: formData);

    if (response.statusCode == 200) {
      if (response.data['Status'].toString() == 'true') {
        getMethod(
            Get.context!,
            getMenteeProfileUrl,
            {
              'token': '123',
              'user_id': Get.find<GeneralController>().storageBox.read('userID')
            },
            true,
            getUserProfileRepo);
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: '${LanguageConstant.success.tr}!',
                titleColor: customDialogSuccessColor,
                descriptions: LanguageConstant.profileUpdatedSuccessfully.tr,
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                  Get.back();
                },
                img: 'assets/Icons/dialog_success.svg',
              );
            });
        Get.find<GeneralController>().updateFormLoaderController(false);
      } else {
        showDialog(
            context: Get.context!,
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
        Get.find<GeneralController>().updateFormLoaderController(false);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: Get.context!,
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
  } on dio_instance.DioError catch (e) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: Get.context!,
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
    log('Exception..${e.response}');
  }
}

getProfileVisibilityRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      Get.find<EditUserProfileLogic>().updateProfileHiddenSwitch(
          Get.find<EditUserProfileLogic>().profileHiddenSwitch);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<EditUserProfileLogic>().updateProfileHiddenSwitch(
          !Get.find<EditUserProfileLogic>().profileHiddenSwitch!);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
