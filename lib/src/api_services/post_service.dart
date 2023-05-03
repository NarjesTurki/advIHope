import 'dart:developer';
import 'dart:io';

import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/header.dart';
import 'package:ista_app/src/api_services/logic.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/main_repo/main_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

postMethod(
    BuildContext context,
    String apiUrl,
    dynamic postData,
    bool addAuthHeader,
    Function executionMethod // for performing functionalities
    ) async {
  dio_instance.Response response;
  dio_instance.Dio dio = dio_instance.Dio();

  setAcceptHeader(dio);
  setContentHeader(dio);

  if (addAuthHeader && Get.find<ApiLogic>().storageBox.hasData('authToken')) {
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  }

  if (apiUrl == fcmService) {
    setCustomHeader(dio, 'Content-Type', 'application/json');
    setCustomHeader(dio, 'Authorization',
        'key=${Get.find<MainLogic>().getConfigCredentialModel.data!.firebase![0].value}');
  }
  log('post method api.... $apiUrl');
  log('postData.... $postData');
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      Get.find<ApiLogic>().changeInternetCheckerState(true);
      try {
        response = await dio.post(apiUrl, data: postData);

        if (response.statusCode == 200) {
          log('response  ....  ${response.data}');
          executionMethod(context, true, response.data);

          return;
        }
        log('response   ....  $response');
        executionMethod(context, false, {'status': null});
      } on dio_instance.DioError catch (e) {
        log('Dio Error  ....  ${e.response}');
        executionMethod(context, false, {'status': null});

        if (e.response != null) {
        } else {}
      }
    }
  } on SocketException catch (_) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.failed.tr,
            titleColor: customDialogErrorColor,
            descriptions: '${LanguageConstant.internetNotConnected.tr}!',
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
    Get.find<ApiLogic>().changeInternetCheckerState(false);
  }
}
