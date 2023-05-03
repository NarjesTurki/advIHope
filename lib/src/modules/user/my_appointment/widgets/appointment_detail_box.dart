import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/user/my_appointment/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    required this.isPaid,
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
  final int? status;
  final Color? color;
  final int? isPaid;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentLogic>(builder: (_myAppointmentLogic) {
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
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, object, trace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      // color: Colors.white,
                                    );
                                  },
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
                              style: _myAppointmentLogic
                                  .state.profileNameTextStyle,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),

                            ///---category
                            Text(
                              category!,
                              style: _myAppointmentLogic
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

                ///---type-fee-isPaid
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///---type
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(end: 0.w),
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
                                style: _myAppointmentLogic.state.feeTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///---fee
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 0.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                style: _myAppointmentLogic.state.feeTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///---isPaid
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(end: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isPaid == 0
                                  ? const Icon(
                                      Icons.clear,
                                      size: 15,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.check,
                                      size: 15,
                                      color: customGreenColor,
                                    ),
                              SizedBox(
                                width: 11.w,
                              ),
                              Text(
                                isPaid == 0 ? 'Un-Paid' : 'Paid',
                                style: _myAppointmentLogic.state.feeTextStyle,
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
                                        style: _myAppointmentLogic
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
                                        style: _myAppointmentLogic
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
                                        style: _myAppointmentLogic
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
                    style:
                        Get.find<MyAppointmentLogic>().state.dateTimeTextStyle,
                  ),
                  Text(
                    '  -  ',
                    style:
                        Get.find<MyAppointmentLogic>().state.dateTimeTextStyle,
                  ),
                  if (time != null)

                    ///---time
                    Text(
                      time!,
                      style: Get.find<MyAppointmentLogic>()
                          .state
                          .dateTimeTextStyle,
                    ),
                ],
              ),
            ),
          );
  }
}
