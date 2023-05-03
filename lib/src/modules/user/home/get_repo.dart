import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/modules/user/home/model_featured.dart';
import 'package:ista_app/src/modules/user/home/model_get_categories.dart';
import 'package:ista_app/src/modules/user/home/model_top_rated.dart';
import 'package:ista_app/src/modules/user/home/model_user_profile.dart';
import 'package:ista_app/src/utils/colors.dart';

getUserProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.put(UserHomeLogic());
  if (responseCheck) {
    Get.find<UserHomeLogic>().getUserProfileModel =
        GetUserProfileModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().getUserProfileModel.status.toString() ==
        'true') {
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getFeaturedConsultantRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().featuredConsultantModel =
        FeaturedConsultantModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().featuredConsultantModel.status.toString() ==
        'true') {
      Get.find<UserHomeLogic>().topConsultants.clear();
      for (var element
          in Get.find<UserHomeLogic>().featuredConsultantModel.data!.mentors!) {
        Get.find<UserHomeLogic>().topConsultants.add(HomeStyling(
            id: element.userId,
            title: '${element.firstName ?? ''} ${element.lastName ?? ''}',
            subTitle: element.category?.name ?? 'category',
            image: element.imagePath,
            gender: element.gender));
      }
      Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getCategoriesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().getCategoriesModel =
        GetCategoriesModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().getCategoriesModel.status.toString() ==
        'true') {
      Get.find<UserHomeLogic>().categoriesList.clear();
      for (var element in Get.find<UserHomeLogic>()
          .getCategoriesModel
          .data!
          .mentorCategories!) {
        Get.find<UserHomeLogic>().categoriesList.add(HomeStyling(
            id: element.id,
            title: element.name,
            subTitle: element.mentorPCount.toString(),
            image: element.imagePath,
            color: customThemeColor));
      }
      Get.find<UserHomeLogic>().updateCategoriesLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateCategoriesLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateCategoriesLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getTopRatedConsultantRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().topRatedModel = TopRatedModel.fromJson(response);

    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().topRatedModel.status.toString() == 'true') {
      Get.find<UserHomeLogic>().topRatedConsultantList.clear();
      for (var element in Get.find<UserHomeLogic>()
          .topRatedModel
          .data!
          .topRatedMentors!
          .data!) {
        Get.find<UserHomeLogic>().topRatedConsultantList.add(TopRatedStyling(
            id: element.userId,
            title: '${element.firstName ?? ''} ${element.lastName ?? ''}',
            subTitle: element.category?.name ?? 'category',
            image: element.imagePath,
            rating: element.ratingAvg));
      }
      Get.find<UserHomeLogic>().updateTopRatedLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateTopRatedLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateTopRatedLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getTopRatedConsultantMoreRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().topRatedModel = TopRatedModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().topRatedModel.status.toString() == 'true') {
      for (var element in Get.find<UserHomeLogic>()
          .topRatedModel
          .data!
          .topRatedMentors!
          .data!) {
        Get.find<UserHomeLogic>().topRatedConsultantList.add(TopRatedStyling(
            id: element.userId,
            title: '${element.firstName ?? ''} ${element.lastName ?? ''}',
            subTitle: element.category?.name ?? 'category',
            image: element.imagePath,
            rating: element.ratingAvg));
      }
      Get.find<UserHomeLogic>().updateTopRatedLoaderMore(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateTopRatedLoaderMore(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateTopRatedLoaderMore(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
