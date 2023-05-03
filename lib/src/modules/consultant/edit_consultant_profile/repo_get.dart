import 'dart:developer';

import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/logic.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_profile/models/model_generic_data.dart';
import '../create_profile/models/model_get_categories.dart';
import '../create_profile/models/model_get_sub_categorie.dart';

getGenericDataRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel =
        MentorProfileGenericDataModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>()
            .mentorProfileGenericDataModel
            .status ==
        true) {
      ///---occupation
      Get.find<EditConsultantProfileLogic>().emptyOccupationDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .occupations!) {
        if (element.id ==
            Get.find<GeneralController>()
                .getConsultantProfileModel
                .data!
                .userDetail!
                .occupation!) {
          Get.find<EditConsultantProfileLogic>().selectedOccupation =
              element.name;
        }
        Get.find<EditConsultantProfileLogic>()
            .updateOccupationDropDownList(element.name!);
      }

      ///---countries
      Get.find<EditConsultantProfileLogic>().emptyCountryDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .countries!) {
        if (element.id ==
            Get.find<GeneralController>()
                .getConsultantProfileModel
                .data!
                .userDetail!
                .country!) {
          Get.find<EditConsultantProfileLogic>().selectedCountry = element.name;
        }
        Get.find<EditConsultantProfileLogic>()
            .updateCountryDropDownList(element.name!);
      }

      ///---degrees
      Get.find<EditConsultantProfileLogic>().emptyDegreeDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .degrees!) {
        Get.find<EditConsultantProfileLogic>()
            .updateDegreeDropDownList(element.name!);
      }

      ///---banks
      Get.find<EditConsultantProfileLogic>().emptyBankDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .banks!) {
        Get.find<EditConsultantProfileLogic>()
            .updateBankDropDownList(element.name!);
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
    Get.find<EditConsultantProfileLogic>().citiesByIdModel =
        CitiesByIdModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().citiesByIdModel.status == true) {
      ///---cities
      Get.find<EditConsultantProfileLogic>().emptyCityDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>()
          .citiesByIdModel
          .data!
          .cities!) {
        Get.find<EditConsultantProfileLogic>()
            .updateCityDropDownList(element.name!);
      }

      Set<String> seen = <String>{};
      List<String> uniquelist = Get.find<EditConsultantProfileLogic>()
          .cityDropDownList
          .where((val) => seen.add(val))
          .toList();
      Get.find<EditConsultantProfileLogic>().cityDropDownList = uniquelist;
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
    Get.find<EditConsultantProfileLogic>().getParentCategoriesModel =
        GetCategoriesModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>()
            .getParentCategoriesModel
            .status ==
        true) {
      ///---parent-category
      Get.find<EditConsultantProfileLogic>().emptyCategoryDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>()
          .getParentCategoriesModel
          .data!
          .mentorCategories!) {
        Get.find<EditConsultantProfileLogic>()
            .updateCategoryDropDownList(element.name!);
      }
      getMethod(
          context,
          mentorChildCategoryDataUrl,
          {
            'token': '123',
            'parent_id': Get.find<GeneralController>()
                .getConsultantProfileModel
                .data!
                .userDetail!
                .mentor!
                .categories![Get.find<GeneralController>()
                        .getConsultantProfileModel
                        .data!
                        .userDetail!
                        .mentor!
                        .categories!
                        .length -
                    1]
                .id
          },
          false,
          getChildCategoryRepo);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getChildCategoryRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.put(EditConsultantProfileLogic());
  Get.find<GeneralController>().updateFormLoaderController(false);
  if (responseCheck) {
    print(response);
    Get.find<EditConsultantProfileLogic>().subCategoriesModel =
        SubCategoriesModel.fromJson(response);
    log('getChildCategoryRepo ------>> ${Get.find<EditConsultantProfileLogic>().subCategoriesModel.success}');
  }
}
