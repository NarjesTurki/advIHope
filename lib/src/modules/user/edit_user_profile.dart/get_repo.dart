import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/logic.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/model_get_generic_data.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/model_get_user_profile.dart';

getMenteeProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<EditUserProfileLogic>().getMenteeProfileModel =
        GetMenteeProfileModel.fromJson(response);
    if (Get.find<EditUserProfileLogic>().getMenteeProfileModel.status == true) {
      getMethod(context, mentorProfileGenericDataUrl, {'token': '123'}, false,
          getGenericDataMenteeRepo);

      Get.find<EditUserProfileLogic>().updateProfileHiddenSwitch(
          Get.find<EditUserProfileLogic>()
                      .getMenteeProfileModel
                      .data!
                      .user!
                      .mentee!
                      .identityHidden ==
                  0
              ? false
              : true);
      if (Get.find<EditUserProfileLogic>()
              .getMenteeProfileModel
              .data!
              .user!
              .firstName !=
          null) {
        Get.find<EditUserProfileLogic>().firstNameController.text =
            Get.find<EditUserProfileLogic>()
                .getMenteeProfileModel
                .data!
                .user!
                .firstName!;
        Get.find<EditUserProfileLogic>().update();
      }
      if (Get.find<EditUserProfileLogic>()
              .getMenteeProfileModel
              .data!
              .user!
              .lastName !=
          null) {
        Get.find<EditUserProfileLogic>().lastNameController.text =
            Get.find<EditUserProfileLogic>()
                .getMenteeProfileModel
                .data!
                .user!
                .lastName!;

        Get.find<EditUserProfileLogic>().update();
      }
      if (Get.find<EditUserProfileLogic>()
              .getMenteeProfileModel
              .data!
              .user!
              .gender !=
          null) {
        Get.find<EditUserProfileLogic>().selectedGender =
            Get.find<EditUserProfileLogic>()
                .getMenteeProfileModel
                .data!
                .user!
                .gender!;

        Get.find<EditUserProfileLogic>().update();
      }
      if (Get.find<EditUserProfileLogic>()
              .getMenteeProfileModel
              .data!
              .user!
              .city !=
          null) {
        Get.find<EditUserProfileLogic>().selectedCity =
            Get.find<EditUserProfileLogic>()
                .getMenteeProfileModel
                .data!
                .user!
                .city!;

        Get.find<EditUserProfileLogic>().update();
      }
      if (Get.find<EditUserProfileLogic>()
              .getMenteeProfileModel
              .data!
              .user!
              .country !=
          null) {
        getMethod(
            context,
            getCitiesByIdUrl,
            {
              'token': '123',
              'country_id': Get.find<EditUserProfileLogic>()
                  .getMenteeProfileModel
                  .data!
                  .user!
                  .country
            },
            false,
            getCitiesRepo);

        Get.find<EditUserProfileLogic>().update();
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
      }
      Get.find<EditUserProfileLogic>().update();
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getGenericDataMenteeRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<EditUserProfileLogic>().menteeProfileGenericDataModel =
        MenteeProfileGenericDataModel.fromJson(response);
    if (Get.find<EditUserProfileLogic>().menteeProfileGenericDataModel.status ==
        true) {
      ///---countries
      Get.find<EditUserProfileLogic>().countryDropDownList = [];
      Get.find<EditUserProfileLogic>().update();
      for (var element in Get.find<EditUserProfileLogic>()
          .menteeProfileGenericDataModel
          .data!
          .countries!) {
        if (Get.find<EditUserProfileLogic>()
                .getMenteeProfileModel
                .data!
                .user!
                .country !=
            null) {
          if (element.id ==
              int.parse(Get.find<EditUserProfileLogic>()
                  .getMenteeProfileModel
                  .data!
                  .user!
                  .country!
                  .toString())) {
            Get.find<EditUserProfileLogic>().selectedCountry = element.name;
          }
        }
        Get.find<EditUserProfileLogic>()
            .updateCountryDropDownList(element.name!);
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
    Get.find<EditUserProfileLogic>().citiesByIdModel =
        CitiesByIdModel.fromJson(response);
    if (Get.find<EditUserProfileLogic>().citiesByIdModel.status == true) {
      ///---cities
      Get.find<EditUserProfileLogic>().cityDropDownList = [];
      Get.find<EditUserProfileLogic>().update();
      for (var element
          in Get.find<EditUserProfileLogic>().citiesByIdModel.data!.cities!) {
        Get.find<EditUserProfileLogic>().updateCityDropDownList(element.name!);
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
