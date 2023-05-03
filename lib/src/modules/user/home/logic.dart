import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/user/home/model_featured.dart';
import 'package:ista_app/src/modules/user/home/model_get_categories.dart';
import 'package:ista_app/src/modules/user/home/model_top_rated.dart';
import 'package:ista_app/src/modules/user/home/model_user_profile.dart';
import 'package:ista_app/src/modules/user/home/state.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:resize/resize.dart';

class UserHomeLogic extends GetxController {
  final UserHomeState state = UserHomeState();

  GetUserProfileModel getUserProfileModel = GetUserProfileModel();

  int? selectedConsultantID;
  String? selectedConsultantName;

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 200.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.positions.last.pixels > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  ///----app-bar-settings-----end

  FeaturedConsultantModel featuredConsultantModel = FeaturedConsultantModel();
  bool? featuredConsultantLoader = true;
  updateFeaturedConsultantLoader(bool? newValue) {
    featuredConsultantLoader = newValue;
    update();
  }

  List<HomeStyling> topConsultants = [];

  ///-------

  GetCategoriesModel getCategoriesModel = GetCategoriesModel();
  bool? categoriesLoader = true;
  updateCategoriesLoader(bool? newValue) {
    categoriesLoader = newValue;
    update();
  }

  int? selectedCategoryId;
  List<HomeStyling> categoriesList = [];
  List categoriesColor = [
    customLightThemeColor,
    customOrangeColor,
    customThemeColor,
    customThemeColor,
    customLightThemeColor,
    customOrangeColor
  ];

  ///-------
  TopRatedModel topRatedModel = TopRatedModel();
  bool? topRatedLoader = true;
  updateTopRatedLoader(bool? newValue) {
    topRatedLoader = newValue;
    update();
  }

  bool? topRatedLoaderMore = false;
  updateTopRatedLoaderMore(bool? newValue) {
    topRatedLoaderMore = newValue;
    update();
  }

  List<TopRatedStyling> topRatedConsultantList = [];
}

class HomeStyling {
  HomeStyling(
      {required this.id,
      this.title,
      this.subTitle,
      this.image,
      this.color,
      this.gender});

  int? id;
  String? title;
  String? subTitle;
  String? image;
  Color? color;
  String? gender;
}

class TopRatedStyling {
  TopRatedStyling({
    required this.id,
    this.title,
    this.subTitle,
    this.image,
    this.rating,
  });

  int? id;
  String? title;
  String? subTitle;
  String? image;
  int? rating;
}
