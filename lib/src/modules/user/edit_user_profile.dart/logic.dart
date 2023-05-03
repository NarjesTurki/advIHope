import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/model_get_generic_data.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/model_get_user_profile.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/state.dart';
import 'package:resize/resize.dart';

class EditUserProfileLogic extends GetxController {
  final EditUserProfileState state = EditUserProfileState();
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

  MenteeProfileGenericDataModel menteeProfileGenericDataModel =
      MenteeProfileGenericDataModel();
  CitiesByIdModel citiesByIdModel = CitiesByIdModel();
  GetMenteeProfileModel getMenteeProfileModel = GetMenteeProfileModel();

  File? profileImage;
  List profileImagesList = [];

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String? selectedGender;
  List<String> genderDropDownList = ['Male', 'Female', 'Other'];

  String? selectedCountry;
  List<String> countryDropDownList = [];

  updateCountryDropDownList(String newValue) {
    countryDropDownList.add(newValue);
    update();
  }

  String? selectedCity;
  List<String> cityDropDownList = [];

  updateCityDropDownList(String newValue) {
    cityDropDownList.add(newValue);
    update();
  }

  bool? profileHiddenSwitch = false;
  updateProfileHiddenSwitch(bool? newValue) {
    profileHiddenSwitch = newValue;
    update();
  }
}
