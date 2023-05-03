import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/login/repo.dart';
import 'package:ista_app/src/modules/sign_up/logic.dart';
import 'package:ista_app/src/modules/sign_up/repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_app_bar.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resize/resize.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  /// Google
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      if (googleSignInAuthentication?.accessToken == null) {
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      postMethod(
          context,
          loginWithGoogleURL,
          {
            'email': user!.email,
            'name': user.displayName,
            'role': logic.selectedRole,
            'id': user.uid,
          },
          false,
          loginWithEmailRepo);
    } catch (e) {
      print('Google Login Error: $e');
    }
  }

  final logic = Get.put(SignUpLogic());

  final state = Get.find<SignUpLogic>().state;

  bool? obscureText = true;
  bool? confirmObscureText = true;

  final GlobalKey<FormState> _signUpFormKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<SignUpLogic>(builder: (_signUpLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            inAsyncCall: _generalController.formLoaderController,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/loginBackground.png',
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                    right: 0,
                    top: 0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///---appBar
                      const MyCustomAppBar(
                        drawerShow: false,
                        whiteBackground: true,
                      ),

                      ///---body
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0, 16.w, 0.h),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Form(
                                  key: _signUpFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageConstant.signUp.tr,
                                        style: state.headingTextStyle,
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        LanguageConstant
                                            .welcomToCreateYourAccount.tr,
                                        style: state.captionTextStyle,
                                      ),

                                      SizedBox(height: 25.h),

                                      ///---role-tabs
                                      Center(
                                        child: Container(
                                          height: 34.h,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: customTextFieldColor),
                                          child: TabBar(
                                              onTap: (index) {
                                                if (index == 0) {
                                                  _signUpLogic.selectedRole =
                                                      'Mentee';
                                                  _signUpLogic.update();
                                                } else {
                                                  _signUpLogic.selectedRole =
                                                      'Mentor';
                                                  _signUpLogic.update();
                                                }
                                              },
                                              indicator: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6
                                                          .r), // Creates border
                                                  color: customThemeColor),
                                              indicatorSize:
                                                  TabBarIndicatorSize.tab,
                                              automaticIndicatorColorAdjustment:
                                                  true,
                                              controller:
                                                  _signUpLogic.tabController,
                                              labelColor: Colors.white,
                                              unselectedLabelColor:
                                                  customThemeColor,
                                              indicatorColor:
                                                  Colors.transparent,
                                              tabs: _signUpLogic
                                                  .signupRoleTabList),
                                        ),
                                      ),

                                      SizedBox(height: 40.h),
                                      Text(
                                        LanguageConstant.enterDetails.tr,
                                        style: state.subHeadingTextStyle,
                                      ),
                                      SizedBox(height: 25.h),

                                      ///---first-name-field
                                      TextFormField(
                                        controller:
                                            _signUpLogic.firstNameController,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-z A-Z ]"))
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          hintText:
                                              LanguageConstant.firstName.tr,
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---last-name-field
                                      TextFormField(
                                        controller:
                                            _signUpLogic.lastNameController,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-z A-Z ]"))
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          hintText:
                                              LanguageConstant.lastName.tr,
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---email-field
                                      TextFormField(
                                        controller:
                                            _signUpLogic.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    25.w, 15.h, 25.w, 15.h),
                                            hintText: LanguageConstant
                                                .emailAddress.tr,
                                            hintStyle: state.hintTextStyle,
                                            fillColor: customTextFieldColor,
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
                                                borderSide: const BorderSide(color: customLightThemeColor)),
                                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                                            errorText: _signUpLogic.emailValidator),
                                        onChanged: (value) {
                                          _signUpLogic.emailValidator = null;
                                          _signUpLogic.update();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else if (!GetUtils.isEmail(value)) {
                                            return LanguageConstant
                                                .enterValidEmail.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---password-field

                                      TextFormField(
                                        controller:
                                            _signUpLogic.passwordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: obscureText!,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                obscureText = !obscureText!;
                                              });
                                            },
                                            child: Icon(
                                                obscureText!
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 20,
                                                color: const Color(0xff8085BA)),
                                          ),
                                          hintText:
                                              LanguageConstant.password.tr,
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),

                                      SizedBox(height: 20.h),

                                      ///---confirm-password-field

                                      TextFormField(
                                        controller: _signUpLogic
                                            .confirmPasswordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: confirmObscureText!,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                confirmObscureText =
                                                    !confirmObscureText!;
                                              });
                                            },
                                            child: Icon(
                                                confirmObscureText!
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 20,
                                                color: const Color(0xff8085BA)),
                                          ),
                                          hintText: LanguageConstant
                                              .confirmPassword.tr,
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .055),

                                      ///---signup-button
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: InkWell(
                                            onTap: () {
                                              if (_signUpFormKey.currentState!
                                                  .validate()) {
                                                _generalController
                                                    .updateFormLoaderController(
                                                        true);
                                                postMethod(
                                                    context,
                                                    signUpWithEmailURL,
                                                    {
                                                      'first_name': _signUpLogic
                                                          .firstNameController
                                                          .text,
                                                      'last_name': _signUpLogic
                                                          .lastNameController
                                                          .text,
                                                      'email': _signUpLogic
                                                          .emailController.text,
                                                      'password': _signUpLogic
                                                          .passwordController
                                                          .text,
                                                      'password_confirmation':
                                                          _signUpLogic
                                                              .confirmPasswordController
                                                              .text,
                                                      'role': _signUpLogic
                                                          .selectedRole
                                                    },
                                                    false,
                                                    signUpWithEmailRepo);
                                              }
                                            },
                                            child: MyCustomBottomBar(
                                                title:
                                                    LanguageConstant.signUp.tr,
                                                disable: false)),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .04),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.orSignUpWith.tr,
                                            style: state.orTextStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 28.h),

                                      ///---social-buttons
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ///---google-button
                                          InkWell(
                                            onTap: () async {
                                              await loginWithGoogle();
                                            },
                                            child: Container(
                                              height: 57.h,
                                              width: 57.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            customLightThemeColor
                                                                .withOpacity(
                                                                    0.2),
                                                        spreadRadius: 1,
                                                        blurRadius: 30,
                                                        offset:
                                                            const Offset(0, 15))
                                                  ]),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      'assets/Icons/googleIcon.svg')),
                                            ),
                                          ),
                                          SizedBox(width: 17.w),
                                        ],
                                      ),

                                      SizedBox(height: 30.h),

                                      ///---signup-route
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.haveAnAccount.tr,
                                            style: state.descTextStyle,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5.h, 0, 5.h),
                                              child: Text(
                                                LanguageConstant.letsLogin.tr,
                                                style: state.descTextStyle!
                                                    .copyWith(
                                                        color: customThemeColor,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---T&C
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant
                                                .bySignUpYouAreAgreeWith.tr,
                                            style: state.descTextStyle,
                                          ),
                                          Text(
                                            LanguageConstant
                                                .termsAndConditions.tr,
                                            style: state.descTextStyle!
                                                .copyWith(
                                                    color:
                                                        customLightThemeColor,
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        );
      });
    });
  }
}
