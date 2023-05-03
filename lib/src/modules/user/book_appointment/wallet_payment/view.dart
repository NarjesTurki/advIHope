import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/book_appointment/wallet_payment/wallet_payment_repo.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class WalletPaymentView extends StatefulWidget {
  int? appointmentId;
  WalletPaymentView({Key? key, this.appointmentId}) : super(key: key);

  @override
  _WalletPaymentViewState createState() => _WalletPaymentViewState();
}

class _WalletPaymentViewState extends State<WalletPaymentView> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  void initState() {
    super.initState();

    Get.find<BookAppointmentLogic>().scrollController3 = ScrollController()
      ..addListener(Get.find<BookAppointmentLogic>().scrollListener3);
  }

  @override
  void dispose() {
    Get.find<BookAppointmentLogic>()
        .scrollController3!
        .removeListener(Get.find<BookAppointmentLogic>().scrollListener3);
    Get.find<BookAppointmentLogic>().scrollController3!.dispose();
    super.dispose();
  }

  double translateX = 0.0;
  double translateY = 0.0;
  bool? disableButton = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            inAsyncCall: _generalController.formLoaderController,
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: NestedScrollView(
                  controller: _bookAppointmentLogic.scrollController3,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      MyCustomSliverAppBar(
                        heading: LanguageConstant.bookAppointment.tr,
                        subHeading: LanguageConstant.byJustFewEasySteps.tr,
                        trailing: LanguageConstant.step3Of3.tr,
                        isShrink: _bookAppointmentLogic.isShrink3,
                        fee:
                            '\$${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].fee}',
                        feeImage:
                            '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].appointmentTypeId! - 1]}',
                      ),
                    ];
                  },
                  body: Stack(
                    children: [
                      // ListView(
                      //     padding:
                      //     EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0),
                      //     children: [
                      //       ///---question-area
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(8.r),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.grey.withOpacity(0.2),
                      //                 spreadRadius: 3,
                      //                 blurRadius: 15,
                      //                 // offset: Offset(1,5)
                      //               )
                      //             ]),
                      //         child: Padding(
                      //           padding: EdgeInsets.symmetric(
                      //               vertical: 25.h, horizontal: 20.w),
                      //           child: Form(
                      //             key: _formKey,
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   'Type Your Question',
                      //                   style: state.headingTextStyle,
                      //                 ),
                      //                 SizedBox(
                      //                   height: 20.h,
                      //                 ),
                      //
                      //                 ///---question-field
                      //
                      //                 TextFormField(
                      //                   controller: _bookAppointmentLogic.questionController,
                      //                   keyboardType: TextInputType.text,
                      //                   maxLines: 3,
                      //                   decoration: InputDecoration(
                      //                     contentPadding:
                      //                     EdgeInsetsDirectional.fromSTEB(
                      //                         25.w, 15.h, 25.w, 15.h),
                      //                     fillColor: customTextFieldColor,
                      //                     filled: true,
                      //                     enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                         BorderRadius.circular(8.r),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.transparent)),
                      //                     border: OutlineInputBorder(
                      //                         borderRadius:
                      //                         BorderRadius.circular(8.r),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.transparent)),
                      //                     focusedBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                         BorderRadius.circular(8.r),
                      //                         borderSide: const BorderSide(
                      //                             color: customLightThemeColor)),
                      //                     errorBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                         BorderRadius.circular(8.r),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.red)),
                      //                   ),
                      //                   validator: (value) {
                      //                     if (value!.isEmpty) {
                      //                       return 'field_required'.tr;
                      //                     } else {
                      //                       return null;
                      //                     }
                      //                   },
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //
                      //       SizedBox(
                      //         height: 25.h,
                      //       ),
                      //
                      //       ///---upload-file-area
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(8.r),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.grey.withOpacity(0.2),
                      //                 spreadRadius: 3,
                      //                 blurRadius: 15,
                      //                 // offset: Offset(1,5)
                      //               )
                      //             ]),
                      //         child: Padding(
                      //           padding: EdgeInsets.symmetric(
                      //               vertical: 25.h, horizontal: 20.w),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 crossAxisAlignment: CrossAxisAlignment.end,
                      //                 children: [
                      //                   Text(
                      //                     'Upload File',
                      //                     style: state.headingTextStyle,
                      //                   ),
                      //                   Text(
                      //                     '  (If Any)',
                      //                     style: TextStyle(
                      //                         fontFamily:
                      //                         SarabunFontFamily.medium,
                      //                         fontSize: 12.sp,
                      //                         color: customTextBlackColor),
                      //                   ),
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 20.h,
                      //               ),
                      //               InkWell(
                      //                 onTap: () async {
                      //                   if (_bookAppointmentLogic
                      //                       .selectedFileName ==
                      //                       null) {
                      //                     _bookAppointmentLogic.filePickerResult =
                      //                     await FilePicker.platform.pickFiles(
                      //                       type: FileType.any,
                      //                       // allowedExtensions: ["jpg", "png", "pdf", "doc"],
                      //                     );
                      //                     if (_bookAppointmentLogic
                      //                         .filePickerResult !=
                      //                         null) {
                      //                       final file = File(
                      //                           _bookAppointmentLogic
                      //                               .filePickerResult!
                      //                               .files[0]
                      //                               .path!);
                      //                       setState(() {});
                      //                       int sizeInBytes = file.lengthSync();
                      //                       double sizeInMb =
                      //                           sizeInBytes / (1024 * 1024);
                      //                       if (sizeInMb > 10) {
                      //                         showDialog(
                      //                             context: context,
                      //                             barrierDismissible: false,
                      //                             builder:
                      //                                 (BuildContext context) {
                      //                               return CustomDialogBox(
                      //                                 title: 'FAILED!'.tr,
                      //                                 titleColor:
                      //                                 customDialogErrorColor,
                      //                                 descriptions:
                      //                                 'File Is Greater Than 10MB'
                      //                                     .tr,
                      //                                 text: 'ok'.tr,
                      //                                 functionCall: () {
                      //                                   Navigator.pop(context);
                      //                                 },
                      //                                 img:
                      //                                 'assets/Icons/dialog_error.svg',
                      //                               );
                      //                             });
                      //                       } else {
                      //                         _bookAppointmentLogic
                      //                             .updateSelectedFileName(
                      //                             _bookAppointmentLogic
                      //                                 .filePickerResult!
                      //                                 .files[0]
                      //                                 .name);
                      //                         setState(() {});
                      //                         log('PICKEDFILE--->>${_bookAppointmentLogic.filePickerResult!.files[0].name}');
                      //                       }
                      //                     }
                      //                   }
                      //                 },
                      //                 child: Container(
                      //                   height: 69.h,
                      //                   width: double.infinity,
                      //                   decoration: BoxDecoration(
                      //                       color: customLightOrangeColor,
                      //                       borderRadius:
                      //                       BorderRadius.circular(8.r)),
                      //                   child: Stack(
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: SvgPicture.asset(
                      //                           'assets/Icons/dottedBorder.svg',
                      //                           width: MediaQuery.of(context)
                      //                               .size
                      //                               .width,
                      //                           fit: BoxFit.fill,
                      //                         ),
                      //                       ),
                      //                       Center(
                      //                         child: _bookAppointmentLogic
                      //                             .selectedFileName !=
                      //                             null
                      //                             ? Padding(
                      //                           padding: const EdgeInsets.all(15.0),
                      //                           child: Row(
                      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                             children: [
                      //                               Expanded(
                      //                                 child: Text(
                      //                                   _bookAppointmentLogic
                      //                                       .selectedFileName!,
                      //                                   softWrap: true,
                      //                                   maxLines: 1,
                      //                                   overflow:
                      //                                   TextOverflow.ellipsis,
                      //                                   style:  TextStyle(
                      //                                       fontFamily:
                      //                                       SarabunFontFamily
                      //                                           .medium,
                      //                                       fontSize: 12.sp,
                      //                                       color:
                      //                                       customOrangeColor),
                      //                                 ),
                      //                               ),
                      //                               InkWell(
                      //                                 onTap: (){
                      //                                   _bookAppointmentLogic
                      //                                       .updateSelectedFileName(null);
                      //                                 },
                      //                                 child: const Icon(
                      //                                   Icons.cancel,
                      //                                   color: customOrangeColor,
                      //                                   size: 25,
                      //                                 ),
                      //                               )
                      //                             ],
                      //                           ),
                      //                         )
                      //                             : Row(
                      //                           mainAxisAlignment:
                      //                           MainAxisAlignment
                      //                               .center,
                      //                           crossAxisAlignment:
                      //                           CrossAxisAlignment
                      //                               .center,
                      //                           children: [
                      //                             SvgPicture.asset(
                      //                               'assets/Icons/uploadIcon.svg',
                      //                               height: 23.h,
                      //                               width: 25.w,
                      //                             ),
                      //                             SizedBox(
                      //                               width: 10.w,
                      //                             ),
                      //                             Text(
                      //                               'Upload Here',
                      //                               style: TextStyle(
                      //                                   fontFamily:
                      //                                   SarabunFontFamily
                      //                                       .medium,
                      //                                   fontSize: 12.sp,
                      //                                   color:
                      //                                   customOrangeColor),
                      //                             )
                      //                           ],
                      //                         ),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 20.h,
                      //       ),
                      //
                      //       ///---payment-method-area
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             color: Colors.transparent,
                      //             borderRadius: BorderRadius.circular(8.r),
                      //             border: Border.all(
                      //                 color: customTextBlackColor, width: 1)),
                      //         child: Padding(
                      //           padding: EdgeInsetsDirectional.fromSTEB(
                      //               20.w, 25.h, 20.w, 7.h),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 'Payment Method',
                      //                 style: state.headingTextStyle,
                      //               ),
                      //               SizedBox(
                      //                 height: 20.h,
                      //               ),
                      //               Wrap(
                      //                 children: List.generate(
                      //                     _bookAppointmentLogic
                      //                         .paymentMethodList.length, (index) {
                      //                   return Padding(
                      //                     padding: index % 2 == 0
                      //                         ? EdgeInsetsDirectional.fromSTEB(
                      //                         0, 0, 8.w, 18.h)
                      //                         : EdgeInsetsDirectional.fromSTEB(
                      //                         8.w, 0.h, 0.w, 18.h),
                      //                     child: InkWell(
                      //                       onTap: () {
                      //                         for (var element in _bookAppointmentLogic
                      //                             .paymentMethodList) {
                      //                           element.isSelected = false;
                      //                         }
                      //                         _bookAppointmentLogic
                      //                             .paymentMethodList[index]
                      //                             .isSelected = true;
                      //                         _bookAppointmentLogic
                      //                             .selectedPaymentType = index;
                      //                         _bookAppointmentLogic.update();
                      //                         setState(() {
                      //                           disableButton = false;
                      //                         });
                      //                       },
                      //                       child: Container(
                      //                         height: 61.h,
                      //                         width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                             .38,
                      //                         decoration: BoxDecoration(
                      //                             color: Colors.white,
                      //                             border: Border.all(
                      //                                 color: _bookAppointmentLogic
                      //                                     .paymentMethodList[
                      //                                 index]
                      //                                     .isSelected!
                      //                                     ? customLightThemeColor
                      //                                     : Colors.white,
                      //                                 width: 2),
                      //                             borderRadius:
                      //                             BorderRadius.circular(8.r),
                      //                             boxShadow: [
                      //                               BoxShadow(
                      //                                 color: _bookAppointmentLogic
                      //                                     .paymentMethodList[
                      //                                 index]
                      //                                     .isSelected!
                      //                                     ? customLightThemeColor
                      //                                     .withOpacity(0.2)
                      //                                     : Colors.grey
                      //                                     .withOpacity(0.2),
                      //                                 spreadRadius: -2,
                      //                                 blurRadius: 15,
                      //                                 // offset: Offset(1,5)
                      //                               )
                      //                             ]),
                      //                         child: Column(
                      //                           crossAxisAlignment:
                      //                           CrossAxisAlignment.center,
                      //                           mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                           children: [
                      //                             Image.asset(
                      //                               '${_bookAppointmentLogic.paymentMethodList[index].image}',
                      //                               width: MediaQuery.of(context)
                      //                                   .size
                      //                                   .width *
                      //                                   .15,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //
                      //       SizedBox(
                      //         height: MediaQuery.of(context).size.height * .15,
                      //       ),
                      //     ]),

                      ///---bottom-bar
                      Positioned(
                        bottom: 0.h,
                        left: 15.w,
                        right: 15.w,
                        child: Center(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 25.h),
                              child: GestureDetector(
                                onHorizontalDragUpdate: (event) async {},
                                onHorizontalDragEnd: (event) {
                                  _generalController.focusOut(context);
                                  _generalController
                                      .updateFormLoaderController(true);
                                  postMethod(
                                      context,
                                      walletPaymentUrl,
                                      {
                                        'token': '123',
                                        'from_user_id':
                                            Get.find<GeneralController>()
                                                .storageBox
                                                .read('userID'),
                                        'to_user_id': Get.find<UserHomeLogic>()
                                            .selectedConsultantID,
                                        'bookAppointmentId':
                                            widget.appointmentId,
                                        // _bookAppointmentLogic
                                        //     .bookAppointmentModel
                                        //     .data!
                                        //     .appointmentNo,
                                        'amount': _bookAppointmentLogic
                                            .selectMentorAppointmentType!.fee,
                                      },
                                      true,
                                      walletPaymentRepo);
                                },
                                child: Container(
                                  height: 56.h,
                                  width: MediaQuery.of(context).size.width * .7,
                                  decoration: BoxDecoration(
                                      color: customThemeColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                      boxShadow: [
                                        BoxShadow(
                                            color: customThemeColor
                                                .withOpacity(0.7),
                                            spreadRadius: -18,
                                            blurRadius: 30,
                                            offset: const Offset(0, 35))
                                      ]),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          paymentSuccessful(),
                                          _bookAppointmentLogic.myWidth == 0.0
                                              ? SvgPicture.asset(
                                                  'assets/Icons/slideArrows.svg',
                                                  height: 12.h,
                                                  width: 42.w,
                                                )
                                              : const SizedBox(),
                                          _bookAppointmentLogic.myWidth == 0.0
                                              ? Text(
                                                  LanguageConstant
                                                      .slideToPay.tr,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          SarabunFontFamily
                                                              .bold,
                                                      fontSize: 16.sp,
                                                      color: const Color(
                                                          0xff8889BB)),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        );
      });
    });
  }

  Widget paymentSuccessful() => Transform.translate(
        offset: Offset(translateX, translateY),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
          width: 29 + Get.find<BookAppointmentLogic>().myWidth,
          height: 29,
          child: Get.find<BookAppointmentLogic>().myWidth > 0.0
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                )
              : Center(
                  child: SvgPicture.asset(
                    'assets/Icons/slideToPayArrowIcon.svg',
                    height: 29.h,
                    width: 29.w,
                  ),
                ),
        ),
      );
}
