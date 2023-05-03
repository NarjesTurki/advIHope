import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/modules/sms/repo.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/consultant_profile/logic.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';

class LiveRequest extends StatefulWidget {
  const LiveRequest({Key? key}) : super(key: key);

  @override
  _LiveRequestState createState() => _LiveRequestState();
}

class _LiveRequestState extends State<LiveRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/Icons/whiteBackArrow.svg',
                ),
              ],
            ),
          ),
          backgroundColor: customThemeColor,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.w, 0, 25.w, 0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Text(
                  'Are You Live Now',
                  style: TextStyle(
                      fontFamily: SarabunFontFamily.bold,
                      fontSize: 28.sp,
                      color: customThemeColor),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Please Accept Appointment',
                  style: TextStyle(
                      fontFamily: SarabunFontFamily.regular,
                      fontSize: 14.sp,
                      color: customOrangeColor),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.put(UserHomeLogic());
                          Get.put(ConsultantProfileLogic());
                          Get.put(BookAppointmentLogic());
                          Get.find<GeneralController>()
                              .updateFormLoaderController(true);

                          ///---make-notification
                          Get.find<GeneralController>().updateNotificationBody(
                              'Your Live Appointment Request Accepted',
                              '',
                              '/appointmentQuestion',
                              'mentee/appointment/log',
                              null);
                          Get.find<GeneralController>()
                              .updateUserIdForSendNotification(int.parse(
                                  Get.find<GeneralController>()
                                      .notificationMenteeId!));
                          // Get.find<GeneralController>().notificationMenteeId = '';
                          Get.find<GeneralController>().notificationFee = null;
                          Get.find<GeneralController>().update();

                          ///----send-sms
                          postMethod(
                              context,
                              sendSMSUrl,
                              {
                                'token': '123',
                                'phone': Get.find<SmsLogic>().phoneNumber,
                                'message': Get.find<GeneralController>()
                                    .notificationTitle,
                              },
                              true,
                              sendSMSRepo);

                          ///----fcm-send-start
                          getMethod(
                              context,
                              fcmGetUrl,
                              {
                                'token': '123',
                                'user_id': Get.find<GeneralController>()
                                    .notificationMenteeId
                              },
                              true,
                              getFcmTokenRepo);
                          Get.find<GeneralController>()
                              .updateFormLoaderController(false);
                          Get.back();
                        },
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: customThemeColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Center(
                              child: Text(
                                LanguageConstant.accept.tr,
                                style: TextStyle(
                                    fontFamily: SarabunFontFamily.bold,
                                    fontSize: 16.sp,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.put(ConsultantAppointmentLogic());

                          ///---make-notification
                          Get.find<GeneralController>().updateNotificationBody(
                              'Your Live Appointment Request Rejected',
                              '',
                              null,
                              null,
                              null);
                          Get.find<GeneralController>()
                              .updateUserIdForSendNotification(int.parse(
                                  Get.find<GeneralController>()
                                      .notificationMenteeId!));
                          // Get.find<GeneralController>().notificationMenteeId = '';
                          Get.find<GeneralController>().notificationFee = null;
                          Get.find<GeneralController>().update();

                          ///----send-sms
                          postMethod(
                              context,
                              sendSMSUrl,
                              {
                                'token': '123',
                                'phone': Get.find<SmsLogic>().phoneNumber,
                                'message': Get.find<GeneralController>()
                                    .notificationTitle,
                              },
                              true,
                              sendSMSRepo);

                          ///----fcm-send-start
                          getMethod(
                              context,
                              fcmGetUrl,
                              {
                                'token': '123',
                                'user_id': Get.find<GeneralController>()
                                    .notificationMenteeId
                              },
                              true,
                              getFcmTokenRepo);
                          Get.back();
                        },
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Center(
                              child: Text(
                                LanguageConstant.reject.tr,
                                style: TextStyle(
                                    fontFamily: SarabunFontFamily.bold,
                                    fontSize: 16.sp,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
