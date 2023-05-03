import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/get_repo.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/logic.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/post_repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:resize/resize.dart';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({Key? key}) : super(key: key);

  @override
  State<EditUserProfilePage> createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  final logic = Get.put(EditUserProfileLogic());

  final state = Get.find<EditUserProfileLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<EditUserProfileLogic>().scrollController = ScrollController()
      ..addListener(Get.find<EditUserProfileLogic>().scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoaderController(true);
    });
    getMethod(
        context,
        getMenteeProfileUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getMenteeProfileRepo);
  }

  @override
  void dispose() {
    Get.find<EditUserProfileLogic>()
        .scrollController!
        .removeListener(Get.find<EditUserProfileLogic>().scrollListener);
    Get.find<EditUserProfileLogic>().scrollController!.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _profileFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<EditUserProfileLogic>(builder: (_editUserProfileLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: customThemeColor,
            body: NestedScrollView(
                controller: _editUserProfileLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .2,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 0,
                      backgroundColor: _editUserProfileLogic.isShrink
                          ? customThemeColor
                          : Colors.transparent,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .23,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.w, 25.h, 16.w, 16.h),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              Text(
                                                LanguageConstant.editProfile.tr,
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.bold,
                                                    fontSize: 28.sp,
                                                    color:
                                                        customLightThemeColor),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                LanguageConstant
                                                    .editYourProfile.tr,
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .medium,
                                                    fontSize: 12.sp,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: customTextFieldColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
                  child: _generalController.formLoaderController
                      ? const Center(child: CircularProgressIndicator())
                      : Stack(children: [
                          SingleChildScrollView(
                            child: Form(
                              key: _profileFormKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 25.h),
                                  InkWell(
                                    onTap: () {
                                      imagePickerDialog(context);
                                    },
                                    child: SizedBox(
                                      height: 103.h,
                                      width: 190.w,
                                      child: _editUserProfileLogic
                                                  .profileImage ==
                                              null
                                          ? _editUserProfileLogic
                                                      .getMenteeProfileModel
                                                      .data ==
                                                  null
                                              ? Image.asset(
                                                  'assets/images/upload_pic_holder.png',
                                                  fit: BoxFit.fill,
                                                )
                                              : _editUserProfileLogic
                                                          .getMenteeProfileModel
                                                          .data!
                                                          .user!
                                                          .imagePath ==
                                                      null
                                                  ? Image.asset(
                                                      'assets/images/upload_pic_holder.png',
                                                      fit: BoxFit.fill,
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      child: Image.network(
                                                        _editUserProfileLogic
                                                                .getMenteeProfileModel
                                                                .data!
                                                                .user!
                                                                .imagePath!
                                                                .contains(
                                                                    'assets')
                                                            ? '$mediaUrl${_editUserProfileLogic.getMenteeProfileModel.data!.user!.imagePath}'
                                                            : '${_editUserProfileLogic.getMenteeProfileModel.data!.user!.imagePath}',
                                                        fit: BoxFit.cover,
                                                      ))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: Image.file(
                                                _editUserProfileLogic
                                                    .profileImage!,
                                                fit: BoxFit.cover,
                                              )),
                                    ),
                                  ),
                                  SizedBox(height: 25.h),

                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.w, 0.h, 16.w, 16.h),
                                    child: Row(
                                      children: [
                                        Text('Hide Profile'.toUpperCase(),
                                            style: state.hideTextStyle),
                                        const Spacer(),
                                        Switch(
                                            activeColor: customThemeColor,
                                            value: _editUserProfileLogic
                                                .profileHiddenSwitch!,
                                            onChanged: (bool? newValue) {
                                              _editUserProfileLogic
                                                  .updateProfileHiddenSwitch(
                                                      newValue);
                                              _generalController
                                                  .updateFormLoaderController(
                                                      true);
                                              postMethod(
                                                  context,
                                                  changeProfileVisibilityUrl,
                                                  {
                                                    'token': '123',
                                                    'user_id': Get.find<
                                                            GeneralController>()
                                                        .storageBox
                                                        .read('userID'),
                                                    'visibility':
                                                        newValue! ? true : false
                                                  },
                                                  true,
                                                  getProfileVisibilityRepo);
                                            })
                                      ],
                                    ),
                                  ),

                                  ///---first-name
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.w, 0.h, 16.w, 16.h),
                                    child: TextFormField(
                                      controller: _editUserProfileLogic
                                          .firstNameController,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[a-zA-Z ]"))
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                25.w, 15.h, 25.w, 15.h),
                                        hintText: LanguageConstant.firstName.tr,
                                        hintStyle: state.hintTextStyle,
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant
                                              .fieldRequired.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),

                                  ///---last-name
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.w, 0.h, 16.w, 16.h),
                                    child: TextFormField(
                                      controller: _editUserProfileLogic
                                          .lastNameController,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[a-zA-Z ]"))
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                25.w, 15.h, 25.w, 15.h),
                                        hintText: LanguageConstant.lastName.tr,
                                        hintStyle: state.hintTextStyle,
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant
                                              .fieldRequired.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),

                                  ///---gender
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.w, 0.h, 16.w, 16.h),
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
                                            LanguageConstant.gender.tr,
                                            style: state.hintTextStyle,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.w, 14.h, 15.w, 14.h),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color:
                                                        customLightThemeColor)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.red)),
                                          ),
                                          isExpanded: true,
                                          focusColor: Colors.white,
                                          style: state.textFieldTextStyle,
                                          iconEnabledColor: customThemeColor,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          iconSize: 25,
                                          value: _editUserProfileLogic
                                                      .selectedGender ==
                                                  null
                                              ? _editUserProfileLogic
                                                  .selectedGender
                                              : _editUserProfileLogic
                                                  .selectedGender
                                                  .toString()
                                                  .capitalize,
                                          items: _editUserProfileLogic
                                              .genderDropDownList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: state.textFieldTextStyle,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            _editUserProfileLogic
                                                .selectedGender = value;
                                            _editUserProfileLogic.update();
                                          },
                                          validator: (String? value) {
                                            if (value == null) {
                                              return LanguageConstant
                                                  .fieldRequired.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  ///---city-country
                                  Row(
                                    children: [
                                      ///---country
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.w, 0.h, 8.w, 16.h),
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField<
                                                  String>(
                                                onTap: () {
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);
                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }
                                                },
                                                hint: Text(
                                                  LanguageConstant.country.tr,
                                                  style: state.hintTextStyle,
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(15.w, 14.h,
                                                              15.w, 14.h),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide: const BorderSide(
                                                          color:
                                                              customLightThemeColor)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                ),
                                                isExpanded: true,
                                                focusColor: Colors.white,
                                                style: state.textFieldTextStyle,
                                                iconEnabledColor:
                                                    customThemeColor,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                iconSize: 25,
                                                value: _editUserProfileLogic
                                                    .selectedCountry,
                                                items: _editUserProfileLogic
                                                    .countryDropDownList
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: state
                                                          .textFieldTextStyle,
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  _editUserProfileLogic
                                                      .selectedCountry = value;
                                                  _editUserProfileLogic
                                                      .update();
                                                  Get.find<GeneralController>()
                                                      .updateFormLoaderController(
                                                          true);
                                                  getMethod(
                                                      context,
                                                      getCitiesByIdUrl,
                                                      {
                                                        'token': '123',
                                                        'country_id': _editUserProfileLogic
                                                            .menteeProfileGenericDataModel
                                                            .data!
                                                            .countries![_editUserProfileLogic
                                                                .countryDropDownList
                                                                .indexOf(
                                                                    _editUserProfileLogic
                                                                        .selectedCountry!)]
                                                            .id
                                                      },
                                                      false,
                                                      getCitiesRepo);
                                                },
                                                validator: (String? value) {
                                                  if (value == null) {
                                                    return LanguageConstant
                                                        .fieldRequired.tr;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///---city
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.w, 0.h, 16.w, 16.h),
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField<
                                                  String>(
                                                onTap: () {
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);
                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }
                                                },
                                                hint: Text(
                                                  LanguageConstant.city.tr,
                                                  style: state.hintTextStyle,
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(15.w, 14.h,
                                                              15.w, 14.h),
                                                  fillColor: Colors.white,
                                                  enabled: true,
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide: const BorderSide(
                                                          color:
                                                              customLightThemeColor)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                ),
                                                isExpanded: true,
                                                focusColor: Colors.white,
                                                style: state.textFieldTextStyle,
                                                iconEnabledColor:
                                                    customThemeColor,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                iconSize: 25,
                                                value: _editUserProfileLogic
                                                    .selectedCity,
                                                items: _editUserProfileLogic
                                                    .cityDropDownList
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: state
                                                          .textFieldTextStyle,
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  _editUserProfileLogic
                                                      .selectedCity = value;
                                                  _editUserProfileLogic
                                                      .update();
                                                },
                                                validator: (String? value) {
                                                  if (value == null) {
                                                    return LanguageConstant
                                                        .fieldRequired.tr;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.h,
                            left: 15.w,
                            right: 15.w,
                            child: InkWell(
                              onTap: () {
                                _generalController.focusOut(context);
                                if (_profileFormKey.currentState!.validate()) {
                                  if (_editUserProfileLogic.profileImage !=
                                      null) {
                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    menteeUpdateProfileImageRepo(
                                        _editUserProfileLogic.profileImage);
                                  } else if (_editUserProfileLogic
                                              .getMenteeProfileModel
                                              .data!
                                              .user!
                                              .imagePath !=
                                          null &&
                                      _editUserProfileLogic.profileImage ==
                                          null) {
                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    postMethod(
                                        context,
                                        updateMenteeProfileUrl,
                                        {
                                          'token': '123',
                                          'user_id':
                                              Get.find<GeneralController>()
                                                  .storageBox
                                                  .read('userID'),
                                          'first_name': _editUserProfileLogic
                                              .firstNameController.text,
                                          'last_name': _editUserProfileLogic
                                              .lastNameController.text,
                                          'gender': _editUserProfileLogic
                                              .selectedGender,
                                          'country': _editUserProfileLogic
                                              .menteeProfileGenericDataModel
                                              .data!
                                              .countries![_editUserProfileLogic
                                                  .countryDropDownList
                                                  .indexOf(_editUserProfileLogic
                                                      .selectedCountry!)]
                                              .id,
                                          'city': _editUserProfileLogic
                                              .selectedCity,
                                        },
                                        true,
                                        menteeUpdateProfileRepo);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            title: LanguageConstant.sorry.tr,
                                            titleColor: customDialogErrorColor,
                                            descriptions: LanguageConstant
                                                .uploadYourProfilePicture.tr.tr,
                                            text: LanguageConstant.ok.tr,
                                            functionCall: () {
                                              Navigator.pop(context);
                                            },
                                            img:
                                                'assets/Icons/dialog_error.svg',
                                          );
                                        });
                                  }
                                }
                              },
                              child: MyCustomBottomBar(
                                title: LanguageConstant.update.tr,
                                disable: false,
                              ),
                            ),
                          )
                        ]),
                )),
          ),
        );
      });
    });
  }

  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      Get.find<EditUserProfileLogic>().profileImagesList = [];
                    });
                    Get.find<EditUserProfileLogic>().profileImagesList.add(
                        await ImagePickerGC.pickImage(
                            enableCloseButton: true,
                            context: context,
                            source: ImgSource.Camera,
                            barrierDismissible: true,
                            imageQuality: 10,
                            maxWidth: 400,
                            maxHeight: 600));
                    setState(() {
                      Get.find<EditUserProfileLogic>().profileImage = File(
                          Get.find<EditUserProfileLogic>()
                              .profileImagesList[0]
                              .path);
                    });
                  },
                  child: Text(
                    LanguageConstant.camera.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      Get.find<EditUserProfileLogic>().profileImagesList = [];
                    });
                    Get.find<EditUserProfileLogic>().profileImagesList.add(
                        await ImagePickerGC.pickImage(
                            enableCloseButton: true,
                            context: context,
                            source: ImgSource.Gallery,
                            barrierDismissible: true,
                            imageQuality: 10,
                            maxWidth: 400,
                            maxHeight: 600));
                    setState(() {
                      Get.find<EditUserProfileLogic>().profileImage = File(
                          Get.find<EditUserProfileLogic>()
                              .profileImagesList[0]
                              .path);
                    });
                  },
                  child: Text(
                    LanguageConstant.gallery.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18),
                  )),
            ],
          );
        });
  }
}
