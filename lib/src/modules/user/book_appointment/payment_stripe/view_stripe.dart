import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/book_appointment/payment_stripe/repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class StripePaymentView extends StatefulWidget {
  const StripePaymentView({Key? key}) : super(key: key);

  @override
  _StripePaymentViewState createState() => _StripePaymentViewState();
}

class _StripePaymentViewState extends State<StripePaymentView> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<BookAppointmentLogic>().myWidth = 0;
      Get.find<BookAppointmentLogic>().accountCardNumberController.clear();
      Get.find<BookAppointmentLogic>().accountCardHolderNameController.clear();
      Get.find<BookAppointmentLogic>().accountCardExpiresController.clear();
      Get.find<BookAppointmentLogic>().accountCardCvcController.clear();
    });
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
                        fee:
                            '\$${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].fee}',
                        feeImage:
                            '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].appointmentTypeId! - 1]}',
                        isShrink: _bookAppointmentLogic.isShrink3,
                      ),
                    ];
                  },
                  body: Stack(
                    children: [
                      ListView(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 20.h, 15.w, 0),
                          children: [
                            ///---card-heading
                            Text(
                              LanguageConstant.cardDetails.tr,
                              style: state.headingTextStyle,
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            SizedBox(
                                height: 250.h,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/cardBackground.png',
                                      fit: BoxFit.fill,
                                      height: 200.h,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 27.h, horizontal: 21.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ///---card-number
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      LanguageConstant
                                                          .enterCardNumber.tr,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              SarabunFontFamily
                                                                  .regular,
                                                          fontSize: 14.sp,
                                                          color: Colors.white),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          _bookAppointmentLogic
                                                              .accountCardNumberController,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              SarabunFontFamily
                                                                  .semiBold,
                                                          fontSize: 16.sp,
                                                          color: Colors.white),
                                                      cursorColor: Colors.white,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      maxLines: 1,
                                                      inputFormatters: [
                                                        _bookAppointmentLogic
                                                            .cardNumberMask
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'xxxx xxxx xxxx xxxx',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                SarabunFontFamily
                                                                    .semiBold,
                                                            fontSize: 16.sp,
                                                            color:
                                                                Colors.white24),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.w,
                                                                    0.h,
                                                                    0.w,
                                                                    0.h),
                                                        enabledBorder: UnderlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                        border: UnderlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                        focusedBorder: UnderlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                        errorBorder: UnderlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .red)),
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
                                                  ],
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                'assets/Icons/masterCardIcon.svg',
                                                height: 22.h,
                                                width: 37.w,
                                              )
                                            ],
                                          ),

                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                ///---card-holder-name
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .cardHolder.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .regular,
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _bookAppointmentLogic
                                                                  .accountCardHolderNameController,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .semiBold,
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.white),
                                                          cursorColor:
                                                              Colors.white,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          maxLines: 1,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    "[a-z A-Z ]"))
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'xyz',
                                                            hintStyle: TextStyle(
                                                                fontFamily:
                                                                    SarabunFontFamily
                                                                        .semiBold,
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .white24),
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.w,
                                                                        0.h,
                                                                        0.w,
                                                                        0.h),
                                                            enabledBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                            border: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                            errorBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .red)),
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return LanguageConstant
                                                                  .fieldRequired
                                                                  .tr;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                ///---card-expiry
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .expires.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .regular,
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _bookAppointmentLogic
                                                                  .accountCardExpiresController,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .semiBold,
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.white),
                                                          cursorColor:
                                                              Colors.white,
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime,
                                                          maxLines: 1,
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                            _bookAppointmentLogic
                                                                .cardExpiryMask
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'MM/YY',
                                                            hintStyle: TextStyle(
                                                                fontFamily:
                                                                    SarabunFontFamily
                                                                        .semiBold,
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .white24),
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.w,
                                                                        0.h,
                                                                        0.w,
                                                                        0.h),
                                                            enabledBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                            border: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                            errorBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .red)),
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return LanguageConstant
                                                                  .fieldRequired
                                                                  .tr;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                ///---card-cvv
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          LanguageConstant
                                                              .cvv.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .regular,
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _bookAppointmentLogic
                                                                  .accountCardCvcController,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .semiBold,
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.white),
                                                          cursorColor:
                                                              Colors.white,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          obscureText: true,
                                                          maxLines: 1,
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(
                                                                3),
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    "[0-9 ]"))
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'xxx',
                                                            hintStyle: TextStyle(
                                                                fontFamily:
                                                                    SarabunFontFamily
                                                                        .semiBold,
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .white24),
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.w,
                                                                        0.h,
                                                                        0.w,
                                                                        0.h),
                                                            enabledBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                            border: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .transparent)),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                            errorBorder: UnderlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .red)),
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return LanguageConstant
                                                                  .fieldRequired
                                                                  .tr;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .15,
                            ),
                          ]),

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
                                onHorizontalDragUpdate: (event) async {
                                  if (_bookAppointmentLogic
                                          .accountCardHolderNameController
                                          .text
                                          .isNotEmpty &&
                                      _bookAppointmentLogic
                                          .accountCardExpiresController
                                          .text
                                          .isNotEmpty &&
                                      _bookAppointmentLogic
                                          .accountCardCvcController
                                          .text
                                          .isNotEmpty &&
                                      _bookAppointmentLogic
                                          .accountCardNumberController
                                          .text
                                          .isNotEmpty) {
                                    if (event.primaryDelta! > 10) {
                                      _incTansXVal();
                                    }
                                  }
                                },
                                onHorizontalDragEnd: (event) {
                                  if (_bookAppointmentLogic
                                          .accountCardHolderNameController
                                          .text
                                          .isNotEmpty &&
                                      _bookAppointmentLogic
                                          .accountCardExpiresController
                                          .text
                                          .isNotEmpty &&
                                      _bookAppointmentLogic
                                          .accountCardCvcController
                                          .text
                                          .isNotEmpty &&
                                      _bookAppointmentLogic
                                          .accountCardNumberController
                                          .text
                                          .isNotEmpty) {
                                    _generalController.focusOut(context);
                                    _generalController
                                        .updateFormLoaderController(true);
                                    postMethod(
                                        context,
                                        paymentMethodUrl,
                                        {
                                          "mentee_id":
                                              Get.find<GeneralController>()
                                                  .storageBox
                                                  .read('userID'),
                                          "total": _bookAppointmentLogic
                                              .selectMentorAppointmentType!.fee,
                                          "payment_method_code":
                                              _bookAppointmentLogic.paymentName,
                                          // _bookAppointmentLogic
                                          //     .paymentMethodList[
                                          //         _bookAppointmentLogic
                                          //             .selectedPaymentType!]
                                          //     .title,
                                          "cardInfo": {
                                            "number": _bookAppointmentLogic
                                                .accountCardNumberController
                                                .text
                                                .replaceAll(' ', ''),
                                            "exp_month": _bookAppointmentLogic
                                                .accountCardExpiresController
                                                .text
                                                .toString()
                                                .substring(0, 2),
                                            "exp_year": _bookAppointmentLogic
                                                .accountCardExpiresController
                                                .text
                                                .toString()
                                                .substring(3, 5),
                                            "cvc": _bookAppointmentLogic
                                                .accountCardCvcController.text
                                          },
                                          "shipping_address": {
                                            "id": "",
                                            "first_name": "shahzad",
                                            "last_name": "Tariq",
                                            "email": "fharshad842@gmail.com",
                                            "city_id": 85335,
                                            "state_id": 3176,
                                            "country_id": 167,
                                            "zip_code": "38000",
                                            "address":
                                                "Bismillah General Store Back Saira Mall Plaza Dogar Basti\nPeople Colony # 1 D Ground Faisalabad",
                                            "phone": "034677992777"
                                          },
                                          "shipping_id": 1,
                                          "plateForm": "mobile",
                                          "paytm_mode": "",
                                          "bookAppointmentId":
                                              _bookAppointmentLogic
                                                  .bookAppointmentModel
                                                  .data!
                                                  .appointmentNo
                                        },
                                        true,
                                        stripePaymentRepo);
                                  }
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
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                          0xff8889BB),
                                                    ),
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

  _incTansXVal() async {
    int canLoop = -1;
    for (var i = 0; canLoop == -1; i++) {
      await Future.delayed(const Duration(milliseconds: 1), () {
        setState(() {
          if (translateX + 1 <
              MediaQuery.of(context).size.width -
                  (200 + Get.find<BookAppointmentLogic>().myWidth)) {
            translateX += 1;
            Get.find<BookAppointmentLogic>().myWidth =
                MediaQuery.of(context).size.width -
                    (200 + Get.find<BookAppointmentLogic>().myWidth);
          } else {
            canLoop = 1;
          }
        });
      });
    }
  }
}
