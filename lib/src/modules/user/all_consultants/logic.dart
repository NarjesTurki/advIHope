import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/user/all_consultants/model_all_consultant.dart';
import 'package:ista_app/src/modules/user/all_consultants/model_all_consultant_more.dart';
import 'package:ista_app/src/modules/user/all_consultants/state.dart';
import 'package:resize/resize.dart';

class AllConsultantsLogic extends GetxController {
  final AllConsultantsState state = AllConsultantsState();

  late TabController tabController;

  TickerProvider? reference;

  /// consultants rating style///

  AllCategoriesWithConsultantModel allCategoriesWithConsultantModel =
      AllCategoriesWithConsultantModel();
  AllCategoriesWithConsultantMoreModel allCategoriesWithConsultantMoreModel =
      AllCategoriesWithConsultantMoreModel();
  bool? allConsultantLoader = true;

  updateAllConsultantLoader(bool? newValue) {
    allConsultantLoader = newValue;
    update();
  }

  bool? allConsultantMoreLoader = false;

  updateAllConsultantMoreLoader(bool? newValue) {
    allConsultantMoreLoader = newValue;
    update();
  }

  int? selectedParentIndexForMore;

  List<Tab> allCategoriesList = [];
  List<Categories> allConsultantList = [];

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
}
