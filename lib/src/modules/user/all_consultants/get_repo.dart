import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/all_consultants/logic.dart';
import 'package:ista_app/src/modules/user/all_consultants/model_all_consultant.dart';
import 'package:ista_app/src/modules/user/all_consultants/model_all_consultant_more.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';

getCategoriesWithConsultantRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AllConsultantsLogic>().allCategoriesWithConsultantModel =
        AllCategoriesWithConsultantModel.fromJson(response);
    Get.find<AllConsultantsLogic>().update();
    if (Get.find<AllConsultantsLogic>()
            .allCategoriesWithConsultantModel
            .status
            .toString() ==
        'true') {
      Get.find<AllConsultantsLogic>().allCategoriesList.clear();
      Get.find<AllConsultantsLogic>().allConsultantList.clear();

      ///---get-consultant --------------------- open
      Get.find<AllConsultantsLogic>().allConsultantList =
          Get.find<AllConsultantsLogic>()
              .allCategoriesWithConsultantModel
              .data!
              .categories!;

      ///---get-consultant --------------------- close
      ///---get-categories --------------------- open
      for (var element in Get.find<AllConsultantsLogic>()
          .allCategoriesWithConsultantModel
          .data!
          .categories!) {
        Get.find<AllConsultantsLogic>()
            .allCategoriesList
            .add(Tab(text: element.name!));
      }

      Get.find<AllConsultantsLogic>().update();
      Get.find<AllConsultantsLogic>().tabController = TabController(
          length: Get.find<AllConsultantsLogic>().allCategoriesList.length,
          vsync: Get.find<AllConsultantsLogic>().reference!);
      if (Get.find<UserHomeLogic>().selectedCategoryId != null) {
        for (var element in Get.find<AllConsultantsLogic>()
            .allCategoriesWithConsultantModel
            .data!
            .categories!) {
          if (Get.find<UserHomeLogic>().selectedCategoryId == element.id) {
            Get.find<AllConsultantsLogic>().tabController.index =
                Get.find<AllConsultantsLogic>()
                    .allCategoriesWithConsultantModel
                    .data!
                    .categories!
                    .indexOf(element);
          }
        }
      }

      ///---get-categories --------------------- close

      Get.find<AllConsultantsLogic>().updateAllConsultantLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<AllConsultantsLogic>().updateAllConsultantLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<AllConsultantsLogic>().updateAllConsultantLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getCategoriesWithConsultantMoreRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AllConsultantsLogic>().allCategoriesWithConsultantMoreModel =
        AllCategoriesWithConsultantMoreModel.fromJson(response);
    Get.find<AllConsultantsLogic>().update();
    if (Get.find<AllConsultantsLogic>()
            .allCategoriesWithConsultantMoreModel
            .status
            .toString() ==
        'true') {
      ///---get-more-consultant --------------------- open
      for (var element in Get.find<AllConsultantsLogic>()
          .allCategoriesWithConsultantMoreModel
          .data!
          .categories!
          .mentors!
          .data!) {
        Get.find<AllConsultantsLogic>()
            .allConsultantList[
                Get.find<AllConsultantsLogic>().selectedParentIndexForMore!]
            .mentors!
            .data!
            .add(element);
      }

      ///---get-more-consultant --------------------- close

      Get.find<AllConsultantsLogic>().updateAllConsultantMoreLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<AllConsultantsLogic>().updateAllConsultantMoreLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<AllConsultantsLogic>().updateAllConsultantMoreLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
