import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/all_blogs_logic.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/models/consultant_blogs_model.dart';

getAllBlogsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<AllBlogsLogic>().updateAllConsultantBlogsLoader(true);
  if (responseCheck) {
    print(response);
    Get.find<AllBlogsLogic>().consultantBlogsModel =
        ConsultantBlogsModel.fromJson(response);
  }
}
