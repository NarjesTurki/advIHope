import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/login/logic.dart';
import 'package:ista_app/src/modules/login/repo.dart';
import 'package:ista_app/src/modules/main_repo/main_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_app_bar.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:resize/resize.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final logic = Get.put(LoginLogic());

  final state = Get.find<LoginLogic>().state;
  bool? obscureText = true;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      if (googleSignInAuthentication?.accessToken == null) {
        // AppDialog().showOSDialog(context, “Error”, “User cancel sign up procedure”, “OK”, () {});
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      print('This is $credential');

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;
      print(user.toString());
      print(user!.displayName);
      print(user.email);
      print(user.uid);
      postMethod(
          context,
          loginWithGoogleURL,
          {
            'email': user.email,
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

  TextEditingController? textEditingController1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.tabController = TabController(length: 2, vsync: this);
    logic.loginTimerAnimationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {});
            }
          });

    Get.put(MainLogic());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GestureDetector(
        onTap: () {
          _generalController.focusOut(context);
        },
        child: GetBuilder<LoginLogic>(builder: (_loginLogic) {
          return ModalProgressHUD(
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
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.w, 0, 16.w, 0.h),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                key: _loginFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.login.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      LanguageConstant
                                          .welcomeBackToYourAccount.tr,
                                      style: state.captionTextStyle,
                                    ),
                                    SizedBox(height: 25.h),

                                    ///---role-tabs
                                    Center(
                                      child: Container(
                                        height: 34.h,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            color: customTextFieldColor),
                                        child: TabBar(
                                            onTap: (index) {
                                              if (index == 0) {
                                                _loginLogic.selectedRole =
                                                    'Mentee';
                                                _loginLogic.update();
                                              } else {
                                                _loginLogic.selectedRole =
                                                    'Mentor';
                                                _loginLogic.update();
                                              }
                                            },
                                            indicator: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.r), // Creates border
                                                color: customThemeColor),
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            automaticIndicatorColorAdjustment:
                                                true,
                                            controller:
                                                _loginLogic.tabController,
                                            labelColor: Colors.white,
                                            unselectedLabelColor:
                                                customThemeColor,
                                            indicatorColor: Colors.transparent,
                                            tabs: _loginLogic.loginRoleTabList),
                                      ),
                                    ),

                                    SizedBox(height: 40.h),
                                    Text(
                                      LanguageConstant.enterLoginDetails.tr,
                                      style: state.subHeadingTextStyle,
                                    ),
                                    SizedBox(height: 25.h),
                                    Get.find<GeneralController>()
                                                .storageBox
                                                .read('loginType') ==
                                            'phone'
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ///---view
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .4,
                                                child: Stack(
                                                  children: [
                                                    SingleChildScrollView(
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Form(
                                                          key: _loginLogic
                                                              .loginKey,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              /// OTP
                                                              ///---field-area
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        16,
                                                                        30,
                                                                        16,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // Text(
                                                                    //   'enter_your_phone'.tr,
                                                                    //   style: state.loginPhoneFieldTextStyle,
                                                                    // ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          DecoratedBox(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color(0xffF6F7FC),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            IntlPhoneField(
                                                                          initialCountryCode:
                                                                              'PK',
                                                                          controller:
                                                                              _loginLogic.loginTextEditingController,
                                                                          //  style: GoogleFonts.poppins(color: Colors.black),
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                          ],
                                                                          keyboardType:
                                                                              TextInputType.phone,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                const Color(0xffF6F7FC),
                                                                            floatingLabelBehavior:
                                                                                FloatingLabelBehavior.never,
                                                                            counterText:
                                                                                '',
                                                                            labelText:
                                                                                'phone_number'.tr,
                                                                            errorBorder:
                                                                                OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide.none,
                                                                            ),
                                                                          ),
                                                                          onChanged:
                                                                              (phone) {
                                                                            setState(() {
                                                                              _loginLogic.updateOtpSendCheckerLogin(false);
                                                                              _loginLogic.loginPhoneNumber = phone.completeNumber;
                                                                            });
                                                                            log('This is my number${phone.completeNumber}');
                                                                          },
                                                                          onCountryChanged:
                                                                              (Country phone) {
                                                                            _loginLogic.updateOtpSendCheckerLogin(false);
                                                                            _loginLogic.loginTextEditingController.clear();
                                                                            _loginLogic.loginPhoneNumber =
                                                                                null;
                                                                            setState(() {});
                                                                            log('Country code changed to: ' +
                                                                                phone.code);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),

                                                              _loginLogic
                                                                      .otpSendCheckerLogin
                                                                  ? Padding(
                                                                      padding: EdgeInsetsDirectional.only(
                                                                          bottom: MediaQuery.of(context)
                                                                              .viewInsets
                                                                              .bottom),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsetsDirectional.only(top: 15, bottom: 5),
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  if (_loginLogic.loginTimerAnimationController!.value == 0.0) {
                                                                                    setState(() {
                                                                                      _loginLogic.otpFunction(Get.find<LoginLogic>().loginPhoneNumber, context);
                                                                                      _loginLogic.loginTimerAnimationController!.reverse(from: _loginLogic.loginTimerAnimationController!.value == 0.0 ? 1.0 : _loginLogic.loginTimerAnimationController!.value);
                                                                                    });
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  ' resend_OTP_code'.tr,
                                                                                  style: _loginLogic.loginTimerAnimationController!.value != 0.0 ? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff727377)).copyWith(color: Colors.grey.withOpacity(0.5)) : const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff727377)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Center(
                                                                              child: OtpTimer(_loginLogic.loginTimerAnimationController!, 15.0, Colors.black)),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                16,
                                                                                15,
                                                                                16,
                                                                                0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  ' enter_OTP_code_below'.tr,
                                                                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                                                                  child: PinCodeTextField(
                                                                                    controller: textEditingController1,
                                                                                    appContext: context,
                                                                                    pastedTextStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
                                                                                    textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
                                                                                    length: 6,
                                                                                    blinkWhenObscuring: false,
                                                                                    animationType: AnimationType.fade,
                                                                                    validator: (v) {
                                                                                      if (v!.length < 6) {
                                                                                        return "enter_correct_pin".tr;
                                                                                      } else {
                                                                                        return null;
                                                                                      }
                                                                                    },
                                                                                    pinTheme: PinTheme(shape: PinCodeFieldShape.box, borderRadius: BorderRadius.circular(5), fieldHeight: 36, fieldWidth: 40, activeFillColor: Colors.white, disabledColor: Colors.white, activeColor: customThemeColor, inactiveFillColor: const Color(0xffF6F7FC), errorBorderColor: Colors.red, inactiveColor: customThemeColor, selectedFillColor: const Color(0xffF6F7FC), selectedColor: customThemeColor, borderWidth: 1),
                                                                                    cursorColor: Colors.black,
                                                                                    animationDuration: const Duration(milliseconds: 300),
                                                                                    enableActiveFill: true,
                                                                                    keyboardType: TextInputType.number,
                                                                                    onCompleted: (v) {
                                                                                      log("Completed");
                                                                                    },
                                                                                    onChanged: (value) {
                                                                                      log(value);
                                                                                      setState(() {
                                                                                        _loginLogic.loginOtp = value.toString();
                                                                                      });
                                                                                    },
                                                                                    beforeTextPaste: (text) {
                                                                                      log("Allowing to paste $text");
                                                                                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                                                                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                                                                      return true;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                10,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Center(
                                                                              child: InkWell(
                                                                                onTap: () {
                                                                                  Get.find<GeneralController>().updateFormLoaderController(true);
                                                                                  _loginLogic.verifyOTP(context, _loginLogic.loginOtp, false);
                                                                                },
                                                                                child: Container(
                                                                                  height: 40,
                                                                                  width: MediaQuery.of(context).size.width * .4,
                                                                                  decoration: BoxDecoration(color: customThemeColor, borderRadius: BorderRadius.circular(8)),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'submit'.tr,
                                                                                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                                      // style: state.loginButtonTextStyle,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              20,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 30.w),
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                if (_loginLogic.loginKey.currentState!.validate()) {
                                                                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                                                                  if (!currentFocus.hasPrimaryFocus) {
                                                                                    currentFocus.unfocus();
                                                                                  }
                                                                                  log("This is number ${_loginLogic.loginPhoneNumber}");

                                                                                  _generalController.updateFormLoaderController(true);

                                                                                  postMethod(
                                                                                      context,
                                                                                      loginWithOtpURL,
                                                                                      {
                                                                                        'token': '123',
                                                                                        'phone': _loginLogic.loginPhoneNumber!.replaceFirst('+', ''),
                                                                                        'role': _loginLogic.selectedRole
                                                                                      },
                                                                                      false,
                                                                                      loginSignupOtpRepo);
                                                                                }
                                                                              },
                                                                              child: MyCustomBottomBar(title: LanguageConstant.login.tr, disable: false)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        : Column(children: [
                                            ///---email-field
                                            TextFormField(
                                              controller:
                                                  _loginLogic.emailController,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(25.w, 15.h,
                                                            25.w, 15.h),
                                                hintText: LanguageConstant
                                                    .emailAddress.tr,
                                                hintStyle: state.hintTextStyle,
                                                fillColor: customTextFieldColor,
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
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red)),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return LanguageConstant
                                                      .fieldRequired.tr;
                                                } else if (!GetUtils.isEmail(
                                                    value)) {
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
                                              controller: _loginLogic
                                                  .passwordController,
                                              keyboardType: TextInputType.text,
                                              obscureText: obscureText!,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(25.w, 15.h,
                                                            25.w, 15.h),
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      obscureText =
                                                          !obscureText!;
                                                    });
                                                  },
                                                  child: Icon(
                                                      obscureText!
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      size: 20,
                                                      color: const Color(
                                                          0xff8085BA)),
                                                ),
                                                hintText: LanguageConstant
                                                    .password.tr,
                                                hintStyle: state.hintTextStyle,
                                                fillColor: customTextFieldColor,
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
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    borderSide:
                                                        const BorderSide(
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
                                            SizedBox(height: 24.h),

                                            ///---forgot-password
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(PageRoutes
                                                        .resetPassword);
                                                  },
                                                  child: Text(
                                                    '${LanguageConstant.forgotPassword.tr}?',
                                                    style:
                                                        state.forgotTextStyle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .05),

                                            ///---login-button
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30.w),
                                              child: InkWell(
                                                  onTap: () {
                                                    if (_loginFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      _generalController
                                                          .focusOut(context);
                                                      _generalController
                                                          .updateFormLoaderController(
                                                              true);
                                                      postMethod(
                                                          context,
                                                          loginWithEmailURL,
                                                          {
                                                            'email': _loginLogic
                                                                .emailController
                                                                .text,
                                                            'password': _loginLogic
                                                                .passwordController
                                                                .text,
                                                            'role': _loginLogic
                                                                .selectedRole
                                                          },
                                                          false,
                                                          loginWithEmailRepo);
                                                    }
                                                  },
                                                  child: MyCustomBottomBar(
                                                      title: LanguageConstant
                                                          .login.tr,
                                                      disable: false)),
                                            ),
                                          ]),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          LanguageConstant.orLoginWith.tr,
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
                                            // try {
                                            //   await _googleSignIn.signIn();
                                            // } catch (error) {
                                            //   print(error);
                                            // }
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
                                                              .withOpacity(0.2),
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
                                      ],
                                    ),

                                    SizedBox(height: 30.h),

                                    ///---signup-route
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${LanguageConstant.doNotHaveAccount.tr}? ',
                                          style: state.descTextStyle,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(PageRoutes.signUp);
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5.h, 0, 5.h),
                                            child: Text(
                                              LanguageConstant.registerNow.tr,
                                              style: state.descTextStyle!
                                                  .copyWith(
                                                      color: customThemeColor,
                                                      decoration: TextDecoration
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
                                          '${LanguageConstant.byLoginYouAreAgreeWithOur.tr} ',
                                          style: state.descTextStyle,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  _buildPopupDialog(context),
                                            );
                                          },
                                          child: Text(
                                            LanguageConstant
                                                .termsAndConditions.tr,
                                            style: state.descTextStyle!
                                                .copyWith(
                                                    color:
                                                        customLightThemeColor,
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
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
                    ],
                  ),
                ]),
              ),
            ),
          );
        }),
      );
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0.0, 20.0, 24.0, 24.0),
      title: const Text('Terms And Conditions'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: Html(
            data: '${Get.find<MainLogic>().termsConditionModel.data?.value}',
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: Text(
            'Close',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}

class OtpTimer extends StatelessWidget {
  final state = Get.find<LoginLogic>().state;

  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor, {super.key});

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration? duration = controller.duration;
    return duration!;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Text(timerString,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff727377)));
        });
  }
}
