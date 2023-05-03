import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/repo_get.dart';
import 'package:ista_app/src/modules/user/all_consultants/model_all_consultant.dart';
import 'package:ista_app/src/modules/user_profile/get_user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

getUserProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getConsultantProfileModel =
        GetConsultantProfileModel.fromJson(response);

    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<GeneralController>().getConsultantProfileModel.status ==
        true) {
    } else {}
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getUserProfileForEditRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getConsultantProfileModel =
        GetConsultantProfileModel.fromJson(response);
    if (Get.find<GeneralController>().getConsultantProfileModel.status ==
        true) {
      getMethod(context, mentorProfileGenericDataUrl, {'token': '123'}, false,
          getGenericDataRepo);
      getMethod(
          context,
          getCitiesByIdUrl,
          {
            'token': '123',
            'country_id': Get.find<GeneralController>()
                .getConsultantProfileModel
                .data!
                .userDetail!
                .country
          },
          false,
          getCitiesRepo);
      getMethod(context, mentorParentCategoryDataUrl, {'token': '123'}, false,
          getParentCategoryRepo);

      Get.find<EditConsultantProfileLogic>().firstNameController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .firstName!;
      Get.find<EditConsultantProfileLogic>().lastNameController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .lastName!;
      Get.find<EditConsultantProfileLogic>().fatherNameController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .fatherName!;
      Get.find<EditConsultantProfileLogic>().cnicController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .cnic!;
      Get.find<EditConsultantProfileLogic>().addressController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .address!;
      Get.find<EditConsultantProfileLogic>().aboutController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .about!;
      if (Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .gender !=
          null) {
        Get.find<EditConsultantProfileLogic>().selectedGender =
            Get.find<GeneralController>()
                .getConsultantProfileModel
                .data!
                .userDetail!
                .gender!
                .capitalize;
      }

      Get.find<EditConsultantProfileLogic>().selectedReligion =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .religion!
              .capitalize;
      Get.find<EditConsultantProfileLogic>().dobController.text =
          DateFormat('dd-MM-yyyy').format(DateTime.parse(
              Get.find<GeneralController>()
                  .getConsultantProfileModel
                  .data!
                  .userDetail!
                  .dob!));
      Get.find<EditConsultantProfileLogic>().selectedDob = DateTime.parse(
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .dob!);
      Get.find<EditConsultantProfileLogic>().selectedCity =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .city!;
      Get.find<EditConsultantProfileLogic>().forDisplayEducationList =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .educations!;
      Get.find<EditConsultantProfileLogic>().forDisplayExperienceList =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .experiences!;
      Get.find<EditConsultantProfileLogic>().forDisplaySkillList =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .mentor!
              .categories!;
      Get.find<EditConsultantProfileLogic>().selectedBank =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .cardDetail!
              .bank!;
      Get.find<EditConsultantProfileLogic>().accountTitleController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .cardDetail!
              .accountTitle!;
      Get.find<EditConsultantProfileLogic>().accountNumberController.text =
          Get.find<GeneralController>()
              .getConsultantProfileModel
              .data!
              .userDetail!
              .cardDetail!
              .accountNumber!;
      Get.find<EditConsultantProfileLogic>().update();
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
