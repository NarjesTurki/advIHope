import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/otp/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_app_bar.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resize/resize.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final logic = Get.put(OtpLogic());

  final state = Get.find<OtpLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GestureDetector(
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
                  // SizedBox(
                  //   height: 85.h,
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * .097),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(LanguageConstant.enterOTP.tr,
                                  style: state.headingTextStyle),
                              SizedBox(height: 18.h),
                              Text(
                                  LanguageConstant
                                      .anOTPCodeHasBeenSentToYourGivenToYourPhoneNumber
                                      .tr,
                                  style: state.descTextStyle,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 12.h),
                              Text(
                                '+001-1258-62',
                                style: state.numberTextStyle,
                              ),
                              //  SizedBox(height: 55.h),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),

                              /// OTP Fields ///
                              PinCodeTextField(
                                animationType: AnimationType.none,
                                enableActiveFill: true,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                obscureText: false,
                                onChanged: (String value) {},
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8),
                                  fieldHeight: 62.h,
                                  fieldWidth: 50.w,
                                  selectedColor: customThemeColor,
                                  activeColor: Colors.transparent,
                                  inactiveColor: Colors.transparent,
                                  activeFillColor: customTextFieldColor,
                                  selectedFillColor: customTextFieldColor,
                                  borderWidth: 0.0,
                                  inactiveFillColor: customTextFieldColor,
                                  errorBorderColor: Colors.redAccent,
                                ),
                              ),
                              SizedBox(height: 35.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LanguageConstant.youWillReceiveCodeIn.tr,
                                    style: state.descTextStyle,
                                  ),
                                  Text(
                                    '0:42',
                                    style: state.descTextStyle
                                        ?.copyWith(color: customOrangeColor),
                                  )
                                ],
                              ),
                            ],
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
                        Get.toNamed(PageRoutes.newPassword);
                      },
                      child: MyCustomBottomBar(
                          title: LanguageConstant.confirm.tr, disable: false)),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
