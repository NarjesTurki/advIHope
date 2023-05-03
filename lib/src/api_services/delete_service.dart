import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../multi_language/language_constants.dart';
import '../controller/general_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_dialog.dart';
import 'header.dart';
import 'logic.dart';

deleteMethod(BuildContext context, String apiUrl, dynamic queryData,
    bool addAuthHeader, Function executionMethod
    // for performing functionalities
    ) async {
  dio_instance.Response response;
  dio_instance.Dio dio = dio_instance.Dio();

  setAcceptHeader(dio);
  setContentHeader(dio);

  if (addAuthHeader && Get.find<ApiLogic>().storageBox.hasData('authToken')) {
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  }

  log('delete method api.... $apiUrl');
  log('queryData.... $queryData');
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      Get.find<ApiLogic>().changeInternetCheckerState(true);
      try {
        response = await dio.delete(apiUrl, queryParameters: queryData);

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
