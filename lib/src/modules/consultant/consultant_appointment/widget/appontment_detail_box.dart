import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:resize/resize.dart';

class AppointmentDetailBox extends StatelessWidget {
  const AppointmentDetailBox({
    Key? key,
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
    required this.fee,
    required this.type,
    required this.typeIcon,
    required this.date,
    required this.time,
    required this.status,
    required this.color,
  }) : super(key: key);

  final String? image;
  final String? name;
  final String? category;
  final double? rating;
  final String? fee;
  final String? type;
  final String? typeIcon;
  final String? date;
  final String? time;
  final dynamic? status;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConsultantAppointmentLogic>(
        builder: (_consultantAppointmentLogic) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: -2,
                  blurRadius: 15,
                  // offset: Offset(1,5)
                )
              ],
              borderRadius: BorderRadius.circular(8.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///---profile-area
                Row(
                  children: [
                    ///---profile-image
                    Container(
                      height: 85.h,
                      width: 76.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: image == null
                              ? const SizedBox()
                              : Image.network(
                                  image!.contains('assets')
                                      ? '$mediaUrl$image'
                                      : image!,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 19.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///---name
                            Text(
                              name!,
                              style: _consultantAppointmentLogic
                                  .state.profileNameTextStyle,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),

                            ///---category
                            Text(
                              category!,
                              style: _consultantAppointmentLogic
                                  .state.profileCategoryTextStyle,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),

                            ///---rating-bar
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: rating!,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => SvgPicture.asset(
                                  'assets/Icons/ratingStarIcon.svg'),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20.h,
                ),

                ///---type-fee
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///---type
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(end: 11.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/Icons/feeIcon.svg',
                                height: 16.h,
                                width: 18.w,
                              ),
                              SizedBox(
                                width: 11.w,
                              ),
                              Text(
                                fee!,
                                style: _consultantAppointmentLogic
                                    .state.feeTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///---fee
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 11.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                typeIcon!,
                                height: 16.h,
                                width: 18.w,
                                color: customLightThemeColor,
                              ),
                              SizedBox(
                                width: 11.w,
                              ),
                              Text(
                                type!,
                                style: _consultantAppointmentLogic
                                    .state.feeTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 22.h,
                ),

                ///---pending-status-date-time
                status == 0
                    ? Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color!,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          children: [
                            ///---status
                            Container(
                              height: 45.h,
                              width: 87.w,
                              decoration: BoxDecoration(
                                color: color!,
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xff707070)
                                          .withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 15,
                                      offset: const Offset(0, 5))
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/Icons/pendingAppoitmentIcon.svg',
                                height: 24.h,
                                width: 24.w,
                              )),
                            ),

                            ///---date-time
                            dateTimeRow()
                          ],
                        ),
                      )
                    : const SizedBox(),

                ///---accepted-status-date-time
                status == 1
                    ? Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color!,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          children: [
                            ///---status
                            Container(
                                height: 45.h,
                                width: 87.w,
                                decoration: BoxDecoration(
                                  color: color!,
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xff707070)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: const Offset(0, 5))
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/Icons/completeAppointmentIcon.svg',
                                        height: 12.h,
                                        width: 12.w,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        LanguageConstant.accepted.tr,
                                        style: _consultantAppointmentLogic
                                            .state.statusTextStyle,
                                      )
                                    ],
                                  ),
                                )),

                            ///---date-time

                            dateTimeRow()
                          ],
                        ),
                      )
                    : const SizedBox(),

                ///---completed-status-date-time
                status == 2
                    ? Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color!,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          children: [
                            ///---status
                            Container(
                                height: 45.h,
                                width: 87.w,
                                decoration: BoxDecoration(
                                  color: color!,
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xff707070)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: const Offset(0, 5))
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/Icons/completeAppointmentIcon.svg',
                                        height: 12.h,
                                        width: 12.w,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        LanguageConstant.completed.tr,
                                        style: _consultantAppointmentLogic
                                            .state.statusTextStyle,
                                      )
                                    ],
                                  ),
                                )),

                            ///---date-time
                            dateTimeRow()
                          ],
                        ),
                      )
                    : const SizedBox(),

                ///---cancelled-status-date-time
                status == 3
                    ? Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color!,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          children: [
                            ///---status
                            Container(
                                height: 45.h,
                                width: 87.w,
                                decoration: BoxDecoration(
                                  color: color!,
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xff707070)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: const Offset(0, 5))
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/Icons/cancelAppointmentIcon.svg',
                                        height: 12.h,
                                        width: 12.w,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        LanguageConstant.cancelled.tr,
                                        style: _consultantAppointmentLogic
                                            .state.statusTextStyle,
                                      )
                                    ],
                                  ),
                                )),

                            ///---date-time
                            dateTimeRow()
                          ],
                        ),
                      )
                    : const SizedBox(),

                ///---Archived-status-date-time
                status ==
                        Get.find<ConsultantAppointmentLogic>()
                            .getConsultantAppointmentModel
                            .data!
                            .archivedAppointments
                    ? Container(
                        height: 45.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color!,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          children: [
                            ///---status
                            Container(
                                height: 45.h,
                                width: 87.w,
                                decoration: BoxDecoration(
                                  color: color!,
                                  borderRadius: BorderRadius.circular(5.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xff707070)
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: const Offset(0, 5))
                                  ],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/Icons/archive.svg',
                                        height: 12.h,
                                        width: 12.w,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        //  LanguageConstant.cancelled.tr,
                                        'Archived',
                                        style: _consultantAppointmentLogic
                                            .state.statusTextStyle,
                                      )
                                    ],
                                  ),
                                )),

                            ///---date-time
                            dateTimeRow()
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget dateTimeRow() {
    return date == null
        ? const SizedBox()
        : Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///---date
                  Text(
                    date!,
                    style: Get.find<ConsultantAppointmentLogic>()
                        .state
                        .dateTimeTextStyle,
                  ),
                  Text(
                    '  -  ',
                    style: Get.find<ConsultantAppointmentLogic>()
                        .state
                        .dateTimeTextStyle,
                  ),
                  if (time != null)

                    ///---time
                    Text(
                      time!,
                      style: Get.find<ConsultantAppointmentLogic>()
                          .state
                          .dateTimeTextStyle,
                    ),
                ],
              ),
            ),
          );
  }
}
