import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_profile/logic.dart';
import 'package:ista_app/src/modules/consultant/create_profile/repos/repo_post.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class AccountInfoView extends StatefulWidget {
  const AccountInfoView({Key? key}) : super(key: key);

  @override
  _AccountInfoViewState createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  final state = Get.find<CreateProfileLogic>().state;

  final GlobalKey<FormState> _accountInfoFormKey = GlobalKey();

  final TextEditingController _accountTitleController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

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
                key: _accountInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///---bank
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
                              LanguageConstant.bank.tr.capitalizeFirst!,
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
                            value: _createProfileLogic.selectedBank,
                            items: _createProfileLogic.bankDropDownList
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
                              setState(() {
                                _createProfileLogic.selectedBank = value;
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

                    ///---account-title-field
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 16.h),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-z A-Z ]"))
                        ],
                        style: state.textFieldTextStyle,
                        controller: _accountTitleController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              25.w, 15.h, 25.w, 15.h),
                          hintText: LanguageConstant
                              .accountTitle.tr.tr.capitalizeFirst,
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

                    ///---account-number-field
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 16.h),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                        ],
                        style: state.textFieldTextStyle,
                        controller: _accountNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              25.w, 15.h, 25.w, 15.h),
                          hintText:
                              LanguageConstant.accountNumber.tr.capitalizeFirst,
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
                  ],
                ),
              )),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                child: InkWell(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (_accountInfoFormKey.currentState!.validate()) {
                        Get.find<GeneralController>()
                            .updateFormLoaderController(true);

                        setState(() {
                          _createProfileLogic
                              .stepperList[_createProfileLogic.stepperIndex!]
                              .isSelected = false;
                          _createProfileLogic
                              .stepperList[_createProfileLogic.stepperIndex!]
                              .isCompleted = true;
                        });
                        postMethod(
                            context,
                            mentorAccountInfoUrl,
                            {
                              'token': '123',
                              'mentor_id': Get.find<GeneralController>()
                                  .storageBox
                                  .read('userID'),
                              'account_title': _accountTitleController.text,
                              'account_number': _accountNumberController.text,
                              'bank': _createProfileLogic.selectedBank,
                            },
                            true,
                            mentorAccountInfoRepo);
                      }
                    },
                    child: MyCustomBottomBar(
                        title: LanguageConstant.saveNext.tr, disable: false)),
              )),
        ),
      ),
    );
  }
}
