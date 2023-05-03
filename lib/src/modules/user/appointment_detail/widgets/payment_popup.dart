import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/user/appointment_detail/logic.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:resize/resize.dart';

paymentBottomSheetForLater(BuildContext context) async {
  return Get.bottomSheet(
    ///---payment-method-area
    GetBuilder<AppointmentDetailLogic>(builder: (_appointmentDetailLogic) {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: customTextBlackColor, width: 1)),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 10.h, 20.w, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: _appointmentDetailLogic.state.headingTextStyle,
              ),
              SizedBox(
                height: 15.h,
              ),
              Wrap(
                children: List.generate(
                    Get.find<BookAppointmentLogic>()
                        .getPaymentMethodList
                        .length, (index) {
                  return Padding(
                    padding: index % 2 == 0
                        ? EdgeInsetsDirectional.fromSTEB(0, 0, 8.w, 14.h)
                        : EdgeInsetsDirectional.fromSTEB(8.w, 0.h, 0.w, 14.h),
                    child: InkWell(
                      onTap: () {
                        //   _appointmentDetailLogic.selectedPaymentType = index;
                        Get.find<BookAppointmentLogic>().updateSelectedMethod(
                            Get.find<BookAppointmentLogic>()
                                .getPaymentMethodList[index]
                                .id,
                            Get.find<BookAppointmentLogic>()
                                .getPaymentMethodList[index]
                                .name!);
                        _appointmentDetailLogic.update();
                        _appointmentDetailLogic.amountController.clear();

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Get.toNamed(PageRoutes.stripePaymentForLater);
                      },
                      child: Container(
                          height: 61.h,
                          width: MediaQuery.of(context).size.width / 2 - 28,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Get.find<BookAppointmentLogic>()
                                              .getPaymentMethodList[index]
                                              .isDefault ==
                                          1
                                      ? customLightThemeColor
                                      : Colors.white,
                                  width: 2),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Get.find<BookAppointmentLogic>()
                                              .getPaymentMethodList[index]
                                              .isDefault ==
                                          1
                                      ? customLightThemeColor.withOpacity(0.2)
                                      : Colors.grey.withOpacity(0.2),
                                  spreadRadius: -2,
                                  blurRadius: 15,
                                  // offset: Offset(1,5)
                                )
                              ]),
                          child: Get.find<BookAppointmentLogic>()
                                      .getPaymentMethodList[index]
                                      .id ==
                                  110
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      Get.find<BookAppointmentLogic>()
                                          .getPaymentMethodList[index]
                                          .imagePath!),
                                )
                              : Image.network(
                                  '$mediaUrl${Get.find<BookAppointmentLogic>().getPaymentMethodList[index].imagePath}')
                          // Get.find<BookAppointmentLogic>().getPaymentMethodList[index].code!.contains('braintreePayment')
                          //     ? ClipRRect(
                          //         borderRadius: BorderRadius.circular(8.r),
                          //         child: Image.network(
                          //           '$mediaUrl${Get.find<BookAppointmentLogic>().getPaymentMethodList[index].imagePath}',
                          //           width: double.infinity,
                          //           height: double.infinity,
                          //         ),
                          //       )
                          //     : Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Image.network(
                          //             '$mediaUrl${Get.find<BookAppointmentLogic>().getPaymentMethodList[index].imagePath}',
                          //             width: MediaQuery.of(context).size.width * .15,
                          //           ),
                          //         ],
                          //       ),
                          ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    }),
  );
}
