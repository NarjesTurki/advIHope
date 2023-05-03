import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/book_appointment/widget/detail_box.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:resize/resize.dart';

class AppointmentConfirmationView extends StatefulWidget {
  const AppointmentConfirmationView({Key? key}) : super(key: key);

  @override
  _AppointmentConfirmationViewState createState() =>
      _AppointmentConfirmationViewState();
}

class _AppointmentConfirmationViewState
    extends State<AppointmentConfirmationView> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetBuilder<GeneralController>(builder: (_generalController) {
        return GetBuilder<BookAppointmentLogic>(
            builder: (_bookAppointmentLogic) {
          return GestureDetector(
            onTap: () {
              _generalController.focusOut(context);
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  ///---background
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      'assets/images/loginBackground.png',
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .12),

                        ///---detail-area
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 15,
                                )
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35.h, horizontal: 28.w),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ///---success-image
                                  SvgPicture.asset(
                                    'assets/images/successfull.svg', //image
                                    height: 120.h,
                                    width: 177.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .03),

                                  ///---success-text
                                  Text(
                                    LanguageConstant.congratulations.tr,
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.bold,
                                        fontSize: 28.sp,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),

                                  ///---message-text
                                  Text(
                                    LanguageConstant
                                        .yourAppointmentHasBeenBookedWith.tr,
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.regular,
                                        fontSize: 14.sp,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   'with ',
                                      //   style: TextStyle(
                                      //       fontFamily:
                                      //           SarabunFontFamily.regular,
                                      //       fontSize: 14.sp,
                                      //       color: const Color(0xff9D9D9D)),
                                      // ),

                                      ///---consultant-name
                                      Text(
                                        '${Get.find<UserHomeLogic>().selectedConsultantName}',
                                        style: TextStyle(
                                            fontFamily:
                                                SarabunFontFamily.regular,
                                            fontSize: 14.sp,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 30.h,
                                  ),

                                  ///---type-fee-boxes
                                  Row(
                                    children: [
                                      ///---type-box
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 8.w),
                                          child: BookAppointmentDetailBox(
                                            title:
                                                '${_bookAppointmentLogic.selectMentorAppointmentType!.appointmentType!.name}'
                                                    .capitalize,
                                            image:
                                                '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].appointmentTypeId! - 1]}',
                                          ),
                                        ),
                                      ),

                                      ///---fee-box
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.w),
                                          child: BookAppointmentDetailBox(
                                            title:
                                                '${Get.find<GeneralController>().storageBox.read('currency')}${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].fee} ${LanguageConstant.fees.tr}',
                                            image: 'assets/Icons/feeIcon.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),

                                  ///---date-time-boxes
                                  _bookAppointmentLogic
                                              .selectMentorAppointmentType!
                                              .appointmentType!
                                              .isScheduleRequired ==
                                          1
                                      ? Row(
                                          children: [
                                            ///---date-box
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.w),
                                                child: BookAppointmentDetailBox(
                                                  title: DateFormat('dd/MM/yy')
                                                      .format(DateTime.parse(
                                                          _bookAppointmentLogic
                                                              .selectedDateForAppointment)),
                                                  image:
                                                      'assets/Icons/calenderIcon.svg',
                                                ),
                                              ),
                                            ),

                                            ///---time-box
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.w),
                                                child: BookAppointmentDetailBox(
                                                  title: _bookAppointmentLogic
                                                      .selectedTimeForAppointment,
                                                  image:
                                                      'assets/Icons/timeIcon.svg',
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                        ),

                        ///---my-appointment-button
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(40.w, 0, 40.w, 0),
                          child: InkWell(
                              onTap: () {
                                Get.offAllNamed(PageRoutes.myAppointment);
                              },
                              child: MyCustomBottomBar(
                                  title: LanguageConstant.myAppointments.tr,
                                  disable: false)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        ///---home-button
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(PageRoutes.userHome);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  40.w, 0, 40.w, 0),
                              child: Container(
                                height: 55.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: customOrangeColor),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          LanguageConstant.goToHome.tr,
                                          style: const TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.bold,
                                              fontSize: 16,
                                              color: customOrangeColor),
                                        ),
                                        SvgPicture.asset(
                                          'assets/Icons/forwardArrowOrangeIcon.svg',
                                          height: 29.h,
                                          width: 29.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        });
      }),
    );
  }
}
