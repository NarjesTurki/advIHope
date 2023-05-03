import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/user/appointment_detail/logic.dart';
import 'package:ista_app/src/modules/user/rating/rating_existance_model.dart';

ratingExistRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AppointmentDetailLogic>().ratingExistModel =
        RatingExistModel.fromJson(response);
    if (Get.find<AppointmentDetailLogic>().ratingExistModel.status == true) {
      Get.find<AppointmentDetailLogic>().isRated =
          Get.find<AppointmentDetailLogic>().ratingExistModel.data!.ratingExist;
    } else {}
    Get.find<AppointmentDetailLogic>().updateGetRatingDataController(false);
  } else if (!responseCheck) {
    Get.find<AppointmentDetailLogic>().updateGetRatingDataController(false);
  }
}
