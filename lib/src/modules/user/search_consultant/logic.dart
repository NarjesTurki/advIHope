import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/user/search_consultant/search_consultant_model.dart';
import 'package:ista_app/src/modules/user/search_consultant/state.dart';

class SearchConsultantLogic extends GetxController {
  final SearchConsultantState state = SearchConsultantState();

  SearchConsultantModel searchConsultantModel = SearchConsultantModel();

  TextEditingController searchController = TextEditingController();

  bool? searchLoader = false;
  updateSearchLoader(bool? newValue) {
    searchLoader = newValue;
    update();
  }
}
