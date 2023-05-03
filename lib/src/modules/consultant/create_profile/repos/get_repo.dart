import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/logic.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_generic_data.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_get_categories.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_get_sub_categorie.dart';

getGenericDataRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().mentorProfileGenericDataModel =
        MentorProfileGenericDataModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().mentorProfileGenericDataModel.status ==
        true) {
      ///---occupation
      Get.find<CreateProfileLogic>().emptyOccupationDropDownList();
      for (var element in Get.find<CreateProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .occupations!) {
        Get.find<CreateProfileLogic>()
            .updateOccupationDropDownList(element.name!);
      }

      ///---countries
      Get.find<CreateProfileLogic>().emptyCountryDropDownList();
      for (var element in Get.find<CreateProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .countries!) {
        Get.find<CreateProfileLogic>().updateCountryDropDownList(element.name!);
      }

      ///---degrees
      Get.find<CreateProfileLogic>().emptyDegreeDropDownList();
      for (var element in Get.find<CreateProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .degrees!) {
        Get.find<CreateProfileLogic>().updateDegreeDropDownList(element.name!);
      }

      ///---banks
      Get.find<CreateProfileLogic>().emptyBankDropDownList();
      for (var element in Get.find<CreateProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .banks!) {
        Get.find<CreateProfileLogic>().updateBankDropDownList(element.name!);
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getCitiesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().citiesByIdModel =
        CitiesByIdModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().citiesByIdModel.status == true) {
      ///---cities
      Get.find<CreateProfileLogic>().emptyCityDropDownList();
      for (var element
          in Get.find<CreateProfileLogic>().citiesByIdModel.data!.cities!) {
        Get.find<CreateProfileLogic>().updateCityDropDownList(element.name!);
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getParentCategoryRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().getParentCategoriesModel =
        GetCategoriesModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().getParentCategoriesModel.status ==
        true) {
      ///---parent-category
      Get.find<CreateProfileLogic>().emptyCategoryDropDownList();
      for (var element in Get.find<CreateProfileLogic>()
          .getParentCategoriesModel
          .data!
          .mentorCategories!) {
        Get.find<CreateProfileLogic>()
            .updateCategoryDropDownList(element.name!);
      }
    }
  }
  Get.find<GeneralController>().updateFormLoaderController(false);
}

getChildCategoryRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<GeneralController>().updateFormLoaderController(false);
  if (responseCheck) {
    print(response);
    Get.find<CreateProfileLogic>().subCategoriesModel =
        SubCategoriesModel.fromJson(response);
    log('getChildCategoryRepo ------>> ${Get.find<CreateProfileLogic>().subCategoriesModel.success}');
  }
}
