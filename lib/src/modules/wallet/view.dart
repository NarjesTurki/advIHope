import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/book_appointment/post_repo.dart';
import 'package:ista_app/src/modules/wallet/logic.dart';
import 'package:ista_app/src/modules/wallet/repo_get.dart';
import 'package:ista_app/src/modules/wallet/widget/custom_dialog_for_withdraw_amount.dart';
import 'package:ista_app/src/modules/wallet/widget/payment_popup.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/notification_icon.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final logic = Get.put(WalletLogic());

  final state = Get.find<WalletLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<WalletLogic>().scrollController = ScrollController()
      ..addListener(Get.find<WalletLogic>().scrollListener);

    getMethod(
        context,
        getWalletBalanceUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID'),
        },
        true,
        getWalletBalanceRepo);
    getMethod(
        context,
        getWalletTransactionUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID'),
        },
        true,
        getWalletTransactionRepo);

    getMethod(context, getPaymentMethodsUrl, {'token': 123, 'platform': 'app'},
        true, getPaymentMethodsRepo);
  }

  @override
  void dispose() {
    Get.find<WalletLogic>()
        .scrollController!
        .removeListener(Get.find<WalletLogic>().scrollListener);
    Get.find<WalletLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<WalletLogic>(builder: (_walletLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            inAsyncCall: _generalController.formLoaderController,
            child: Scaffold(
              backgroundColor: const Color(0xffFBFBFB),
              body: NestedScrollView(
                  controller: _walletLogic.scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      SliverAppBar(
                          expandedHeight:
                              MediaQuery.of(context).size.height * .30,
                          floating: true,
                          pinned: true,
                          snap: false,
                          elevation: 0,
                          backgroundColor: _walletLogic.isShrink
                              ? customThemeColor
                              : Colors.transparent,
                          leading: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/Icons/whiteBackArrow.svg'),
                              ],
                            ),
                          ),
                          actions: const [
                            ///---notifications
                            CustomNotificationIcon(
                              color: Colors.white,
                            )
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            background: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10.r))),
                              child: Column(children: [
                                Stack(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/bookAppointmentAppBar.svg',
                                      width: MediaQuery.of(context).size.width *
                                          .10,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .30,
                                      fit: BoxFit.fill,
                                    ),
                                    SafeArea(
                                        child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.w, 25.h, 16.w, 16.h),
                                      child: Stack(children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 45.h,
                                              ),
                                              Text(
                                                  LanguageConstant
                                                      .amountInWallet.tr,
                                                  style: state.descTextStyle),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _walletLogic
                                                          .getWalletBalanceLoader!
                                                      ? SizedBox(
                                                          height: 20.h,
                                                          width: 100.w,
                                                          child: SkeletonLoader(
                                                              period:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                              highlightColor:
                                                                  Colors.grey,
                                                              direction:
                                                                  SkeletonDirection
                                                                      .ltr,
                                                              builder:
                                                                  Container(
                                                                height: 20.h,
                                                                width: 100.w,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10
                                                                            .r),
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        )
                                                      : Text(
                                                          '${Get.find<GeneralController>().storageBox.read('currency') ?? ""}${_walletLogic.getWalletBalanceModel.data?.userBalance ?? '0'}',
                                                          style: TextStyle(
                                                            fontSize: 28.sp,
                                                            fontFamily:
                                                                SarabunFontFamily
                                                                    .bold,
                                                            color: Colors.white,
                                                          )),
                                                  if (_generalController
                                                          .storageBox
                                                          .read('userRole') ==
                                                      'Mentee')
                                                    InkWell(
                                                      onTap: () {
                                                        paymentBottomSheetForWallet(
                                                            context);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 20.r,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Center(
                                                            child: SvgPicture
                                                                .asset(
                                                          'assets/Icons/add.svg',
                                                          height: 20.h,
                                                          width: 20.w,
                                                          color: Colors.red,
                                                          fit: BoxFit.cover,
                                                        )),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ]),
                                      ]),
                                    )),
                                  ],
                                ),
                              ]),
                            ),
                          ))
                    ];
                  },
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(LanguageConstant.transactionLog.tr,
                                      style: state.recordTextStyle),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            _walletLogic.getAllTransactionLoader!
                                ? SkeletonLoader(
                                    period: const Duration(seconds: 2),
                                    highlightColor: Colors.grey,
                                    direction: SkeletonDirection.ltr,
                                    builder: Wrap(
                                      children: List.generate(10, (index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
                                          child: Container(
                                            height: 70,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                          ),
                                        );
                                      }),
                                    ))
                                : _walletLogic.getAllTransactionList.isEmpty
                                    ? Center(
                                        child: Text(
                                          LanguageConstant.notAvailableYet.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              fontFamily:
                                                  SarabunFontFamily.bold,
                                              color: Colors.black),
                                        ),
                                      )
                                    : Wrap(
                                        children: List.generate(
                                        _walletLogic
                                            .getAllTransactionList.length,
                                        (index) => Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.w, 0, 16.w, 15.h),
                                          child: Container(
                                            // height: 90.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: customTextFieldColor),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 15.w),
                                                  Expanded(
                                                      child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: _walletLogic
                                                                .getAllTransactionList[
                                                                    index]
                                                                .type
                                                                .toString() ==
                                                            'deposit'
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        6.w,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 12.r,
                                                                  backgroundColor:
                                                                      customLightThemeColor,
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_downward,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 6.h,
                                                                ),
                                                                Text(
                                                                  _walletLogic
                                                                      .getAllTransactionList[
                                                                          index]
                                                                      .type
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  style: state
                                                                      .typeTextStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 12.r,
                                                                backgroundColor:
                                                                    customLightThemeColor,
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_upward,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 6.h,
                                                              ),
                                                              Text(
                                                                _walletLogic
                                                                    .getAllTransactionList[
                                                                        index]
                                                                    .type
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style: state
                                                                    .typeTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                  )),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 30,
                                                          child: ColorFiltered(
                                                            colorFilter:
                                                                ColorFilter
                                                                    .mode(
                                                              customLightThemeColor,
                                                              BlendMode.srcIn,
                                                            ),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/Icons/feeIcon.svg',
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          '  ${Get.find<GeneralController>().storageBox.read('currency')}${_walletLogic.getAllTransactionList[index].amount.toString()}',
                                                          style: state
                                                              .feeTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _walletLogic
                                                          .getAllTransactionList[
                                                              index]
                                                          .createdAt
                                                          .toString()
                                                          .substring(0, 10),
                                                      style:
                                                          state.dateTextStyle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                          ],
                        ),
                      ),
                      _walletLogic.getWalletBalanceLoader!
                          ? const SizedBox()
                          : _generalController.storageBox.read('userRole') ==
                                      'Mentee' ||
                                  _walletLogic.getWalletBalanceModel.data!
                                          .userBalance ==
                                      '0'
                              ? const SizedBox()
                              : Positioned(
                                  bottom: 0.h,
                                  left: 15.w,
                                  right: 15.w,
                                  child: InkWell(
                                    onTap: () {
                                      _walletLogic.withdrawAmountController
                                          .clear();
                                      customDialogForWithdrawAmount(context);
                                    },
                                    child: MyCustomBottomBar(
                                      title: LanguageConstant.goForWithdraw.tr,
                                      disable: false,
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
}
