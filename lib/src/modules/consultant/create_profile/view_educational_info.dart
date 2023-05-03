import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/header.dart';
import 'package:ista_app/src/api_services/logic.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/logic.dart';
import 'package:ista_app/src/modules/consultant/create_profile/models/model_post_education_info.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/get_delete.dart';
import 'package:ista_app/src/modules/image_full_view/view.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:ista_app/src/widgets/upload_image_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:resize/resize.dart';

class EducationalInfoView extends StatefulWidget {
  const EducationalInfoView({Key? key}) : super(key: key);

  @override
  _EducationalInfoViewState createState() => _EducationalInfoViewState();
}

class _EducationalInfoViewState extends State<EducationalInfoView> {
  final state = Get.find<CreateProfileLogic>().state;

  final GlobalKey<FormState> _educationalInfoFormKey = GlobalKey();

  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  File? degreeImage;
  List degreeImagesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              backgroundColor: customTextFieldColor,
              body: SingleChildScrollView(
                  child: Form(
                key: _educationalInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///---institution-field
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.w, 25.h, 15.w, 16.h),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-z A-Z ]"))
                        ],
                        style: state.textFieldTextStyle,
                        controller: _institutionController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              25.w, 15.h, 25.w, 15.h),
                          hintText: LanguageConstant.institute.tr,
                          hintStyle: state.hintTextStyle,
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: customLightThemeColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Colors.red)),
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

                    ///---degree-subject
                    Row(
                      children: [
                        ///---degree
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.w, 0, 8.w, 16.h),
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
                                    LanguageConstant.degree.tr,
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
                                            color: customLightThemeColor)),
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
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 25,
                                  value: _createProfileLogic.selectedDegree,
                                  items: _createProfileLogic.degreeDropDownList
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
                                    setState(() {
                                      _createProfileLogic.selectedDegree =
                                          value;
                                    });
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
                        ),

                        ///---subject
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.w, 0, 15.w, 16.h),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z ]"))
                              ],
                              style: state.textFieldTextStyle,
                              controller: _subjectController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    25.w, 15.h, 25.w, 15.h),
                                hintText: LanguageConstant.subject.tr,
                                hintStyle: state.hintTextStyle,
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
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return LanguageConstant.fieldRequired.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///---year
                    Row(
                      children: [
                        ///---year
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.w, 0, 15.w, 16.h),
                            child: TextFormField(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        // Need to use container to add size constraint.
                                        width: 300,
                                        height: 300,
                                        child: Theme(
                                          data: ThemeData(
                                              colorScheme: ColorScheme
                                                      .fromSwatch()
                                                  .copyWith(
                                                      primary:
                                                          customThemeColor)),
                                          child: YearPicker(
                                            firstDate: DateTime(
                                                DateTime.now().year - 50, 1),
                                            lastDate: DateTime(
                                                DateTime.now().year, 1),

                                            // save the selected date to _selectedDate DateTime variable.
                                            // It's used to set the previous selected date when
                                            // re-showing the dialog.

                                            selectedDate: DateTime.now(),
                                            onChanged: (DateTime dateTime) {
                                              setState(() {
                                                _createProfileLogic
                                                        .selectedYear =
                                                    DateFormat('yyyy')
                                                        .format(dateTime);
                                                _yearController =
                                                    TextEditingController(
                                                        text:
                                                            _createProfileLogic
                                                                .selectedYear);
                                              });
                                              // close the dialog when year is selected.
                                              Navigator.pop(context);
                                              // Do something with the dateTime selected.
                                              // Remember that you need to use dateTime.year to get the year
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              readOnly: true,
                              controller: _yearController,
                              style: state.textFieldTextStyle,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    25.w, 15.h, 25.w, 15.h),
                                hintText: LanguageConstant.year.tr,
                                hintStyle: state.hintTextStyle,
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.all(15.0),
                                  child: SvgPicture.asset(
                                      'assets/Icons/calendarIcon.svg'),
                                ),
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
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return LanguageConstant.fieldRequired.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///---picture
                    degreeImage == null
                        ? InkWell(
                            onTap: () {
                              imagePickerDialog(context);
                            },
                            child: const UploadImageButton())
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 25.h),
                              child: SizedBox(
                                height: 103.h,
                                width: 190.w,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      degreeImage!,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),

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
                            if (_educationalInfoFormKey.currentState!
                                .validate()) {
                              if (degreeImage != null) {
                                Get.find<GeneralController>()
                                    .updateFormLoaderController(true);
                                mentorEducationInfoRepo(degreeImage);
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
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * .45,
                            decoration: BoxDecoration(
                                color: customLightThemeColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                '+${LanguageConstant.addEducation.tr}',
                                style: state.addButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///---added-record-preview
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15, 15, 15, 20),
                        child: Wrap(
                          children: List.generate(
                              _createProfileLogic
                                  .forDisplayEducationList!.length, (index) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 15, 0, 0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 15, 7, 15),
                                    child: Column(
                                      children: [
                                        ///---institution
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LanguageConstant
                                                        .institute.tr,
                                                    style: state
                                                        .previewLabelTextStyle,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '${_createProfileLogic.forDisplayEducationList![index].institute}',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: state
                                                        .previewValueTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  _generalController
                                                      .updateFormLoaderController(
                                                          true);
                                                  postMethod(
                                                      context,
                                                      mentorEducationalInfoDeleteUrl,
                                                      {
                                                        'token': '123',
                                                        'id': _createProfileLogic
                                                            .forDisplayEducationList![
                                                                index]
                                                            .id
                                                      },
                                                      true,
                                                      deleteEducationRepo);
                                                  _createProfileLogic
                                                      .forDisplayEducationList!
                                                      .removeAt(index);
                                                  setState(() {});
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .all(8.0),
                                                  child: SvgPicture.asset(
                                                      'assets/Icons/deleteIcon.svg'),
                                                ))
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 14,
                                        ),

                                        ///---degree-subject
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LanguageConstant.degree.tr,
                                                    style: state
                                                        .previewLabelTextStyle,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '${_createProfileLogic.forDisplayEducationList![index].degree}',
                                                    style: state
                                                        .previewValueTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LanguageConstant.subject.tr,
                                                    style: state
                                                        .previewLabelTextStyle,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '${_createProfileLogic.forDisplayEducationList![index].subject}',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: state
                                                        .previewValueTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 14,
                                        ),

                                        ///---degree-subject
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LanguageConstant.year.tr,
                                                    style: state
                                                        .previewLabelTextStyle,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '${_createProfileLogic.forDisplayEducationList![index].period}',
                                                    style: state
                                                        .previewValueTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            _createProfileLogic
                                                        .forDisplayEducationList![
                                                            index]
                                                        .imagePath !=
                                                    null
                                                ? Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(end: 8.w),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.to(ImageViewScreen(
                                                          networkImage: _createProfileLogic
                                                                  .forDisplayEducationList![
                                                                      index]
                                                                  .imagePath!
                                                                  .contains(
                                                                      'assets')
                                                              ? '$mediaUrl${_createProfileLogic.forDisplayEducationList![index].imagePath}'
                                                              : _createProfileLogic
                                                                  .forDisplayEducationList![
                                                                      index]
                                                                  .imagePath!,
                                                        ));
                                                      },
                                                      child: SizedBox(
                                                          height: 30.h,
                                                          width: 30.w,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.r),
                                                            child: Image.network(_createProfileLogic
                                                                    .forDisplayEducationList![
                                                                        index]
                                                                    .imagePath!
                                                                    .contains(
                                                                        'assets')
                                                                ? '$mediaUrl${_createProfileLogic.forDisplayEducationList![index].imagePath}'
                                                                : _createProfileLogic
                                                                    .forDisplayEducationList![
                                                                        index]
                                                                    .imagePath!),
                                                          )),
                                                    ),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          }),
                        )),
                  ],
                ),
              )),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                child: InkWell(
                    onTap: () {
                      if (_createProfileLogic
                          .forDisplayEducationList!.isNotEmpty) {
                        setState(() {
                          _createProfileLogic
                              .stepperList[_createProfileLogic.stepperIndex!]
                              .isSelected = false;
                          _createProfileLogic
                              .stepperList[_createProfileLogic.stepperIndex!]
                              .isCompleted = true;
                          _createProfileLogic
                              .stepperList[
                                  _createProfileLogic.stepperIndex! + 1]
                              .isSelected = true;
                          _createProfileLogic.updateStepperIndex(2);
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
                                    LanguageConstant.addEducationPlease.tr,
                                text: LanguageConstant.ok.tr,
                                functionCall: () {
                                  Navigator.pop(context);
                                },
                                img: 'assets/Icons/dialog_error.svg',
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
                      degreeImagesList = [];
                    });
                    degreeImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (degreeImagesList.isNotEmpty) {
                      setState(() {
                        degreeImage = File(degreeImagesList[0].path);
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
                      degreeImagesList = [];
                    });
                    degreeImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (degreeImagesList.isNotEmpty) {
                      setState(() {
                        degreeImage = File(degreeImagesList[0].path);
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

  mentorEducationInfoRepo(File? file1) async {
    dio_instance.FormData formData =
        dio_instance.FormData.fromMap(<String, dynamic>{
      'token': '123',
      'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
      'institute': _institutionController.text,
      'degree': Get.find<CreateProfileLogic>().selectedDegree,
      'subject': _subjectController.text,
      'period': _yearController.text,
      'image': await dio_instance.MultipartFile.fromFile(
        file1!.path,
      )
    });
    dio_instance.Dio dio = dio_instance.Dio();
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
    dio_instance.Response response;
    try {
      response = await dio.post(mentorEducationalInfoPostUrl, data: formData);

      if (response.statusCode == 200) {
        Get.find<CreateProfileLogic>().educationInfoPostModel =
            EducationInfoPostModel.fromJson(response.data);
        if (Get.find<CreateProfileLogic>().educationInfoPostModel.status ==
            true) {
          Get.find<CreateProfileLogic>().updateForDisplayEducationList(
              Get.find<CreateProfileLogic>()
                  .educationInfoPostModel
                  .data!
                  .education);
          Get.snackbar('${LanguageConstant.addedSuccessfully.tr}!', '',
              colorText: Colors.black, backgroundColor: Colors.white);

          Get.find<GeneralController>().updateFormLoaderController(false);
          setState(() {
            _institutionController.clear();
            _subjectController.clear();
            _yearController.clear();
            Get.find<CreateProfileLogic>().selectedDegree = null;
            degreeImage = null;
          });
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
      log('ResponseError $mentorEducationalInfoPostUrl-->> $e');
    }
  }
}
