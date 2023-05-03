import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/created_password/logic.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:resize/resize.dart';

class CreatedPasswordPage extends StatefulWidget {
  const CreatedPasswordPage({Key? key}) : super(key: key);

  @override
  State<CreatedPasswordPage> createState() => _CreatedPasswordPageState();
}

class _CreatedPasswordPageState extends State<CreatedPasswordPage> {
  final logic = Get.put(CreatedPasswordLogic());

  final state = Get.find<CreatedPasswordLogic>().state;

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
              //  SizedBox(height: MediaQuery.of(context).size.height * .23),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .3),
                    SvgPicture.asset(
                      'assets/images/successfullImage.svg',
                      height: 120.h,
                      width: 177.w,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    Center(
                      child: Text(
                        LanguageConstant.passwordCreated.tr,
                        style: state.headingTextStyle,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      LanguageConstant.successfully.tr,
                      style: state.subheadingTextStyle,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.h,
                left: 55.w,
                right: 55.w,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 45.h),
                  child: InkWell(
                      onTap: () {
                        Get.offAllNamed(PageRoutes.login);
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
