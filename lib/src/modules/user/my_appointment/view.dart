import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/appointment_detail/logic.dart';
import 'package:ista_app/src/modules/user/my_appointment/get_repo.dart';
import 'package:ista_app/src/modules/user/my_appointment/logic.dart';
import 'package:ista_app/src/modules/user/my_appointment/widgets/appointment_detail_box.dart';
import 'package:ista_app/src/modules/user/my_appointment/widgets/page_loader.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:ista_app/src/widgets/sliver_delegate_tab_fix.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resize/resize.dart';

class MyAppointmentPage extends StatefulWidget {
  const MyAppointmentPage({Key? key}) : super(key: key);

  @override
  State<MyAppointmentPage> createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(MyAppointmentLogic());

  final state = Get.find<MyAppointmentLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMethod(
        context,
        getUserAllAppointmentsURL,
        {
          'token': '123',
          'mentee_id': Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getUserAllAppointmentsRepo);
    Get.find<MyAppointmentLogic>().tabController =
        TabController(length: logic.tabBarList.length, vsync: this);

    Get.find<MyAppointmentLogic>().scrollController = ScrollController()
      ..addListener(Get.find<MyAppointmentLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<MyAppointmentLogic>()
        .scrollController!
        .removeListener(Get.find<MyAppointmentLogic>().scrollListener);
    Get.find<MyAppointmentLogic>().scrollController!.dispose();
    Get.find<MyAppointmentLogic>().tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<MyAppointmentLogic>(builder: (_myAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: _myAppointmentLogic.getUserAppointmentLoader!
                ? const PageLoaderForAppointments()
                : NestedScrollView(
                    controller: _myAppointmentLogic.scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        ///---header
                        MyCustomSliverAppBar(
                          heading: LanguageConstant.myAppointments.tr,
                          subHeading: LanguageConstant
                              .manageAndSeeYourAppointmentsLog.tr,
                          isShrink: _myAppointmentLogic.isShrink,
                        ),
                        SliverPersistentHeader(
                          delegate: SliverAppBarDelegate(TabBar(
                            indicator: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(6), // Creates border
                                color: customLightThemeColor),
                            indicatorSize: TabBarIndicatorSize.tab,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.w, 5.h, 10.w, 5.h),
                            labelPadding:
                                EdgeInsets.symmetric(horizontal: 25.w),
                            automaticIndicatorColorAdjustment: true,
                            isScrollable: true,
                            controller: _myAppointmentLogic.tabController,
                            labelColor: Colors.white,
                            labelStyle: state.tabBarSelectedTextStyle,
                            unselectedLabelStyle:
                                state.tabBarUnSelectedTextStyle,
                            unselectedLabelColor: customLightThemeColor,
                            tabs: _myAppointmentLogic.tabBarList,
                          )),
                          pinned: true,
                        ),
                      ];
                    },
                    body: SmartRefresher(
                      controller:
                          _myAppointmentLogic.refreshAppointmentsController,
                      onRefresh: () {
                        getMethod(
                            context,
                            getUserAllAppointmentsURL,
                            {
                              'token': '123',
                              'mentee_id': Get.find<GeneralController>()
                                  .storageBox
                                  .read('userID'),
                            },
                            true,
                            getUserAllAppointmentsRepo);
                      },
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: _myAppointmentLogic.tabController,
                        children: [
                          ///---pending
                          (_myAppointmentLogic.getUserAppointmentModel.data
                                          ?.pendingAppointments?.data ??
                                      [])
                                  .isEmpty
                              ? Center(
                                  child: Text(
                                    LanguageConstant.noRecordFound.tr,
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.regular,
                                        fontSize: 16.sp,
                                        color: customTextBlackColor),
                                  ),
                                )
                              : GestureDetector(
                                  onPanDown: (e) {
                                    _myAppointmentLogic
                                        .refreshAppointmentsController
                                        .requestRefresh();
                                  },
                                  child: ListView(
                                    padding: const EdgeInsetsDirectional.all(0),
                                    children: List.generate(
                                        _myAppointmentLogic
                                            .getUserAppointmentModel
                                            .data!
                                            .pendingAppointments!
                                            .data!
                                            .length, (index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.put(AppointmentDetailLogic());
                                              Get.find<AppointmentDetailLogic>()
                                                      .selectedAppointmentData =
                                                  _myAppointmentLogic
                                                      .getUserAppointmentModel
                                                      .data!
                                                      .pendingAppointments!
                                                      .data![index];

                                              Get.find<AppointmentDetailLogic>()
                                                  .appointmentStatus = 0;
                                              Get.find<AppointmentDetailLogic>()
                                                  .update();
                                              Get.toNamed(
                                                  PageRoutes.appointmentDetail);
                                            },
                                            child: AppointmentDetailBox(
                                              image: _myAppointmentLogic
                                                      .getUserAppointmentModel
                                                      .data!
                                                      .pendingAppointments!
                                                      .data?[index]
                                                      .mentor
                                                      ?.imagePath ??
                                                  '...',
                                              name:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data?.pendingAppointments?.data?[index].mentor?.firstName ?? '...'} '
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data?.pendingAppointments?.data?[index].mentor?.lastName ?? ""}',
                                              category:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.pendingAppointments!.data![index].category}',
                                              fee:
                                                  '\$${_myAppointmentLogic.getUserAppointmentModel.data!.pendingAppointments!.data![index].payment!} ${LanguageConstant.fees.tr}',
                                              type:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.pendingAppointments!.data![index].appointmentTypeString}'
                                                      .capitalizeFirst,
                                              typeIcon: _myAppointmentLogic
                                                      .imagesForAppointmentTypes[
                                                  (_myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .pendingAppointments!
                                                          .data![index]
                                                          .appointmentTypeId!) -
                                                      1],
                                              status: 0,
                                              date: _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .pendingAppointments!
                                                          .data![index]
                                                          .date ==
                                                      null
                                                  ? null
                                                  : DateFormat('dd/MM/yy')
                                                      .format(DateTime.parse(
                                                          _myAppointmentLogic
                                                              .getUserAppointmentModel
                                                              .data!
                                                              .pendingAppointments!
                                                              .data![index]
                                                              .date!)),
                                              time: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .pendingAppointments!
                                                  .data![index]
                                                  .time,
                                              color: customOrangeColor,
                                              rating: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .pendingAppointments!
                                                  .data![index]
                                                  .rating!
                                                  .toDouble(),
                                              isPaid: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .pendingAppointments!
                                                  .data![index]
                                                  .isPaid,
                                            ),
                                          ),
                                          index ==
                                                  _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .pendingAppointments!
                                                          .data!
                                                          .length -
                                                      1
                                              ? Column(
                                                  children: [
                                                    _myAppointmentLogic
                                                                .getUserAppointmentModel
                                                                .data!
                                                                .pendingAppointments!
                                                                .currentPage! <
                                                            _myAppointmentLogic
                                                                .getUserAppointmentModel
                                                                .data!
                                                                .pendingAppointments!
                                                                .lastPage!
                                                        ? _myAppointmentLogic
                                                                .getUserAppointmentMoreLoader!
                                                            ? Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 25
                                                                            .h),
                                                                child:
                                                                    const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color:
                                                                        customThemeColor,
                                                                  ),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 25
                                                                            .h),
                                                                child: Center(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            30.h),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _myAppointmentLogic
                                                                            .update();
                                                                        _myAppointmentLogic
                                                                            .updateGetUserAppointmentMoreLoader(true);

                                                                        getMethod(
                                                                            context,
                                                                            getUserAllAppointmentsURL,
                                                                            {
                                                                              'token': '123',
                                                                              'mentee_id': Get.find<GeneralController>().storageBox.read('userID'),
                                                                              'appointment_status': _myAppointmentLogic.getUserAppointmentModel.data!.pendingAppointments!.data![index].appointmentStatus,
                                                                              'page': _myAppointmentLogic.getUserAppointmentModel.data!.pendingAppointments!.currentPage! + 1
                                                                            },
                                                                            true,
                                                                            getUserAllAppointmentsMoreRepo);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            36.h,
                                                                        width:
                                                                            116.w,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            border: Border.all(color: customThemeColor),
                                                                            borderRadius: BorderRadius.circular(18.r)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            LanguageConstant.loadMore.tr,
                                                                            style: TextStyle(
                                                                                fontFamily: SarabunFontFamily.medium,
                                                                                fontSize: 12.sp,
                                                                                color: customThemeColor),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                        : const SizedBox(),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .1,
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox()
                                        ],
                                      );
                                    }),
                                  ),
                                ),

                          ///---accepted
                          (_myAppointmentLogic.getUserAppointmentModel.data
                                          ?.acceptedAppointments?.data ??
                                      [])
                                  .isEmpty
                              ? Center(
                                  child: Text(
                                    LanguageConstant.noRecordFound.tr,
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.regular,
                                        fontSize: 16.sp,
                                        color: customTextBlackColor),
                                  ),
                                )
                              : GestureDetector(
                                  onPanDown: (e) {
                                    // _myAppointmentLogic
                                    //     .refreshAppointmentsController
                                    //     .requestRefresh();
                                  },
                                  child: ListView(
                                    padding: const EdgeInsetsDirectional.all(0),
                                    children: List.generate(
                                        _myAppointmentLogic
                                            .getUserAppointmentModel
                                            .data!
                                            .acceptedAppointments!
                                            .data!
                                            .length, (index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.put(AppointmentDetailLogic());
                                              Get.find<AppointmentDetailLogic>()
                                                      .selectedAppointmentData =
                                                  _myAppointmentLogic
                                                      .getUserAppointmentModel
                                                      .data!
                                                      .acceptedAppointments!
                                                      .data![index];
                                              Get.find<AppointmentDetailLogic>()
                                                  .appointmentStatus = 1;
                                              Get.find<AppointmentDetailLogic>()
                                                  .update();
                                              Get.toNamed(
                                                  PageRoutes.appointmentDetail);
                                            },
                                            child: AppointmentDetailBox(
                                              image: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .acceptedAppointments!
                                                  .data![index]
                                                  .mentor
                                                  ?.imagePath,
                                              name: _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .acceptedAppointments!
                                                          .data![index]
                                                          .mentor
                                                          ?.firstName ==
                                                      null
                                                  ? '...'
                                                  : '${_myAppointmentLogic.getUserAppointmentModel.data!.acceptedAppointments!.data![index].mentor!.firstName} '
                                                      '${_myAppointmentLogic.getUserAppointmentModel.data!.acceptedAppointments!.data![index].mentor!.lastName}',
                                              category:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.acceptedAppointments!.data![index].category}',
                                              fee:
                                                  '\$${_myAppointmentLogic.getUserAppointmentModel.data!.acceptedAppointments!.data![index].payment!} ${LanguageConstant.fees.tr}',
                                              type:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.acceptedAppointments!.data![index].appointmentTypeString}'
                                                      .capitalizeFirst,
                                              typeIcon: _myAppointmentLogic
                                                      .imagesForAppointmentTypes[
                                                  (_myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .acceptedAppointments!
                                                          .data![index]
                                                          .appointmentTypeId!) -
                                                      1],
                                              status: 1,
                                              date: _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .acceptedAppointments!
                                                          .data![index]
                                                          .date ==
                                                      null
                                                  ? null
                                                  : DateFormat('dd/MM/yy')
                                                      .format(DateTime.parse(
                                                          _myAppointmentLogic
                                                              .getUserAppointmentModel
                                                              .data!
                                                              .acceptedAppointments!
                                                              .data![index]
                                                              .date!)),
                                              time: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .acceptedAppointments!
                                                  .data![index]
                                                  .time,
                                              color: customLightThemeColor,
                                              rating: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .acceptedAppointments!
                                                  .data![index]
                                                  .rating!
                                                  .toDouble(),
                                              isPaid: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .acceptedAppointments!
                                                  .data![index]
                                                  .isPaid,
                                            ),
                                          ),
                                          index ==
                                                  _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .acceptedAppointments!
                                                          .data!
                                                          .length -
                                                      1
                                              ? SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .1,
                                                )
                                              : const SizedBox()
                                        ],
                                      );
                                    }),
                                  ),
                                ),

                          ///---completed
                          (_myAppointmentLogic.getUserAppointmentModel.data
                                          ?.completedAppointments?.data ??
                                      [])
                                  .isEmpty
                              ? Center(
                                  child: Text(
                                    LanguageConstant.noRecordFound.tr,
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.regular,
                                        fontSize: 16.sp,
                                        color: customTextBlackColor),
                                  ),
                                )
                              : GestureDetector(
                                  onPanDown: (e) {
                                    // _myAppointmentLogic
                                    //     .refreshAppointmentsController
                                    //     .requestRefresh();
                                  },
                                  child: ListView(
                                    padding: const EdgeInsetsDirectional.all(0),
                                    children: List.generate(
                                        _myAppointmentLogic
                                            .getUserAppointmentModel
                                            .data!
                                            .completedAppointments!
                                            .data!
                                            .length, (index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.put(AppointmentDetailLogic());
                                              Get.find<AppointmentDetailLogic>()
                                                      .selectedAppointmentData =
                                                  _myAppointmentLogic
                                                      .getUserAppointmentModel
                                                      .data!
                                                      .completedAppointments!
                                                      .data![index];
                                              Get.find<AppointmentDetailLogic>()
                                                  .appointmentStatus = 2;
                                              Get.find<AppointmentDetailLogic>()
                                                  .update();
                                              Get.toNamed(
                                                  PageRoutes.appointmentDetail);
                                            },
                                            child: AppointmentDetailBox(
                                              image: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .completedAppointments!
                                                  .data![index]
                                                  .mentor
                                                  ?.imagePath,
                                              name: _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .completedAppointments!
                                                          .data![index]
                                                          .mentor
                                                          ?.firstName ==
                                                      null
                                                  ? '...'
                                                  : '${_myAppointmentLogic.getUserAppointmentModel.data!.completedAppointments!.data![index].mentor!.firstName} '
                                                      '${_myAppointmentLogic.getUserAppointmentModel.data!.completedAppointments!.data![index].mentor!.lastName}',
                                              category:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.completedAppointments!.data![index].category}',
                                              fee:
                                                  '\$${_myAppointmentLogic.getUserAppointmentModel.data!.completedAppointments!.data![index].payment!} ${LanguageConstant.fees.tr}',
                                              type:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.completedAppointments!.data![index].appointmentTypeString}'
                                                      .capitalizeFirst,
                                              typeIcon: _myAppointmentLogic
                                                      .imagesForAppointmentTypes[
                                                  (_myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .completedAppointments!
                                                          .data![index]
                                                          .appointmentTypeId!) -
                                                      1],
                                              date: _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .completedAppointments!
                                                          .data![index]
                                                          .date ==
                                                      null
                                                  ? null
                                                  : DateFormat('dd/MM/yy')
                                                      .format(DateTime.parse(
                                                          _myAppointmentLogic
                                                              .getUserAppointmentModel
                                                              .data!
                                                              .completedAppointments!
                                                              .data![index]
                                                              .date!)),
                                              time: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .completedAppointments!
                                                  .data![index]
                                                  .time,
                                              rating: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .completedAppointments!
                                                  .data![index]
                                                  .rating!
                                                  .toDouble(),
                                              status: 2,
                                              color: customGreenColor,
                                              isPaid: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .completedAppointments!
                                                  .data![index]
                                                  .isPaid,
                                            ),
                                          ),
                                          index ==
                                                  _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .completedAppointments!
                                                          .data!
                                                          .length -
                                                      1
                                              ? SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .1,
                                                )
                                              : const SizedBox()
                                        ],
                                      );
                                    }),
                                  ),
                                ),

                          ///---cancelled
                          (_myAppointmentLogic.getUserAppointmentModel.data
                                          ?.cancelledAppointments?.data ??
                                      [])
                                  .isEmpty
                              ? Center(
                                  child: Text(
                                    LanguageConstant.noRecordFound.tr,
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.regular,
                                        fontSize: 16.sp,
                                        color: customTextBlackColor),
                                  ),
                                )
                              : GestureDetector(
                                  onPanDown: (e) {
                                    // _myAppointmentLogic
                                    //     .refreshAppointmentsController
                                    //     .requestRefresh();
                                  },
                                  child: ListView(
                                    padding: const EdgeInsetsDirectional.all(0),
                                    children: List.generate(
                                        _myAppointmentLogic
                                            .getUserAppointmentModel
                                            .data!
                                            .cancelledAppointments!
                                            .data!
                                            .length, (index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.put(AppointmentDetailLogic());
                                              Get.find<AppointmentDetailLogic>()
                                                      .selectedAppointmentData =
                                                  _myAppointmentLogic
                                                      .getUserAppointmentModel
                                                      .data!
                                                      .cancelledAppointments!
                                                      .data![index];
                                              Get.find<AppointmentDetailLogic>()
                                                  .appointmentStatus = 3;
                                              Get.find<AppointmentDetailLogic>()
                                                  .update();
                                              Get.toNamed(
                                                  PageRoutes.appointmentDetail);
                                            },
                                            child: AppointmentDetailBox(
                                              image: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .cancelledAppointments!
                                                  .data![index]
                                                  .mentor!
                                                  .imagePath,
                                              name: _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .cancelledAppointments!
                                                          .data![index]
                                                          .mentor!
                                                          .firstName ==
                                                      null
                                                  ? '...'
                                                  : '${_myAppointmentLogic.getUserAppointmentModel.data!.cancelledAppointments!.data![index].mentor!.firstName} '
                                                      '${_myAppointmentLogic.getUserAppointmentModel.data!.cancelledAppointments!.data![index].mentor!.lastName}',
                                              category:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.cancelledAppointments!.data![index].category}',
                                              fee:
                                                  '\$${_myAppointmentLogic.getUserAppointmentModel.data!.cancelledAppointments!.data![index].payment!} ${LanguageConstant.fees.tr}',
                                              type:
                                                  '${_myAppointmentLogic.getUserAppointmentModel.data!.cancelledAppointments!.data![index].appointmentTypeString}'
                                                      .capitalizeFirst,
                                              typeIcon: _myAppointmentLogic
                                                      .imagesForAppointmentTypes[
                                                  (_myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .cancelledAppointments!
                                                          .data![index]
                                                          .appointmentTypeId!) -
                                                      1],
                                              date: _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .cancelledAppointments!
                                                          .data![index]
                                                          .date ==
                                                      null
                                                  ? null
                                                  : DateFormat('dd/MM/yy')
                                                      .format(DateTime.parse(
                                                          _myAppointmentLogic
                                                              .getUserAppointmentModel
                                                              .data!
                                                              .cancelledAppointments!
                                                              .data![index]
                                                              .date!)),
                                              time: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .cancelledAppointments!
                                                  .data![index]
                                                  .time,
                                              rating: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .cancelledAppointments!
                                                  .data![index]
                                                  .rating!
                                                  .toDouble(),
                                              status: 3,
                                              color: customRedColor,
                                              isPaid: _myAppointmentLogic
                                                  .getUserAppointmentModel
                                                  .data!
                                                  .cancelledAppointments!
                                                  .data![index]
                                                  .isPaid,
                                            ),
                                          ),
                                          index ==
                                                  _myAppointmentLogic
                                                          .getUserAppointmentModel
                                                          .data!
                                                          .cancelledAppointments!
                                                          .data!
                                                          .length -
                                                      1
                                              ? SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .1,
                                                )
                                              : const SizedBox()
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                        ],
                      ),
                    )),
          ),
        );
      });
    });
  }
}
