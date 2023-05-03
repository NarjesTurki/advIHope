import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/reset_password/logic.dart';
import 'package:ista_app/src/modules/reset_password/repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_app_bar.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final logic = Get.put(ResetPasswordLogic());

  final state = Get.find<ResetPasswordLogic>().state;

  final GlobalKey<FormState> _forgetPasswordFormKey = GlobalKey();
  final TextEditingController? _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ResetPasswordLogic>(builder: (_resetPasswordLogic) {
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
                                key: _forgetPasswordFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.resetPassword.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(height: 9.h),
                                    Text(
                                      LanguageConstant
                                          .aResetLinkWillBeShareViaEmail.tr,
                                      style: state.descTextStyle,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .075),
                                    Text(
                                      LanguageConstant.enterEmail.tr,
                                      style: state.subHeadingTextStyle,
                                    ),
                                    SizedBox(height: 25.h),

                                    ///---field-area
                                    // Column(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     DecoratedBox(
                                    //       decoration: BoxDecoration(
                                    //         color: const Color(0xffF6F7FC),
                                    //         borderRadius: BorderRadius.circular(10),
                                    //       ),
                                    //       child: IntlPhoneField(
                                    //         initialCountryCode: 'PK',
                                    //         //  controller: _loginLogicController
                                    //         //  .loginTextEditingController,
                                    //         // style: GoogleFonts.poppins(
                                    //         //     color: Colors.black),
                                    //         inputFormatters: [
                                    //           FilteringTextInputFormatter.allow(
                                    //               RegExp(r'[0-9]')),
                                    //         ],
                                    //         keyboardType: TextInputType.phone,
                                    //         textAlign: TextAlign.start,
                                    //         decoration: InputDecoration(
                                    //           contentPadding:
                                    //               const EdgeInsets.symmetric(
                                    //                   vertical: 10, horizontal: 10),
                                    //           filled: true,
                                    //           fillColor: customTextFieldColor,
                                    //           floatingLabelBehavior:
                                    //               FloatingLabelBehavior.never,
                                    //           counterText: '',
                                    //           labelText: 'Enter Email',
                                    //           errorBorder: OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(10),
                                    //               borderSide: const BorderSide(
                                    //                   color: Colors.red)),
                                    //           border: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10),
                                    //             borderSide: BorderSide.none,
                                    //           ),
                                    //         ),
                                    //         // onChanged: (phone) {
                                    //         //   setState(() {
                                    //         //     _loginLogicController
                                    //         //         .updateOtpSendCheckerLogin(
                                    //         //         false);
                                    //         //     _loginLogicController
                                    //         //         .loginPhoneNumber =
                                    //         //         phone.completeNumber;
                                    //         //   });
                                    //         //   log(phone.completeNumber);
                                    //         // },
                                    //         // onCountryChanged:
                                    //         //     (PhoneNumber? phone) {
                                    //         //   _loginLogicController
                                    //         //       .updateOtpSendCheckerLogin(
                                    //         //       false);
                                    //         //   _loginLogicController
                                    //         //       .loginTextEditingController
                                    //         //       .clear();
                                    //         //   _loginLogicController
                                    //         //       .loginPhoneNumber = null;
                                    //         //   setState(() {});
                                    //         //   log('Country code changed to: ' +
                                    //         //       phone!.countryISOCode
                                    //         //           .toString());
                                    //         // },
                                    //       ),
                                    //     ),
                                    //     // SizedBox(height: 250.h),
                                    //     // SizedBox(
                                    //     //   height:
                                    //     //       MediaQuery.of(context).size.height * .4,
                                    //     // ),
                                    //     // Padding(
                                    //     //   padding: EdgeInsetsDirectional.fromSTEB(
                                    //     //       0, 0, 0, 20.h),
                                    //     //   child: InkWell(
                                    //     //     onTap: () {},
                                    //     //     child: const CustomButton(
                                    //     //       title: 'Confirm',
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //   ],
                                    // ),
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                25.w, 15.h, 25.w, 15.h),
                                        hintText:
                                            LanguageConstant.emailAddress.tr,
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
                                        } else if (!GetUtils.isEmail(value)) {
                                          return LanguageConstant
                                              .enterValidEmail.tr;
                                        } else {
                                          return null;
                                        }
                                      },
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
                            // Get.toNamed(PageRoutes.enterOtp);
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_forgetPasswordFormKey.currentState!
                                .validate()) {
                              _generalController
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  forgotPasswordUrl,
                                  {
                                    'email': _emailController!.text,
                                  },
                                  true,
                                  forgetPasswordRepo);
                            }
                          },
                          child: MyCustomBottomBar(
                              title: LanguageConstant.confirm.tr,
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
