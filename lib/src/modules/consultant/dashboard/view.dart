import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/logic.dart';
import 'package:ista_app/src/modules/consultant/dashboard/get_repo.dart';
import 'package:ista_app/src/modules/consultant/dashboard/logic.dart';
import 'package:ista_app/src/modules/consultant/dashboard/repo_get.dart';
import 'package:ista_app/src/modules/consultant/dashboard/repo_post.dart';
import 'package:ista_app/src/modules/consultant/dashboard/view_approval_waiting.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:ista_app/src/modules/image_full_view/view.dart';
import 'package:ista_app/src/modules/user/home/get_repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/linear_progress_bar.dart';
import 'package:ista_app/src/widgets/notification_icon.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:progress_indicator/progress_indicator.dart';

import '../../user_profile/repo.dart';

class ConsultantDashboardPage extends StatefulWidget {
  const ConsultantDashboardPage({Key? key}) : super(key: key);

  @override
  State<ConsultantDashboardPage> createState() =>
      _ConsultantDashboardPageState();
}

class _ConsultantDashboardPageState extends State<ConsultantDashboardPage> {
  final logic = Get.put(DashboardLogic());

  final state = Get.find<DashboardLogic>().state;

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return LanguageConstant.goodMorning.tr;
    }
    if ((timeNow > 12) && (timeNow <= 16)) {
      return LanguageConstant.goodAfternoon.tr;
    }
    if ((timeNow > 16) && (timeNow < 20)) {
      return LanguageConstant.goodEvening.tr;
    }
    return LanguageConstant.goodNight.tr;
  }

  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMethod(
        context,
        getUserProfileUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getUserProfileForEditRepo);
    Get.find<DashboardLogic>().scrollController = ScrollController()
      ..addListener(Get.find<DashboardLogic>().scrollListener);
    Get.find<GeneralController>().updateFcmToken(context);
    /*  getMethod(
        context,
        getUserProfileUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getUserProfileRepo);*/
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      if (!logic.approvalCheckerApiStopLoader!) {
        getMethod(
            context,
            mentorApprovalStatusUrl,
            {
              'token': '123',
              'mentor_id':
                  Get.find<GeneralController>().storageBox.read('userID')
            },
            true,
            getMentorApprovalRepo);
      }
    });

    getMethod(
        context,
        getAppointmentCountForMentorUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getAppointmentCountMentorRepo);

    getMethod(
        context,
        mentorTodayAppointmentUrl,
        {
          'token': '123',
          'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
        },
        true,
        getMentorTodayAppointmentRepo);
    getMethod(
        context,
        mentorRatingsUrl,
        {
          'token': '123',
          'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
        },
        true,
        getRatingMentorRepo);
    if (!Get.find<GeneralController>().storageBox.hasData('onlineStatus')) {
      postMethod(
          context,
          changeMentorOnlineStatusUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
            'status': 'online'
          },
          true,
          changeMentorOnlineStatusRepo);
    }
  }

  @override
  void dispose() {
    Get.find<DashboardLogic>().refreshAppointmentsController.dispose();
    Get.find<DashboardLogic>()
        .scrollController!
        .removeListener(Get.find<DashboardLogic>().scrollListener);
    Get.find<DashboardLogic>().scrollController!.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String greetingMes = greetingMessage();
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<DashboardLogic>(
          builder: (_dashboardLogic) =>
              _dashboardLogic.approvalCheckerApiLoader!
                  ? Scaffold(
                      body: SafeArea(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Image.asset(
                              'assets/images/loaderGif.gif',
                              width: MediaQuery.of(context).size.width * .6,
                            ))),
                      ),
                    )
                  : _dashboardLogic
                              .mentorApprovalCheckModel.data?.mentor?.status ==
                          0
                      ? const MentorApprovalWaitingView()
                      : ModalProgressHUD(
                          progressIndicator: const CircularProgressIndicator(
                              color: customThemeColor),
                          inAsyncCall: _generalController.formLoaderController,
                          child: GestureDetector(
                            onTap: () {
                              _generalController.focusOut(context);
                            },
                            child: Scaffold(
                              backgroundColor: Colors.white,
                              body: NestedScrollView(
                                  controller: _dashboardLogic.scrollController,
                                  headerSliverBuilder: (BuildContext context,
                                      bool innerBoxIsScrolled) {
                                    return <Widget>[
                                      ///---header
                                      SliverAppBar(
                                        expandedHeight:
                                            MediaQuery.of(context).size.height *
                                                .28,
                                        floating: true,
                                        pinned: true,
                                        snap: false,
                                        elevation: 0,
                                        backgroundColor:
                                            _dashboardLogic.isShrink
                                                ? customThemeColor
                                                : Colors.transparent,
                                        leading: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                PageRoutes.consultantDrawer);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ColorFiltered(
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Colors.white,
                                                        BlendMode.srcIn),
                                                child: SvgPicture.asset(
                                                    'assets/Icons/drawerIcon.svg'),
                                              ),
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
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        bottom: Radius.circular(
                                                            40.r))),
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/bookAppointmentAppBar.svg',
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .30,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    SafeArea(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.w,
                                                                    25.h,
                                                                    16.w,
                                                                    16.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 45.h,
                                                            ),
                                                            Text(
                                                              LanguageConstant
                                                                  .dashboard.tr,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      SarabunFontFamily
                                                                          .bold,
                                                                  fontSize:
                                                                      28.sp,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  LanguageConstant
                                                                      .manageAllOfYourAppointment
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          SarabunFontFamily
                                                                              .medium,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                  body: SmartRefresher(
                                    controller: _dashboardLogic
                                        .refreshAppointmentsController,
                                    onRefresh: () {
                                      /*getMethod(
                                          context,
                                          getUserProfileUrl,
                                          {
                                            'token': '123',
                                            'user_id':
                                                Get.find<GeneralController>()
                                                    .storageBox
                                                    .read('userID')
                                          },
                                          true,
                                          getUserProfileRepo);*/
                                      getMethod(
                                          context,
                                          getAppointmentCountForMentorUrl,
                                          {
                                            'token': '123',
                                            'user_id':
                                                Get.find<GeneralController>()
                                                    .storageBox
                                                    .read('userID')
                                          },
                                          true,
                                          getAppointmentCountMentorRepo);

                                      getMethod(
                                          context,
                                          mentorTodayAppointmentUrl,
                                          {
                                            'token': '123',
                                            'mentor_id':
                                                Get.find<GeneralController>()
                                                    .storageBox
                                                    .read('userID'),
                                          },
                                          true,
                                          getMentorTodayAppointmentRepo);
                                      getMethod(
                                          context,
                                          mentorRatingsUrl,
                                          {
                                            'token': '123',
                                            'mentor_id':
                                                Get.find<GeneralController>()
                                                    .storageBox
                                                    .read('userID'),
                                          },
                                          true,
                                          getRatingMentorRepo);
                                      if (!Get.find<GeneralController>()
                                          .storageBox
                                          .hasData('onlineStatus')) {
                                        postMethod(
                                            context,
                                            changeMentorOnlineStatusUrl,
                                            {
                                              'token': '123',
                                              'user_id':
                                                  Get.find<GeneralController>()
                                                      .storageBox
                                                      .read('userID'),
                                              'status': 'online'
                                            },
                                            true,
                                            changeMentorOnlineStatusRepo);
                                      }
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0.h, 0, 0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ///---mentor-detail
                                              _generalController
                                                          .getConsultantProfileModel
                                                          .data ==
                                                      null
                                                  ? const SizedBox()
                                                  : Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(15.w, 0,
                                                                  15.w, 0.h),
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.r)),
                                                        color:
                                                            customTextFieldColor,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0,
                                                                      10.h,
                                                                      0,
                                                                      10.h),
                                                          child: ListTile(
                                                            leading:
                                                                CircleAvatar(
                                                              radius: 35.r,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: _generalController
                                                                          .getConsultantProfileModel
                                                                          .data!
                                                                          .userDetail!
                                                                          .imagePath ==
                                                                      null
                                                                  ? const SizedBox()
                                                                  : Stack(
                                                                      children: [
                                                                        Hero(
                                                                          tag: _generalController.getConsultantProfileModel.data!.userDetail!.imagePath!.contains('assets')
                                                                              ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}'
                                                                              : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                                                          child:
                                                                              Material(
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                Get.to(ImageViewScreen(
                                                                                  networkImage: _generalController.getConsultantProfileModel.data!.userDetail!.imagePath!.contains('assets') ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}' : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                                                                ));
                                                                              },
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(30.r),
                                                                                child: Image.network(
                                                                                  _generalController.getConsultantProfileModel.data!.userDetail!.imagePath!.contains('assets') ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}' : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                                                                  width: 60,
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        _generalController.getConsultantProfileModel.data!.userDetail!.onlineStatus ==
                                                                                'online'
                                                                            ? PositionedDirectional(
                                                                                start: 3,
                                                                                top: 3,
                                                                                child: CircleAvatar(
                                                                                  radius: 5.r,
                                                                                  backgroundColor: Colors.green,
                                                                                ),
                                                                              )
                                                                            : PositionedDirectional(
                                                                                start: 3,
                                                                                top: 3,
                                                                                child: CircleAvatar(
                                                                                  radius: 5.r,
                                                                                  backgroundColor: Colors.grey,
                                                                                ),
                                                                              ),
                                                                      ],
                                                                    ),
                                                            ),
                                                            title: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        '$greetingMes ',
                                                                        style: state
                                                                            .mentorDetailTileTitle2TextStyle),
                                                                    Expanded(
                                                                      child: Text(
                                                                          '${_generalController.getConsultantProfileModel.data!.userDetail!.firstName}'
                                                                              .capitalize!,
                                                                          softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              state.mentorDetailTileTitleTextStyle),
                                                                    ),
                                                                  ],
                                                                ),
                                                                // Text(
                                                                //     'My name is Dr. Sultan and i am a good doctor for yoo so, appoint me as your mentor',
                                                                //     softWrap: true,
                                                                //     overflow:
                                                                //         TextOverflow.ellipsis,
                                                                //     maxLines: 2,
                                                                //     style: state
                                                                //         .mentorDetailTileTitle3TextStyle),
                                                                // const SizedBox(height: 8,),
                                                                // Row(
                                                                //   mainAxisAlignment: MainAxisAlignment.start,
                                                                //   children: [
                                                                //     Text(
                                                                //         'Go Live',
                                                                //         style:GoogleFonts.poppins(
                                                                //             fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                                                                //     const SizedBox(width: 15,),
                                                                //     _generalController.getConsultantProfileModel.data == null
                                                                //         ?const SizedBox()
                                                                //         :Switch(
                                                                //       activeColor: customThemeColor,
                                                                //       value: _generalController.getConsultantProfileModel
                                                                //           .data!.userDetail!.mentor!.isLive == 0
                                                                //           ? false
                                                                //           : true,
                                                                //       onChanged: (bool? newValue){
                                                                //         // setState(() {
                                                                //         //   switchValue = newValue;
                                                                //         // });
                                                                //         if(newValue!){
                                                                //           customDialogForGoLive(context);
                                                                //         }else{
                                                                //           Get.find<GeneralController>().updateFormLoaderController(true);
                                                                //           postMethod(
                                                                //               context,
                                                                //               inActiveLiveForMentorUrl,
                                                                //               {
                                                                //                 'token': '123',
                                                                //                 'mentor_id': Get.find<GeneralController>().storageBox.read('userId'),
                                                                //               },
                                                                //               true,
                                                                //               inActiveLiveRepo);
                                                                //         }
                                                                //
                                                                //       },
                                                                //     ),
                                                                //   ],
                                                                //
                                                                // )
                                                              ],
                                                            ),
                                                            trailing: InkWell(
                                                              onTap: () {
                                                                Get.toNamed(
                                                                    PageRoutes
                                                                        .consultantMyProfile);
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.w,
                                                                        15.h,
                                                                        5.w,
                                                                        15.h),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color:
                                                                      customThemeColor,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              const SizedBox(height: 20),

                                              ///---appointment-details
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15.w, 0, 15.w, 0),
                                                child: Row(
                                                  children: [
                                                    ///---total-appointment
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(end: 7.w),
                                                        child: Container(
                                                          height: 93.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                customThemeColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.r),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            14.w,
                                                                            14.h,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  LanguageConstant
                                                                      .totalAppointments
                                                                      .tr,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: state
                                                                      .appointmentCountTitleTextStyle,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          14.w,
                                                                          2.h,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        _dashboardLogic.getAppointmentCountMentorModel.data ==
                                                                                null
                                                                            ? ''
                                                                            : '${_dashboardLogic.getAppointmentCountMentorModel.data!.allAppointmentsCount}',
                                                                        style: state
                                                                            .appointmentCountValueTextStyle,
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                        alignment:
                                                                            Alignment
                                                                                .bottomCenter,
                                                                        child: Transform
                                                                            .rotate(
                                                                          angle: _generalController.isDirectionRTL(context)
                                                                              ? 170
                                                                              : 0,
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            'assets/Icons/appointmentBar-1.svg',
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    ///---cancel-appointment
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    start: 7.w),
                                                        child: Container(
                                                          height: 93.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffFDDBE5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.r),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            14.w,
                                                                            14.h,
                                                                            0,
                                                                            0),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      LanguageConstant
                                                                          .appointmentsCancel
                                                                          .tr,
                                                                      style: state
                                                                          .appointmentCountTitleTextStyle!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            14.w,
                                                                            2.h,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  _dashboardLogic
                                                                              .getAppointmentCountMentorModel
                                                                              .data ==
                                                                          null
                                                                      ? ''
                                                                      : '${_dashboardLogic.getAppointmentCountMentorModel.data!.cancelAppointments}',
                                                                  style: state
                                                                      .appointmentCountValueTextStyle
                                                                      ?.copyWith(
                                                                          color:
                                                                              const Color(0xffE60047)),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/Icons/appointmentBar-2.svg',
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )),
                                                              ),
                                                              SizedBox(
                                                                height: 15.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 12.h),

                                              ///---rating
                                              Padding(
                                                  padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              15.w, 0, 15.w, 0),
                                                  child: _dashboardLogic
                                                          .ratingLoader
                                                      ? SkeletonLoader(
                                                          period:
                                                              const Duration(
                                                                  seconds: 2),
                                                          highlightColor:
                                                              Colors.grey,
                                                          direction:
                                                              SkeletonDirection
                                                                  .ltr,
                                                          builder: Container(
                                                            height: 199.h,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                          ))
                                                      : Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.r),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  offset:
                                                                      const Offset(
                                                                          0,
                                                                          10),
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  blurRadius:
                                                                      10,
                                                                  spreadRadius:
                                                                      3,
                                                                )
                                                              ]),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.w,
                                                                        18.h,
                                                                        15.w,
                                                                        18.h),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        LanguageConstant
                                                                            .rating
                                                                            .tr,
                                                                        style: state
                                                                            .headingTextStyle),
                                                                    SizedBox(
                                                                      width:
                                                                          7.w,
                                                                    ),
                                                                    Text(
                                                                      '(${_dashboardLogic.getRatingsModel.data!.totalRatings!} ${LanguageConstant.total.tr})',
                                                                      style: TextStyle(
                                                                          fontSize: 10
                                                                              .sp,
                                                                          fontFamily: SarabunFontFamily
                                                                              .regular,
                                                                          color:
                                                                              Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 17.h,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          100.w,
                                                                      height:
                                                                          100.h,
                                                                      child:
                                                                          CircularProgress(
                                                                        //---must set the padding inside the package of 5.0
                                                                        percentage:
                                                                            ((_dashboardLogic.getRatingsModel.data!.avgRatings! * 100) /
                                                                                5),
                                                                        color:
                                                                            customOrangeColor,
                                                                        backColor:
                                                                            const Color(0xffDBDBDB),
                                                                        showPercentage:
                                                                            true,
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                18.sp,
                                                                            fontFamily: SarabunFontFamily.bold,
                                                                            color: customTextBlackColor),
                                                                        stroke:
                                                                            0,
                                                                        round:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsetsDirectional.only(start: 15.w),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                  height: 15.h,
                                                                                  child: Center(
                                                                                    child: Text('5', style: state.ratingTextStyle),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 2.w,
                                                                                ),
                                                                                SvgPicture.asset('assets/Icons/ratingStar.svg'),
                                                                                const SizedBox(
                                                                                  width: 4,
                                                                                ),
                                                                                SizedBox(
                                                                                    width: 120.w,
                                                                                    child: ProgressBar(
                                                                                      max: 100,
                                                                                      current: _dashboardLogic.getRatingsModel.data!.totalRatings == 0 ? 0 : ((_dashboardLogic.getRatingsModel.data!.fiveRatings! * 100) / _dashboardLogic.getRatingsModel.data!.totalRatings!),
                                                                                      color: customOrangeColor,
                                                                                    )),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                Text('(${_dashboardLogic.getRatingsModel.data!.fiveRatings})', style: state.ratingTextStyle),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 12.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                  height: 15.h,
                                                                                  child: Center(
                                                                                    child: Text('4', style: state.ratingTextStyle),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 2.w,
                                                                                ),
                                                                                SvgPicture.asset('assets/Icons/ratingStar.svg'),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                SizedBox(
                                                                                    width: 120.w,
                                                                                    child: ProgressBar(
                                                                                      max: 100,
                                                                                      current: _dashboardLogic.getRatingsModel.data!.totalRatings == 0 ? 0 : ((_dashboardLogic.getRatingsModel.data!.fourRatings! * 100) / _dashboardLogic.getRatingsModel.data!.totalRatings!),
                                                                                      color: customOrangeColor,
                                                                                    )),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                Text('(${_dashboardLogic.getRatingsModel.data!.fourRatings})', style: state.ratingTextStyle),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 12.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                  height: 15.h,
                                                                                  child: Center(
                                                                                    child: Text('3', style: state.ratingTextStyle),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 2.w,
                                                                                ),
                                                                                SvgPicture.asset('assets/Icons/ratingStar.svg'),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                SizedBox(
                                                                                    width: 120.w,
                                                                                    child: ProgressBar(
                                                                                      max: 100,
                                                                                      current: _dashboardLogic.getRatingsModel.data!.totalRatings == 0 ? 0 : ((_dashboardLogic.getRatingsModel.data!.threeRatings! * 100) / _dashboardLogic.getRatingsModel.data!.totalRatings!),
                                                                                      color: customOrangeColor,
                                                                                    )),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                Text('(${_dashboardLogic.getRatingsModel.data!.threeRatings})', style: state.ratingTextStyle),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 12.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                  height: 15.h,
                                                                                  child: Center(
                                                                                    child: Text('2', style: state.ratingTextStyle),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 2.w,
                                                                                ),
                                                                                SvgPicture.asset('assets/Icons/ratingStar.svg'),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                SizedBox(
                                                                                    width: 120.w,
                                                                                    child: ProgressBar(
                                                                                      max: 100,
                                                                                      current: _dashboardLogic.getRatingsModel.data!.totalRatings == 0 ? 0 : ((_dashboardLogic.getRatingsModel.data!.twoRatings! * 100) / _dashboardLogic.getRatingsModel.data!.totalRatings!),
                                                                                      color: customOrangeColor,
                                                                                    )),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                Text('(${_dashboardLogic.getRatingsModel.data!.twoRatings})', style: state.ratingTextStyle),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 12.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                  height: 15.h,
                                                                                  child: Center(
                                                                                    child: Text('1', style: state.ratingTextStyle),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 2.w,
                                                                                ),
                                                                                SvgPicture.asset('assets/Icons/ratingStar.svg'),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                SizedBox(
                                                                                    width: 120.w,
                                                                                    child: ProgressBar(
                                                                                      max: 100,
                                                                                      current: _dashboardLogic.getRatingsModel.data!.totalRatings == 0 ? 0 : ((_dashboardLogic.getRatingsModel.data!.oneRatings! * 100) / _dashboardLogic.getRatingsModel.data!.totalRatings!),
                                                                                      color: customOrangeColor,
                                                                                    )),
                                                                                SizedBox(
                                                                                  width: 4.w,
                                                                                ),
                                                                                Text('(${_dashboardLogic.getRatingsModel.data!.oneRatings})', style: state.ratingTextStyle),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                              const SizedBox(height: 30),

                                              ///---today-appointments
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15.w, 0, 15.w, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ///---heading
                                                    Text(
                                                      LanguageConstant
                                                          .todayAppointment.tr,
                                                      style: state
                                                          .headingTextStyle,
                                                    ),

                                                    SizedBox(
                                                      height: 20.h,
                                                    ),

                                                    ///---today
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ///---appointment-list
                                                        _dashboardLogic
                                                                .getTodayAppointmentLoader!
                                                            ? SkeletonLoader(
                                                                period:
                                                                    const Duration(
                                                                        seconds:
                                                                            2),
                                                                highlightColor:
                                                                    Colors.grey,
                                                                direction:
                                                                    SkeletonDirection
                                                                        .ltr,
                                                                builder: Wrap(
                                                                  children: List
                                                                      .generate(
                                                                          10,
                                                                          (index) {
                                                                    return Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            70,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        color:
                                                                            customOrangeColor,
                                                                      ),
                                                                    );
                                                                  }),
                                                                ))
                                                            : _dashboardLogic
                                                                    .getTodayAppointmentList
                                                                    .isEmpty
                                                                ? Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                            .only(
                                                                        top:
                                                                            20),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        '${LanguageConstant.noAppointment.tr}\n${LanguageConstant.forToday.tr}!',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Wrap(
                                                                    children: List.generate(
                                                                        _dashboardLogic
                                                                            .getTodayAppointmentList
                                                                            .length,
                                                                        (index) {
                                                                      return Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 15.h),
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 15.w),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  offset: const Offset(0, 10),
                                                                                  color: Colors.grey.withOpacity(0.2),
                                                                                  blurRadius: 10,
                                                                                  spreadRadius: 3,
                                                                                )
                                                                              ],
                                                                              borderRadius: BorderRadius.circular(8.r)),
                                                                          child:
                                                                              RoundedExpansionTile(
                                                                            contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                                                                            title:
                                                                                Row(
                                                                              children: [
                                                                                ///---type
                                                                                Expanded(
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        LanguageConstant.type.tr,
                                                                                        style: state.appointmentListLabelTextStyle,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 6,
                                                                                      ),
                                                                                      Text(
                                                                                        '${_dashboardLogic.getTodayAppointmentList[index].appointmentTypeString}'.toUpperCase(),
                                                                                        style: state.appointmentListValueTextStyle,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),

                                                                                ///---amount
                                                                                Expanded(
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      Text(
                                                                                        LanguageConstant.amount.tr,
                                                                                        style: state.appointmentListLabelTextStyle,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 6,
                                                                                      ),
                                                                                      Text(
                                                                                        '${LanguageConstant.rs.tr}.${_dashboardLogic.getTodayAppointmentList[index].payment}',
                                                                                        style: state.appointmentListValueTextStyle?.copyWith(color: customLightThemeColor),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),

                                                                                ///---status
                                                                                Expanded(
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      Text(
                                                                                        LanguageConstant.status.tr,
                                                                                        style: state.appointmentListLabelTextStyle,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 6,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          const Icon(
                                                                                            Icons.check,
                                                                                            color: customGreenColor,
                                                                                            size: 10,
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Text(
                                                                                            LanguageConstant.accepted.tr,
                                                                                            style: state.appointmentListValueTextStyle,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            trailing:
                                                                                SvgPicture.asset(
                                                                              'assets/Icons/forwardBlueIcon.svg',
                                                                              width: 19.w,
                                                                              height: 19.h,
                                                                            ),
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10.h),
                                                                                child: Row(
                                                                                  children: [
                                                                                    ///---date
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          Text(
                                                                                            LanguageConstant.date.tr,
                                                                                            style: state.appointmentListLabelTextStyle,
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 6,
                                                                                          ),
                                                                                          Text(
                                                                                            '${_dashboardLogic.getTodayAppointmentList[index].date}',
                                                                                            style: state.appointmentListValueTextStyle,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),

                                                                                    ///---time
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          Text(
                                                                                            LanguageConstant.time.tr,
                                                                                            style: state.appointmentListLabelTextStyle,
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 6,
                                                                                          ),
                                                                                          Text(
                                                                                            '${_dashboardLogic.getTodayAppointmentList[index].time}',
                                                                                            style: state.appointmentListValueTextStyle,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),

                                                                                    ///---payment-status
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          Text(
                                                                                            LanguageConstant.pStatus.tr,
                                                                                            style: state.appointmentListLabelTextStyle,
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 6,
                                                                                          ),
                                                                                          _dashboardLogic.getTodayAppointmentList[index].isPaid == 0
                                                                                              ? Row(
                                                                                                  children: [
                                                                                                    const Icon(
                                                                                                      Icons.cancel_outlined,
                                                                                                      color: Colors.red,
                                                                                                      size: 10,
                                                                                                    ),
                                                                                                    const SizedBox(
                                                                                                      width: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      LanguageConstant.unPaid.tr,
                                                                                                      style: state.appointmentListValueTextStyle,
                                                                                                    ),
                                                                                                  ],
                                                                                                )
                                                                                              : Row(
                                                                                                  children: [
                                                                                                    const Icon(
                                                                                                      Icons.check,
                                                                                                      color: customThemeColor,
                                                                                                      size: 10,
                                                                                                    ),
                                                                                                    const SizedBox(
                                                                                                      width: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      LanguageConstant.paid.tr,
                                                                                                      style: state.appointmentListValueTextStyle,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: MediaQuery.of(context).size.width * .08,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 10.h, 0, 10.h),
                                                                                child: Row(
                                                                                  children: [
                                                                                    ///---action
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          Text(
                                                                                            LanguageConstant.action.tr,
                                                                                            style: state.appointmentListLabelTextStyle,
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 6,
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              InkWell(
                                                                                                onTap: () {
                                                                                                  Get.put(ConsultantAppointmentLogic());
                                                                                                  Get.put(ConsultantAppointmentDetailLogic());
                                                                                                  Get.find<ConsultantAppointmentDetailLogic>().selectedAppointmentData = _dashboardLogic.getTodayAppointmentList[index];
                                                                                                  Get.find<ConsultantAppointmentDetailLogic>().appointmentStatus = 1;
                                                                                                  Get.find<ConsultantAppointmentDetailLogic>().update();
                                                                                                  Get.toNamed(PageRoutes.consultantAppointmentDetail);
                                                                                                },
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsets.fromLTRB(5.w, 0, 8, 0),
                                                                                                  child: const Icon(
                                                                                                    Icons.visibility,
                                                                                                    color: customThemeColor,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                                  ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ));
    });
  }
}
