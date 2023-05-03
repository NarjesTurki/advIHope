import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/view_educational_info.dart';
import 'package:ista_app/src/modules/consultant/create_profile/view_experience.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/view_account_info.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/view_confirmation.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/view_general_info.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/view_skill_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../user_profile/get_user_profile_model.dart';
import '../create_profile/models/model_generic_data.dart';
import '../create_profile/models/model_get_categories.dart';
import '../create_profile/models/model_get_sub_categorie.dart';
import '../create_profile/models/model_post_account_info.dart';
import '../create_profile/models/model_post_education_info.dart';
import '../create_profile/models/model_post_experience_info.dart';
import '../create_profile/models/model_post_general_info.dart';
import '../create_profile/models/model_post_skill_info.dart';
import 'state.dart';

class EditConsultantProfileLogic extends GetxController {
  final EditConsultantProfileState state = EditConsultantProfileState();

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

  int? stepperIndex = 0;

  updateStepperIndex(int? newValue) {
    stepperIndex = newValue;
    update();
  }

  ScrollController stepperScrollController = ScrollController();

  List<Stepper> stepperList = [
    Stepper(
        title: '${LanguageConstant.general.tr}\n${LanguageConstant.info.tr}',
        stepperLabel: '01',
        isSelected: true,
        isCompleted: true),
    Stepper(
        title:
            '${LanguageConstant.educational.tr}\n${LanguageConstant.info.tr}',
        stepperLabel: '02',
        isSelected: false,
        isCompleted: true),
    Stepper(
        title: '${LanguageConstant.experience.tr}\n${LanguageConstant.info.tr}',
        stepperLabel: '03',
        isSelected: false,
        isCompleted: true),
    Stepper(
        title: LanguageConstant.skillInfo.tr,
        stepperLabel: '04',
        isSelected: false,
        isCompleted: true),
    Stepper(
        title: '${LanguageConstant.account.tr}\n${LanguageConstant.info.tr}',
        stepperLabel: '05',
        isSelected: false,
        isCompleted: true),
  ];

  consultantProfileNavigation(
    int? index,
    BuildContext context,
  ) {
    switch (index) {
      case 0:
        {
          return const GeneralInfoView();
        }
      case 1:
        {
          return const EducationalInfoView();
        }
      case 2:
        {
          return const ExperienceInfoView();
        }
      case 3:
        {
          return const SkillInfoView();
        }
      case 4:
        {
          return showConfirmation!
              ? const ConfirmationView()
              : const AccountInfoView();
        }
      default:
        {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          );
        }
    }
  }

  bool? showConfirmation = false;

  getSetData(BuildContext context) {
    if (Get.find<GeneralController>().getConsultantProfileModel.data != null) {
      firstNameController.text = Get.find<GeneralController>()
          .getConsultantProfileModel
          .data!
          .userDetail!
          .firstName!;
      lastNameController.text = Get.find<GeneralController>()
          .getConsultantProfileModel
          .data!
          .userDetail!
          .lastName!;
      update();
    }
  }

  ///-------------------------------general-tab
  MentorProfileGenericDataModel mentorProfileGenericDataModel =
      MentorProfileGenericDataModel();
  CitiesByIdModel citiesByIdModel = CitiesByIdModel();
  GeneralInfoPostModel generalInfoPostModel = GeneralInfoPostModel();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  String? selectedGender;
  List<String> genderDropDownList = ['Male', 'Female', 'Other'];
  String? selectedReligion;
  List<String> religionDropDownList = [
    'Islam',
    'Christian',
    'Hindu',
    'Sikh',
    'Jew',
    'Buddhist',
    'Other',
  ];

  DateTime? selectedDob;
  String? selectedOccupation;
  List<String> occupationDropDownList = [];

  updateOccupationDropDownList(String newValue) {
    occupationDropDownList.add(newValue);
    update();
  }

  emptyOccupationDropDownList() {
    occupationDropDownList = [];
    update();
  }

  String? selectedCountry;
  List<String> countryDropDownList = [];

  updateCountryDropDownList(String newValue) {
    countryDropDownList.add(newValue);
    update();
  }

  emptyCountryDropDownList() {
    countryDropDownList = [];
    update();
  }

  String? selectedCity;
  List<String> cityDropDownList = [];

  updateCityDropDownList(String newValue) {
    cityDropDownList.add(newValue);

    update();
  }

  emptyCityDropDownList() {
    cityDropDownList = [];
    update();
  }

  saveData({String? latLong, String? place}) async {
    addressController.text = place!;
    update();
  }

  ///-------------------------------education-tab
  EducationInfoPostModel educationInfoPostModel = EducationInfoPostModel();
  String? selectedDegree;
  List<String> degreeDropDownList = [];

  updateDegreeDropDownList(String newValue) {
    degreeDropDownList.add(newValue);
    update();
  }

  emptyDegreeDropDownList() {
    degreeDropDownList = [];
    update();
  }

  String? selectedYear;
  List<Education>? forDisplayEducationList = [];

  updateForDisplayEducationList(Education? newValue) {
    forDisplayEducationList!.add(newValue!);
    update();
  }

  emptyForDisplayEducationList() {
    forDisplayEducationList = [];
    update();
  }

  ///-------------------------------experience-tab
  ExperienceInfoPostModel experienceInfoPostModel = ExperienceInfoPostModel();
  DateTime? selectedCompanyFromDate;
  DateTime? selectedCompanyToDate;

  emptyDateFields() {
    selectedCompanyFromDate = null;
    selectedCompanyToDate = null;
    update();
  }

  List<Experience>? forDisplayExperienceList = [];

  updateForDisplayExperienceList(Experience? newValue) {
    forDisplayExperienceList!.add(newValue!);
    update();
  }

  emptyForDisplayExperienceList() {
    forDisplayExperienceList = [];
    update();
  }

  ///-------------------------------skill-tab
  GetCategoriesModel getParentCategoriesModel = GetCategoriesModel();
  SubCategoriesModel subCategoriesModel = SubCategoriesModel();
  SkillInfoPostModel skillInfoPostModel = SkillInfoPostModel();

  String? selectedCategory;
  List<String> categoryDropDownList = [];

  updateCategoryDropDownList(String newValue) {
    categoryDropDownList.add(newValue);
    update();
  }

  emptyCategoryDropDownList() {
    categoryDropDownList = [];
    update();
  }

  List<int> selectedSubCategoriesIDList = [];

  updateSelectedSubCategoriesIDList(int newValue) {
    selectedSubCategoriesIDList.add(newValue);
    update();
  }

  emptySelectedSubCategoriesIDList() {
    selectedSubCategoriesIDList = [];
    update();
  }

  List<int> selectedSubCategoriesExpandList = [];

  updateSelectedSubCategoriesExpandList(int newValue) {
    selectedSubCategoriesExpandList.add(newValue);
    update();
  }

  emptySelectedSubCategoriesExpandList() {
    selectedSubCategoriesExpandList = [];
    update();
  }

  List<Categories>? forDisplaySkillList = [];

  updateForDisplaySkillList(Categories? newValue) {
    forDisplaySkillList!.add(newValue!);
    update();
  }

  emptyForDisplaySkillList() {
    forDisplaySkillList = [];
    update();
  }

  ///-------------------------------account-tab
  AccountInfoPostModel accountInfoPostModel = AccountInfoPostModel();
  String? selectedBank;
  List<String> bankDropDownList = [];

  updateBankDropDownList(String newValue) {
    bankDropDownList.add(newValue);
    update();
  }

  emptyBankDropDownList() {
    bankDropDownList = [];
    update();
  }

  final TextEditingController accountTitleController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
}

class Stepper {
  Stepper({this.title, this.stepperLabel, this.isSelected, this.isCompleted});

  String? title;
  String? stepperLabel;
  bool? isSelected;
  bool? isCompleted;
}
