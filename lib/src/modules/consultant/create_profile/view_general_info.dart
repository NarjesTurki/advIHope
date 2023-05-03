import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/header.dart';
import 'package:ista_app/src/api_services/logic.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/logic.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_post_general_info.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/get_repo.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/repo_post.dart';
import 'package:ista_app/src/modules/consultant/create_profile/view_location_picker.dart';
import 'package:ista_app/src/modules/image_full_view/view.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:ista_app/src/widgets/upload_image_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'models/place_service.dart';

class GeneralInfoView extends StatefulWidget {
  const GeneralInfoView({Key? key}) : super(key: key);

  @override
  _GeneralInfoViewState createState() => _GeneralInfoViewState();
}

class _GeneralInfoViewState extends State<GeneralInfoView> {
  final state = Get.find<CreateProfileLogic>().state;

  final GlobalKey<FormState> _generalInfoFormKey = GlobalKey();

  File? profileImage;
  List profileImagesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoaderController(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
        builder: (_generalController) => GetBuilder<CreateProfileLogic>(
              builder: (_createProfileLogic) => ModalProgressHUD(
                progressIndicator: const CircularProgressIndicator(
                  color: customThemeColor,
                ),
                inAsyncCall: _generalController.formLoaderController,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: customTextFieldColor,
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _generalInfoFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///---picture
                              profileImage == null
                                  ? _createProfileLogic
                                              .generalInfoPostModel.data ==
                                          null
                                      ? InkWell(
                                          onTap: () {
                                            imagePickerDialog(context);
                                          },
                                          child: const UploadImageButton())
                                      : Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 25.h),
                                            child: SizedBox(
                                              height: 103.h,
                                              width: 190.w,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    _createProfileLogic
                                                            .generalInfoPostModel
                                                            .data!
                                                            .userDetail!
                                                            .imagePath!
                                                            .contains('assets')
                                                        ? '$mediaUrl${_createProfileLogic.generalInfoPostModel.data!.userDetail!.imagePath}'
                                                        : '${_createProfileLogic.generalInfoPostModel.data!.userDetail!.imagePath}',
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                        )
                                  : InkWell(
                                      onTap: () {
                                        changeImagePickerDialog(
                                            context, null, false, profileImage);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 25.h),
                                          child: SizedBox(
                                            height: 103.h,
                                            width: 190.w,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.file(
                                                  profileImage!,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),

                              ///---first-name-field
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-z A-Z ]"))
                                  ],
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.firstNameController,
                                  keyboardType: TextInputType.name,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///---last-name-field
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-z A-Z ]"))
                                  ],
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.lastNameController,
                                  keyboardType: TextInputType.name,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///---father-name-field
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-z A-Z ]"))
                                  ],
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.fatherNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: LanguageConstant.fatherName.tr,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///---cnic-field
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  inputFormatters: const [],
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.cnicController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: LanguageConstant.enterCNIC.tr,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///---address-field
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  readOnly: false,
                                  onTap: () async {
                                    final sessionToken = const Uuid().v4();
                                    final Suggestion? result = await showSearch(
                                      context: context,
                                      delegate: AddressSearch(sessionToken),
                                    );

                                    if (result != null) {
                                      // log('RESULT---->>>${result.description.toString().split(', ')[2]}');
                                      final placeDetails =
                                          await PlaceApiProvider(sessionToken)
                                              .getPlaceDetailFromId(
                                                  result.placeId);

                                      await _createProfileLogic.saveData(
                                          latLong: json.encode({
                                            'lat': placeDetails['lat'],
                                            'lng': placeDetails['lng']
                                          }),
                                          place: result.description);
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(200)
                                  ],
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.addressController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: LanguageConstant.enterAddress.tr,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///---about-field
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  inputFormatters: const [],
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.aboutController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: 'About Your Self',
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///---gender-religion
                              Row(
                                children: [
                                  ///---gender
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.w, 0, 8.w, 16.h),
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<String>(
                                            onTap: () {
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);
                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                            },
                                            hint: Text(
                                              LanguageConstant.gender.tr,
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
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
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
                                            value: _createProfileLogic
                                                .selectedGender,
                                            items: _createProfileLogic
                                                .genderDropDownList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                      state.textFieldTextStyle,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _createProfileLogic
                                                    .selectedGender = value;
                                              });
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

                                  ///---religion
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.w, 0, 15.w, 16.h),
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<String>(
                                            onTap: () {
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);
                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                            },
                                            hint: Text(
                                              LanguageConstant.religion.tr,
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
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
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
                                            value: _createProfileLogic
                                                .selectedReligion,
                                            items: _createProfileLogic
                                                .religionDropDownList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                      state.textFieldTextStyle,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _createProfileLogic
                                                    .selectedReligion = value;
                                              });
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

                              ///---dob-occupation
                              Row(
                                children: [
                                  ///---dob
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.w, 0, 8.w, 16.h),
                                      child: Theme(
                                        data: ThemeData(
                                            colorScheme:
                                                ColorScheme.fromSwatch()
                                                    .copyWith(
                                                        primary:
                                                            customThemeColor)),
                                        child: DateTimeField(
                                          style: state.textFieldTextStyle,
                                          decoration: InputDecoration(
                                              hintText: LanguageConstant.dob.tr,
                                              hintStyle: state.hintTextStyle,
                                              contentPadding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      25.w, 15.h, 15.w, 15.h),
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(15.0),
                                                child: SvgPicture.asset(
                                                  'assets/Icons/calendarIcon.svg',
                                                ),
                                              )),
                                          initialValue:
                                              _createProfileLogic.selectedDob,
                                          format: DateFormat('dd-MM-yyyy'),
                                          onShowPicker:
                                              (context, currentValue) async {
                                            final date = await showDatePicker(
                                                context: context,
                                                firstDate: DateTime(1900),
                                                initialDate: currentValue ??
                                                    DateTime.now(),
                                                lastDate: DateTime.now());
                                            if (date != null) {
                                              return date;
                                            } else {
                                              return currentValue;
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return LanguageConstant
                                                  .fieldRequired.tr;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _createProfileLogic.selectedDob =
                                                  value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  ///---occupation
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.w, 0, 15.w, 16.h),
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<String>(
                                            onTap: () {
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);
                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                            },
                                            hint: Text(
                                              LanguageConstant.occupation.tr,
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
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
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
                                            value: _createProfileLogic
                                                .selectedOccupation,
                                            items: _createProfileLogic
                                                .occupationDropDownList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  // softWrap: true,overflow: TextOverflow.ellipsis,maxLines: 1,
                                                  style:
                                                      state.textFieldTextStyle,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _createProfileLogic
                                                    .selectedOccupation = value;
                                              });
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

                              ///---country-city
                              Row(
                                children: [
                                  ///---country
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.w, 0, 8.w, 16.h),
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<String>(
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
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
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
                                            value: _createProfileLogic
                                                .selectedCountry,
                                            items: _createProfileLogic
                                                .countryDropDownList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                      state.textFieldTextStyle,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _createProfileLogic
                                                    .selectedCountry = value;
                                              });
                                              Get.find<GeneralController>()
                                                  .updateFormLoaderController(
                                                      true);
                                              getMethod(
                                                  context,
                                                  getCitiesByIdUrl,
                                                  {
                                                    'token': '123',
                                                    'country_id': _createProfileLogic
                                                        .mentorProfileGenericDataModel
                                                        .data!
                                                        .countries![_createProfileLogic
                                                            .countryDropDownList
                                                            .indexOf(
                                                                _createProfileLogic
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.w, 0, 15.w, 16.h),
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<String>(
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
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
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
                                            value: _createProfileLogic
                                                .selectedCity,
                                            items: _createProfileLogic
                                                .cityDropDownList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                      state.textFieldTextStyle,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _createProfileLogic
                                                    .selectedCity = value;
                                              });
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

                              ///Facebook
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.facebookUrlController,
                                  keyboardType: TextInputType.url,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: LanguageConstant.facebook.tr,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///Instagram
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  style: state.textFieldTextStyle,
                                  controller: _createProfileLogic
                                      .instagramUrlController,
                                  keyboardType: TextInputType.url, //ena
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: LanguageConstant.instagram.tr,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              ///Tiktok
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  style: state.textFieldTextStyle,
                                  controller:
                                      _createProfileLogic.tiktokUrlController,
                                  keyboardType: TextInputType.url, //ena
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: LanguageConstant.tiktok.tr,
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                    child: InkWell(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (_generalInfoFormKey.currentState!.validate()) {
                            if (profileImage != null) {
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              mentorGeneralInfoRepo(profileImage);
                            } else if (_createProfileLogic
                                        .generalInfoPostModel.data !=
                                    null &&
                                profileImage == null) {
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  mentorGeneralInfoPostUrl,
                                  {
                                    'token': '123',
                                    'mentor_id': Get.find<GeneralController>()
                                        .storageBox
                                        .read('userID'),
                                    'first_name': _createProfileLogic
                                        .firstNameController.text,
                                    'last_name': _createProfileLogic
                                        .lastNameController.text,
                                    'father_name': _createProfileLogic
                                        .fatherNameController.text,
                                    'cnic':
                                        _createProfileLogic.cnicController.text,
                                    'address': _createProfileLogic
                                        .addressController.text,
                                    'about': _createProfileLogic
                                        .aboutController.text,
                                    'gender':
                                        _createProfileLogic.selectedGender,
                                    'religion':
                                        _createProfileLogic.selectedReligion,
                                    'dob': DateFormat('yyyy-MM-dd')
                                        .format(
                                            _createProfileLogic.selectedDob!)
                                        .toString(),
                                    'occupation': _createProfileLogic
                                        .mentorProfileGenericDataModel
                                        .data!
                                        .occupations![_createProfileLogic
                                            .occupationDropDownList
                                            .indexOf(_createProfileLogic
                                                .selectedOccupation!)]
                                        .id,
                                    'country': _createProfileLogic
                                        .mentorProfileGenericDataModel
                                        .data!
                                        .countries![_createProfileLogic
                                            .countryDropDownList
                                            .indexOf(_createProfileLogic
                                                .selectedCountry!)]
                                        .id,
                                    'city': _createProfileLogic.selectedCity,
                                    'facebookUrl': _createProfileLogic
                                        .facebookUrlController.text,
                                    'instagramUrl': _createProfileLogic
                                        .instagramUrlController.text,
                                    'tiktokUrl': _createProfileLogic
                                        .tiktokUrlController.text,
                                  },
                                  true,
                                  mentorGeneralInfo2Repo);
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: LanguageConstant.sorry.tr,
                                      titleColor: customDialogErrorColor,
                                      descriptions: LanguageConstant
                                          .uploadYourProfilePicture.tr,
                                      text: LanguageConstant.ok.tr,
                                      functionCall: () {
                                        Navigator.pop(context);
                                      },
                                      img: 'assets/Icons/dialog_error.svg',
                                    );
                                  });
                            }
                          }
                        },
                        child: MyCustomBottomBar(
                            title: LanguageConstant.nextStep.tr,
                            disable: false)),
                  ),
                ),
              ),
            ));
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
                      profileImagesList = [];
                    });
                    profileImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (profileImagesList.isNotEmpty) {
                      setState(() {
                        profileImage = File(profileImagesList[0].path);
                      });
                    }
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
                      profileImagesList = [];
                    });
                    profileImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (profileImagesList.isNotEmpty) {
                      setState(() {
                        profileImage = File(profileImagesList[0].path);
                      });
                    }
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

  void changeImagePickerDialog(
      BuildContext context, String? image, bool? isNetwork, File? fileImage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                    if (isNetwork!) {
                      Get.to(ImageViewScreen(
                        networkImage: image,
                      ));
                    } else {
                      Get.to(ImageViewScreen(
                        fileImage: fileImage,
                      ));
                    }
                  },
                  child: Text(
                    LanguageConstant.view.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    imagePickerDialog(context);
                  },
                  child: Text(
                    LanguageConstant.change.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18),
                  )),
            ],
          );
        });
  }

  mentorGeneralInfoRepo(File? file1) async {
    dio_instance.FormData formData =
        dio_instance.FormData.fromMap(<String, dynamic>{
      'token': '123',
      'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
      'first_name': Get.find<CreateProfileLogic>().firstNameController.text,
      'last_name': Get.find<CreateProfileLogic>().lastNameController.text,
      'father_name': Get.find<CreateProfileLogic>().fatherNameController.text,
      'cnic': Get.find<CreateProfileLogic>().cnicController.text,
      // 'email': Get.find<CreateProfileLogic>().emailController.text,
      'address': Get.find<CreateProfileLogic>().addressController.text,
      'about': Get.find<CreateProfileLogic>().aboutController.text,
      'gender': Get.find<CreateProfileLogic>().selectedGender,
      'religion': Get.find<CreateProfileLogic>().selectedReligion,
      'dob': DateFormat('yyyy-MM-dd')
          .format(Get.find<CreateProfileLogic>().selectedDob!)
          .toString(),
      'occupation': Get.find<CreateProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .occupations![Get.find<CreateProfileLogic>()
              .occupationDropDownList
              .indexOf(Get.find<CreateProfileLogic>().selectedOccupation!)]
          .id,
      'country': Get.find<CreateProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .countries![Get.find<CreateProfileLogic>()
              .countryDropDownList
              .indexOf(Get.find<CreateProfileLogic>().selectedCountry!)]
          .id,
      'city': Get.find<CreateProfileLogic>().selectedCity,
      'picture': await dio_instance.MultipartFile.fromFile(
        file1!.path,
      )
    });
    dio_instance.Dio dio = dio_instance.Dio();
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
    dio_instance.Response response;
    try {
      response = await dio.post(mentorGeneralInfoPostUrl, data: formData);

      if (response.statusCode == 200) {
        Get.find<CreateProfileLogic>().generalInfoPostModel =
            GeneralInfoPostModel.fromJson(response.data);
        if (Get.find<CreateProfileLogic>().generalInfoPostModel.status ==
            true) {
          Get.find<CreateProfileLogic>()
              .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
              .isSelected = false;
          Get.find<CreateProfileLogic>()
              .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
              .isCompleted = true;
          Get.find<CreateProfileLogic>()
              .stepperList[Get.find<CreateProfileLogic>().stepperIndex! + 1]
              .isSelected = true;
          Get.find<CreateProfileLogic>().updateStepperIndex(1);
          Get.snackbar('${LanguageConstant.profileUpdatedSuccessfully.tr}!', '',
              colorText: Colors.black, backgroundColor: Colors.white);
          Get.find<GeneralController>().updateFormLoaderController(false);
        } else {
          Get.find<GeneralController>().updateFormLoaderController(false);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: LanguageConstant.failed.tr,
                  titleColor: customDialogErrorColor,
                  descriptions:
                      '${Get.find<CreateProfileLogic>().generalInfoPostModel.msg}',
                  text: LanguageConstant.ok.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_error.svg',
                );
              });
        }
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: LanguageConstant.failed.tr,
                titleColor: customDialogErrorColor,
                descriptions: LanguageConstant.tryAgain.tr,
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
    } on dio_instance.DioError catch (e) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: customDialogErrorColor,
              descriptions: LanguageConstant.tryAgain.tr,
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
      log('ResponseError $mentorGeneralInfoPostUrl-->> ${e.response!.data}');
    }
  }
}
