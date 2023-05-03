import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_get_sub_categorie.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_post_skill_info.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/get_delete.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/get_repo.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/repo_post.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class SkillInfoView extends StatefulWidget {
  const SkillInfoView({Key? key}) : super(key: key);

  @override
  _SkillInfoViewState createState() => _SkillInfoViewState();
}

class _SkillInfoViewState extends State<SkillInfoView> {
  final state = Get.find<EditConsultantProfileLogic>().state;

  final GlobalKey<FormState> _skillInfoFormKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<EditConsultantProfileLogic>().scrollController!.animateTo(
        Get.find<EditConsultantProfileLogic>()
            .scrollController!
            .position
            .minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (_generalController) => GetBuilder<EditConsultantProfileLogic>(
        builder: (_editConsultantProfileLogic) => ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          inAsyncCall: _generalController.formLoaderController,
          child: Scaffold(
              backgroundColor: customTextFieldColor,
              body: SingleChildScrollView(
                  child: Form(
                key: _skillInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///---category
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.w, 25.h, 15.w, 16.h),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            hint: Text(
                              LanguageConstant.department.tr.capitalizeFirst!,
                              style: state.hintTextStyle,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 14.h, 15.w, 14.h),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: customLightThemeColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                            ),
                            isExpanded: true,
                            focusColor: Colors.white,
                            style: state.textFieldTextStyle,
                            iconEnabledColor: customThemeColor,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 25,
                            value: _editConsultantProfileLogic.selectedCategory,
                            items: _editConsultantProfileLogic
                                .categoryDropDownList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: state.textFieldTextStyle,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              _editConsultantProfileLogic
                                  .emptySelectedSubCategoriesIDList();
                              _editConsultantProfileLogic
                                  .emptySelectedSubCategoriesExpandList();
                              setState(() {
                                _editConsultantProfileLogic.selectedCategory =
                                    value;

                                _editConsultantProfileLogic
                                    .updateSelectedSubCategoriesIDList(
                                        _editConsultantProfileLogic
                                            .getParentCategoriesModel
                                            .data!
                                            .mentorCategories![
                                                _editConsultantProfileLogic
                                                    .categoryDropDownList
                                                    .indexOf(value!)]
                                            .id!);
                              });
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              getMethod(
                                  context,
                                  mentorChildCategoryDataUrl,
                                  {
                                    'token': '123',
                                    'parent_id': _editConsultantProfileLogic
                                        .getParentCategoriesModel
                                        .data!
                                        .mentorCategories![
                                            _editConsultantProfileLogic
                                                .categoryDropDownList
                                                .indexOf(
                                                    _editConsultantProfileLogic
                                                        .selectedCategory!)]
                                        .id
                                  },
                                  false,
                                  getChildCategoryRepo);
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return LanguageConstant.fieldRequired.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    ///---sub-category
                    ///---sub-category
                    if ((_editConsultantProfileLogic
                                .subCategoriesModel.data?.mentorCategories ??
                            [])
                        .isNotEmpty) ...[
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 0, 15.w, 16.h),
                          child: Row(
                            children: [
                              Text(
                                LanguageConstant.category.tr.capitalizeFirst!,
                                style: state.textFieldTextStyle,
                              )
                            ],
                          )),
                      ...(_editConsultantProfileLogic
                                  .subCategoriesModel.data?.mentorCategories ??
                              [])
                          .map(
                        (e) => Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 15),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side:
                                  const BorderSide(color: customTextGreyColor)),
                          child: Column(children: [
                            InkWell(
                              onTap: () {
                                if ((e.subCategories ?? []).isNotEmpty &&
                                    !_editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                        .contains(e.id)) {
                                  for (var value in e.subCategories!) {
                                    if (!_editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                        .contains(value.id)) {
                                      _editConsultantProfileLogic
                                          .selectedSubCategoriesIDList
                                          .add(value.id!);
                                    }
                                  }
                                }
                                if ((e.subCategories ?? []).isNotEmpty &&
                                    _editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                        .contains(e.id)) {
                                  for (var value in e.subCategories!) {
                                    if (_editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                        .contains(value.id)) {
                                      _editConsultantProfileLogic
                                          .selectedSubCategoriesIDList
                                          .remove(value.id!);
                                    }
                                  }
                                }
                                _editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                        .contains(e.id)
                                    ? _editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                        .remove(e.id)
                                    : _editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                        .add(e.id!);
                                _editConsultantProfileLogic.update();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8),
                                child: Row(children: [
                                  const SizedBox(width: 5),
                                  Icon(
                                      _editConsultantProfileLogic
                                              .selectedSubCategoriesIDList
                                              .contains(e.id)
                                          ? Icons.check_box_outlined
                                          : Icons
                                              .check_box_outline_blank_outlined,
                                      color: customThemeColor),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text("${e.name}")),
                                  (e.subCategories ?? []).isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            _editConsultantProfileLogic
                                                    .selectedSubCategoriesExpandList
                                                    .contains(e.id)
                                                ? _editConsultantProfileLogic
                                                    .selectedSubCategoriesExpandList
                                                    .remove(e.id)
                                                : _editConsultantProfileLogic
                                                    .selectedSubCategoriesExpandList
                                                    .add(e.id!);
                                            _editConsultantProfileLogic
                                                .update();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                                _editConsultantProfileLogic
                                                        .selectedSubCategoriesExpandList
                                                        .contains(e.id)
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                color: customThemeColor),
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.keyboard_arrow_up,
                                              color: Colors.transparent),
                                        ),
                                ]),
                              ),
                            ),
                            if ((e.subCategories ?? []).isNotEmpty &&
                                _editConsultantProfileLogic
                                    .selectedSubCategoriesExpandList
                                    .contains(e.id)) ...[
                              const SizedBox(height: 5),
                              buildCategoriesChild(e.subCategories!,
                                  _editConsultantProfileLogic),
                            ]
                          ]),
                        ),
                      ),
                    ],

                    ///---add-button
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_editConsultantProfileLogic
                                .selectedSubCategoriesIDList.isNotEmpty) {
                              _editConsultantProfileLogic.forDisplaySkillList =
                                  [];
                              _editConsultantProfileLogic.update();
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  mentorSkillInfoUrl,
                                  {
                                    'token': '123',
                                    'mentor_id': Get.find<GeneralController>()
                                        .storageBox
                                        .read('userID'),
                                    'categories': _editConsultantProfileLogic
                                        .selectedSubCategoriesIDList
                                  },
                                  true,
                                  mentorSkillInfoRepo);
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: LanguageConstant.failed.tr,
                                      titleColor: customDialogErrorColor,
                                      descriptions:
                                          '${LanguageConstant.selectCategoryPlease.tr}!',
                                      text: LanguageConstant.ok.tr,
                                      functionCall: () {
                                        Navigator.pop(context);
                                      },
                                      img: 'assets/dialog_error.svg',
                                    );
                                  });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * .45,
                            decoration: BoxDecoration(
                                color: customLightThemeColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                _editConsultantProfileLogic
                                            .skillInfoPostModel.data ==
                                        null
                                    ? LanguageConstant.addSkill.tr
                                    : LanguageConstant.update.tr,
                                style: state.addButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///---added-record-preview
                    _editConsultantProfileLogic.skillInfoPostModel.data == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 28, 15, 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 7, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                (_editConsultantProfileLogic
                                                            .skillInfoPostModel
                                                            .data
                                                            ?.category ??
                                                        [])
                                                    .length,
                                                (index) => Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      index == 0 ? 0 : 5,
                                                      6,
                                                      0,
                                                      0),
                                                  child: Text(
                                                    _editConsultantProfileLogic
                                                            .skillInfoPostModel
                                                            .data
                                                            ?.category?[index]
                                                            .name ??
                                                        "N/A",
                                                    style: state
                                                        .previewLabelTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _generalController
                                                  .updateFormLoaderController(
                                                      true);
                                              postMethod(
                                                  context,
                                                  mentorSkillInfoDeleteUrl,
                                                  {
                                                    'token': '123',
                                                    'mentor_id': Get.find<
                                                            GeneralController>()
                                                        .storageBox
                                                        .read('userID')
                                                  },
                                                  true,
                                                  deleteEducationRepo);
                                              _editConsultantProfileLogic
                                                      .skillInfoPostModel =
                                                  SkillInfoPostModel();
                                              setState(() {});
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .all(8.0),
                                              child: SvgPicture.asset(
                                                  'assets/Icons/deleteIcon.svg'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                    (_editConsultantProfileLogic.forDisplaySkillList ?? [])
                            .isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 28, 15, 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 7, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                (_editConsultantProfileLogic
                                                            .forDisplaySkillList ??
                                                        [])
                                                    .length,
                                                (index) => Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      index == 0 ? 0 : 5,
                                                      6,
                                                      0,
                                                      0),
                                                  child: Text(
                                                    _editConsultantProfileLogic
                                                            .forDisplaySkillList?[
                                                                index]
                                                            .category
                                                            ?.name ??
                                                        "N/A",
                                                    style: state
                                                        .previewLabelTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                  ],
                ),
              )),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                child: InkWell(
                    onTap: () {
                      if ((_editConsultantProfileLogic
                                      .skillInfoPostModel.data !=
                                  null &&
                              _editConsultantProfileLogic
                                  .forDisplaySkillList!.isEmpty) ||
                          (_editConsultantProfileLogic
                                      .skillInfoPostModel.data ==
                                  null &&
                              _editConsultantProfileLogic
                                  .forDisplaySkillList!.isNotEmpty)) {
                        setState(() {
                          _editConsultantProfileLogic
                              .stepperList[
                                  _editConsultantProfileLogic.stepperIndex!]
                              .isSelected = false;
                          _editConsultantProfileLogic
                              .stepperList[
                                  _editConsultantProfileLogic.stepperIndex!]
                              .isCompleted = true;
                          _editConsultantProfileLogic
                              .stepperList[
                                  _editConsultantProfileLogic.stepperIndex! + 1]
                              .isSelected = true;
                          _editConsultantProfileLogic.updateStepperIndex(4);
                        });
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: LanguageConstant.failed.tr,
                                titleColor: customDialogErrorColor,
                                descriptions:
                                    LanguageConstant.addSkillPlease.tr,
                                text: LanguageConstant.ok.tr,
                                functionCall: () {
                                  Navigator.pop(context);
                                },
                                img: 'assets/dialog_error.svg',
                              );
                            });
                      }
                    },
                    child: MyCustomBottomBar(
                        title: LanguageConstant.nextStep.tr, disable: false)),
              )),
        ),
      ),
    );
  }

  Widget buildCategoriesChild(List<SubCategories> childLIst,
      EditConsultantProfileLogic createProfileLogic) {
    return Column(children: [
      ...childLIst.map(
        (e) => Container(
          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 0),
          width: MediaQuery.of(Get.context!).size.width,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  if ((e.subCategories ?? []).isNotEmpty &&
                      !createProfileLogic.selectedSubCategoriesIDList
                          .contains(e.id)) {
                    for (var value in e.subCategories!) {
                      if (!createProfileLogic.selectedSubCategoriesIDList
                          .contains(value.id)) {
                        createProfileLogic.selectedSubCategoriesIDList
                            .add(value.id!);
                      }
                    }
                  }
                  if ((e.subCategories ?? []).isNotEmpty &&
                      createProfileLogic.selectedSubCategoriesIDList
                          .contains(e.id)) {
                    for (var value in e.subCategories!) {
                      if (createProfileLogic.selectedSubCategoriesIDList
                          .contains(value.id)) {
                        createProfileLogic.selectedSubCategoriesIDList
                            .remove(value.id!);
                      }
                    }
                  }
                  if (createProfileLogic.selectedSubCategoriesIDList
                      .contains(e.id)) {
                    createProfileLogic.selectedSubCategoriesIDList.remove(e.id);
                    createProfileLogic.update();
                    return;
                  }

                  createProfileLogic.selectedSubCategoriesIDList.add(e.id!);
                  if (!createProfileLogic.selectedSubCategoriesIDList
                      .contains(e.parentId)) {
                    createProfileLogic.selectedSubCategoriesIDList
                        .add(e.parentId!);
                  }
                  createProfileLogic.update();
                  // }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(children: [
                    const SizedBox(width: 5),
                    Icon(
                        createProfileLogic.selectedSubCategoriesIDList
                                .contains(e.id)
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: customThemeColor),
                    const SizedBox(width: 8),
                    Expanded(child: Text("${e.name}")),
                    (e.subCategories ?? []).isNotEmpty
                        ? InkWell(
                            onTap: () {
                              createProfileLogic.selectedSubCategoriesExpandList
                                      .contains(e.id)
                                  ? createProfileLogic
                                      .selectedSubCategoriesExpandList
                                      .remove(e.id)
                                  : createProfileLogic
                                      .selectedSubCategoriesExpandList
                                      .add(e.id!);
                              createProfileLogic.update();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                  createProfileLogic
                                          .selectedSubCategoriesExpandList
                                          .contains(e.id)
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: customThemeColor),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.keyboard_arrow_up,
                                color: Colors.transparent),
                          ),
                  ]),
                ),
              ),
              if ((e.subCategories ?? []).isNotEmpty &&
                  createProfileLogic.selectedSubCategoriesExpandList
                      .contains(e.id)) ...[
                const Divider(color: customHintColor),
                const SizedBox(height: 5),
                buildCategoriesChild(e.subCategories!, createProfileLogic),
                const Divider(color: customHintColor)
              ],
            ],
          ),
        ),
      )
    ]);
  }
}
