import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/new_password/logic.dart';
import 'package:ista_app/src/modules/new_password/repo.dart';
import 'package:ista_app/src/modules/reset_password/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_app_bar.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final logic = Get.put(NewPasswordLogic());

  final state = Get.find<NewPasswordLogic>().state;

  final GlobalKey<FormState> _newPasswordFormKey = GlobalKey();
  final TextEditingController? _passwordController = TextEditingController();
  final TextEditingController? _confirmPasswordController =
      TextEditingController();
  bool? obscureText = true;
  bool? confirmObscureText = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<NewPasswordLogic>(builder: (_newPasswordLogic) {
        return ModalProgressHUD(
          inAsyncCall: _generalController.formLoaderController,
          child: GestureDetector(
            onTap: () {
              _generalController.focusOut(context);
            },
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
                                key: _newPasswordFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.newPassword.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(height: 9.h),
                                    Text(
                                      LanguageConstant.createNewPassword.tr,
                                      style: state.descTextStyle,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .075),
                                    Text(
                                      LanguageConstant.enterPassword.tr,
                                      style: state.subHeadingTextStyle,
                                    ),
                                    SizedBox(height: 25.h),

                                    ///---password-field

                                    TextFormField(
                                      controller: _passwordController,
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
                                            LanguageConstant.newPassword.tr,
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

                                    SizedBox(height: 20.h),

                                    ///---confirm-password-field

                                    TextFormField(
                                      controller: _confirmPasswordController,
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
                                        hintText:
                                            LanguageConstant.confirmPassword.tr,
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
                                        } else if (_passwordController!.text !=
                                            _confirmPasswordController!.text) {
                                          return LanguageConstant
                                              .passwordNotMatch.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .35,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.h,
                    left: 55.w,
                    right: 55.w,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 45.h),
                      child: InkWell(
                          onTap: () {
                            // Get.toNamed(PageRoutes.createdPassword);
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_newPasswordFormKey.currentState!.validate()) {
                              _generalController
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  newPasswordUrl,
                                  {
                                    'password': _passwordController!.text,
                                    'password_confirmation':
                                        _confirmPasswordController!.text,
                                    'token': Get.find<ResetPasswordLogic>()
                                        .forgetPasswordModel
                                        .msg,
                                  },
                                  true,
                                  newPasswordRepo);
                            }
                          },
                          child: MyCustomBottomBar(
                              title: LanguageConstant.resetPassword.tr,
                              disable: false)),
                    ),
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
