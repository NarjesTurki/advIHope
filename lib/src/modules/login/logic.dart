import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/login/login_otp_model.dart';
import 'package:ista_app/src/modules/login/model.dart';
import 'package:ista_app/src/modules/login/state.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  LoginModel loginModel = LoginModel();
  LoginOtpModel loginOtpModel = LoginOtpModel();

  late TabController tabController;

  List<Tab> loginRoleTabList = [
    Tab(text: LanguageConstant.user.tr),
    Tab(text: LanguageConstant.mentor.tr)
  ];

  String? selectedRole = 'Mentee';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailValidator;
  String? passwordValidator;
  AnimationController? loginTimerAnimationController;
  AnimationController? signupTimerAnimationController;

  /// Otp logics

  final GlobalKey<FormState> loginKey = GlobalKey();
  TextEditingController loginTextEditingController = TextEditingController();
  String? loginPhoneNumber;
  String? verificationIDForVerify;

  bool otpSendCheckerLogin = false;
  updateOtpSendCheckerLogin(bool newValue) {
    otpSendCheckerLogin = newValue;
    update();
  }

  bool? otpSendCheckerSignup = false;
  updateOtpSendCheckerSignup(bool? newValue) {
    otpSendCheckerSignup = newValue;
    update();
  }

  String? loginOtp;
  String? signupOtp;

  Future<bool?> otpFunction(String? phone, BuildContext context) async {
    log('-----------------OtpFunctionStartHere-----------------');
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: phone!,
      timeout: const Duration(seconds: 55),
      verificationCompleted: (AuthCredential credential) async {
        log('Credential from verificationCompleted ---->> $credential');
        Get.find<GeneralController>().updateFormLoaderController(true);
        User? user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        if (user != null) {
          log('user added by otp');

          Get.find<GeneralController>().storageBox.write('userID',
              Get.find<LoginLogic>().loginOtpModel.data!.userDetail![0].id);
          Get.find<GeneralController>().storageBox.write('authToken',
              Get.find<LoginLogic>().loginOtpModel.data!.accessToken);

          if (Get.find<LoginLogic>().loginModel.data!.role == 'Mentee') {
            Get.find<GeneralController>().storageBox.write(
                'userRole', Get.find<LoginLogic>().loginModel.data!.role);

            Get.offAllNamed(PageRoutes.userHome);
            log('loginRepoMentee ------>> ${Get.find<LoginLogic>().loginModel.data}');
          } else {
            Get.find<GeneralController>().storageBox.write(
                'userRole', Get.find<LoginLogic>().loginModel.data!.role);

            Get.offAllNamed(PageRoutes.consultantDashboard);
            log('loginRepoMentor ------>> ${Get.find<LoginLogic>().loginModel.data}');
          }
        } else {
          Get.find<GeneralController>().updateFormLoaderController(false);
          Get.find<GeneralController>().update();
          log("Error");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        log('Exception ---->> ${exception.message}');
      },
      codeSent: (String? verificationId, [int? forceResendingToken]) {
        verificationIDForVerify = verificationId;
        log('verificationId ---->> $verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('autoGetOTP ---->> $verificationId');
      },
    );
    return null;
  }

  verifyOTP(BuildContext context, var otp, bool fromSignup) async {
    log('--------------VerifyOtpStartsHere--------------');
    try {
      log('verificationId ---->> $verificationIDForVerify');
      log('verificationId ---->> $otp');
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDForVerify!,
        smsCode: otp,
      );

      User? user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      print(user.toString());

      if (user != null) {
        log('user added by otp');

        if (fromSignup) {
          // postMethod(
          //     context,
          //     signupUrl,
          //     {
          //       'token': '123',
          //       'phone': signupPhoneNumber!.replaceFirst('+', ''),
          //       'role': loginTypeMentee! ? 'Mentee' : 'Mentor'
          //     },
          //     false,
          //     signupRepo);
        } else {
          Get.find<GeneralController>().storageBox.write('userID',
              Get.find<LoginLogic>().loginOtpModel.data!.userDetail![0].id);
          Get.find<GeneralController>().storageBox.write('authToken',
              Get.find<LoginLogic>().loginOtpModel.data!.accessToken);

          if (Get.find<LoginLogic>().loginOtpModel.data!.role == 'Mentee') {
            Get.find<GeneralController>().storageBox.write(
                'userRole', Get.find<LoginLogic>().loginOtpModel.data!.role);

            Get.offAllNamed(PageRoutes.userHome);
            log('loginRepoMentee ------>> ${Get.find<LoginLogic>().loginOtpModel.data}');
          } else {
            Get.find<GeneralController>().storageBox.write(
                'userRole', Get.find<LoginLogic>().loginOtpModel.data!.role);

            Get.offAllNamed("/consultantDashboard");
            log('loginRepoMentor ------>> ${Get.find<LoginLogic>().loginOtpModel.data}');
          }
        }
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);

        log("Error");
      }
      log('Credential ---->> $credential');
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: 'incorrect_OTP'.tr,
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
      log('Exception --->> $e');
    }
  }
}
