import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/image_full_view/view.dart';
import 'package:ista_app/src/modules/user/book_appointment/view_slot_selection.dart';
import 'package:ista_app/src/modules/user/consultant_profile/get_repo.dart';
import 'package:ista_app/src/modules/user/consultant_profile/logic.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/notification_icon.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultantProfilePage extends StatefulWidget {
  int? appointmentId;
  int? mentorId;
  bool? reschedule;
  ConsultantProfilePage(
      {Key? key, this.appointmentId, this.mentorId, this.reschedule})
      : super(key: key);

  @override
  State<ConsultantProfilePage> createState() => _ConsultantProfilePageState();
}

class _ConsultantProfilePageState extends State<ConsultantProfilePage> {
  final logic = Get.put(ConsultantProfileLogic());

  final state = Get.find<ConsultantProfileLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.mentorId != null
        ? getMethod(
            context,
            getMentorProfileForMenteeUrl,
            {'token': '123', 'mentor_id': widget.mentorId},
            true,
            getMentorProfileForMenteeRepo)
        : getMethod(
            context,
            getMentorProfileForMenteeUrl,
            {
              'token': '123',
              'mentor_id': Get.find<UserHomeLogic>().selectedConsultantID
            },
            true,
            getMentorProfileForMenteeRepo);
    widget.mentorId != null
        ? getMethod(
            context,
            getUserProfileUrl,
            {'token': '123', 'user_id': widget.mentorId},
            true,
            getConsultantProfileRepo)
        : getMethod(
            context,
            getUserProfileUrl,
            {
              'token': '123',
              'user_id': Get.find<UserHomeLogic>().selectedConsultantID
            },
            true,
            getConsultantProfileRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ConsultantProfileLogic>(
          builder: (_consultantProfileLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height * .35,
                      // floating: true,
                      pinned: true,
                      // snap: true,
                      elevation: 0,
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
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      actions: const [
                        ///---notifications
                        CustomNotificationIcon(color: Colors.black)
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(40),
                        child: Container(
                          height: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(70.r)),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 3,
                                    offset: Offset(0, 1))
                              ]),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: _consultantProfileLogic
                                  .consultantProfileLoader!
                              ? SkeletonLoader(
                                  period: const Duration(seconds: 2),
                                  highlightColor: Colors.grey,
                                  direction: SkeletonDirection.ltr,
                                  builder: Container(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width,
                                  ))
                              : SafeArea(
                                  child: Stack(
                                    children: [
                                      ///---profile-image
//image
                                      Positioned(
                                        child: Center(
                                          child: Column(
                                            // centre les enfants verticalement
                                            children: [
                                              const SizedBox(height: 27),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.20,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.20,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipOval(
                                                  child: _consultantProfileLogic
                                                              .consultantProfileModel
                                                              .data
                                                              ?.userDetail
                                                              ?.imagePath ==
                                                          null
                                                      ? Image.asset(
                                                          'assets/images/stackImage.png',
                                                          fit: BoxFit.cover,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.20,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.20,
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                              ImageViewScreen(
                                                                networkImage: _consultantProfileLogic
                                                                        .consultantProfileModel
                                                                        .data!
                                                                        .userDetail!
                                                                        .imagePath
                                                                        .contains(
                                                                            'assets')
                                                                    ? '$mediaUrl${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.imagePath}'
                                                                    : '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.imagePath}',
                                                              ),
                                                            );
                                                          },
                                                          child: Image.network(
                                                            _consultantProfileLogic
                                                                    .consultantProfileModel
                                                                    .data!
                                                                    .userDetail!
                                                                    .imagePath
                                                                    .contains(
                                                                        'assets')
                                                                ? '$mediaUrl${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.imagePath}'
                                                                : '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.imagePath}',
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.20,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.20,
                                                            fit: BoxFit.fill,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Icon(
                                                                Icons.person,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .1,
                                                                color:
                                                                    customThemeColor,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${_consultantProfileLogic.consultantProfileModel.data?.userDetail?.firstName ?? '...'} '
                                                  '${_consultantProfileLogic.consultantProfileModel.data?.userDetail?.lastName ?? ''}',
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.bold,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating:
                                                          double.parse(
                                                        (_consultantProfileLogic
                                                                    .consultantProfileModel
                                                                    .data
                                                                    ?.userDetail
                                                                    ?.ratingsAvg ??
                                                                0)
                                                            .toString(),
                                                      ),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 15,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 0.0),
                                                      itemBuilder: (context,
                                                              _) =>
                                                          SvgPicture.asset(
                                                              'assets/Icons/ratingStarIcon.svg'),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        bottom: -20,
                                        child: Center(
                                          child: Container(
                                            //   alignment: Alignment.center,
                                            margin: const EdgeInsets.only(
                                                bottom: 32, left: 57),
                                            color: Colors.transparent,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .099,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Container(
                                                  height: 70.h,
                                                  width: 90.w,
                                                  decoration: BoxDecoration(
                                                    //color: customTextFieldColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            IconButton(
                                                              onPressed:
                                                                  () async {
                                                                // Lien vers le profil Instagram de l'utilisateur
                                                                final facebookUrl =
                                                                    "https://www.facebook.com//";

                                                                // Ouvre le lien Instagram dans le navigateur par défaut de l'appareil
                                                                if (await canLaunch(
                                                                    facebookUrl)) {
                                                                  await launch(
                                                                      facebookUrl);
                                                                } else {
                                                                  // Gère l'erreur si le lien ne peut pas être ouvert
                                                                  print(
                                                                      "Impossible d'ouvrir le lien facebook");
                                                                }
                                                              },
                                                              icon: Image.asset(
                                                                'assets/images/facebook.png',
                                                                width: 25,
                                                                height: 25,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 0.1,
                                                            ),
                                                            const Text(
                                                              'Facebook',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    SarabunFontFamily
                                                                        .medium,
                                                                fontSize: 9,
                                                                color:
                                                                    customTextBlackColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70.h,
                                                  width: 90.w,
                                                  decoration: BoxDecoration(
                                                    //  color: customTextFieldColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            IconButton(
                                                              onPressed:
                                                                  () async {
                                                                // Lien vers le profil Instagram de l'utilisateur
                                                                final instagramUrl =
                                                                    "https://www.instagram.com/";

                                                                // Ouvre le lien Instagram dans le navigateur par défaut de l'appareil
                                                                if (await canLaunch(
                                                                    instagramUrl)) {
                                                                  await launch(
                                                                      instagramUrl);
                                                                } else {
                                                                  // Gère l'erreur si le lien ne peut pas être ouvert
                                                                  print(
                                                                      "Impossible d'ouvrir le lien Instagram");
                                                                }
                                                              },
                                                              icon: Image.asset(
                                                                'assets/images/instagram.png',
                                                                width: 25,
                                                                height: 25,
                                                              ),
                                                            ),
                                                            const Text(
                                                              'Instagram',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    SarabunFontFamily
                                                                        .medium,
                                                                fontSize: 9,
                                                                color:
                                                                    customTextBlackColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70.h,
                                                  width: 90.w,
                                                  decoration: BoxDecoration(
                                                    //  color: customTextFieldColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              onPressed:
                                                                  () async {
                                                                // Lien vers le profil Instagram de l'utilisateur
                                                                final tiktokUrl =
                                                                    "https://www.tiktok.com/";

                                                                // Ouvre le lien Instagram dans le navigateur par défaut de l'appareil
                                                                if (await canLaunch(
                                                                    tiktokUrl)) {
                                                                  await launch(
                                                                      tiktokUrl);
                                                                } else {
                                                                  // Gère l'erreur si le lien ne peut pas être ouvert
                                                                  print(
                                                                      "Impossible d'ouvrir le lien Instagram");
                                                                }
                                                              },
                                                              icon: Image.asset(
                                                                'assets/images/tiktok.png',
                                                                width: 25,
                                                                height: 25,
                                                              ),
                                                            ),
                                                            const Text(
                                                              'TikTok',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    SarabunFontFamily
                                                                        .medium,
                                                                fontSize: 9,
                                                                color:
                                                                    customTextBlackColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///---offline/online-status
                                      !_consultantProfileLogic.loader!
                                          ? _consultantProfileLogic
                                                      .getMentorProfileForMenteeModel
                                                      .data!
                                                      .userDetail!
                                                      .onlineStatus ==
                                                  'online'
                                              ? Positioned(
                                                  top: 60.h,
                                                  left: 0,
                                                  child: Container(
                                                    height: 30.h,
                                                    width: 80.w,
                                                    decoration: BoxDecoration(
                                                        color: customThemeColor,
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                right: Radius
                                                                    .circular(
                                                                        10.r))),
                                                    child: Center(
                                                      child: Text(
                                                        LanguageConstant
                                                            .online.tr,
                                                        style:
                                                            state.tagTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Positioned(
                                                  top: 60.h,
                                                  left: 0,
                                                  child: Container(
                                                    height: 30.h,
                                                    width: 80.w,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                right: Radius
                                                                    .circular(
                                                                        10.r))),
                                                    child: Center(
                                                      child: Text(
                                                        LanguageConstant
                                                            .offline.tr,
                                                        style:
                                                            state.tagTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                          : const SizedBox()
                                    ],
                                  ),
                                )),
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    _consultantProfileLogic.consultantProfileLoader!
                        ? SkeletonLoader(
                            period: const Duration(seconds: 2),
                            highlightColor: Colors.grey,
                            direction: SkeletonDirection.ltr,
                            builder: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 15.h,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 15.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 73.h,
                                          width: 106.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                        ),
                                        const SizedBox(),
                                        Container(
                                          height: 73.h,
                                          width: 106.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                        ),
                                        const SizedBox(),
                                        Container(
                                          height: 73.h,
                                          width: 106.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ))
                        : ListView(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.w, 1, 15.w, 0),
                            children: [
                                ///---category-rating
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///---category
                                    Row(
                                      children: [
                                        const Text(
                                          "Category : ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily:
                                                  SarabunFontFamily.light),
                                        ),
                                        Text(
                                          _consultantProfileLogic
                                                  .consultantProfileModel
                                                  .data
                                                  ?.userDetail
                                                  ?.mentor
                                                  ?.categories?[0]
                                                  .category
                                                  ?.name ??
                                              "...",
                                          style: state.categoryTextStyle,
                                        ),
                                      ],
                                    ),

                                    ///---rating-bar
                                    /*   RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: double.parse(
                                          (_consultantProfileLogic
                                                      .consultantProfileModel
                                                      .data
                                                      ?.userDetail
                                                      ?.ratingsAvg ??
                                                  0)
                                              .toString()),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) =>
                                          SvgPicture.asset(
                                              'assets/Icons/ratingStarIcon.svg'),
                                      onRatingUpdate: (rating) {},
                                    ),*/
                                  ],
                                ),

                                SizedBox(
                                  height: 25.h,
                                ),

                                ///---about-detail
                                Row(
                                  children: [
                                    ///---rating
                                    Container(
                                      height: 91.h,
                                      width: 106.w,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 215, 241, 216),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/Icons/ratingStarIcon.svg',
                                                    width:
                                                        20, // nouvelle largeur
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    '${_consultantProfileLogic.consultantProfileModel.data?.userDetail?.ratingsAvg ?? '0'}.0',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .extraBold,
                                                        fontSize: 17,
                                                        color:
                                                            customThemeColor),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                LanguageConstant
                                                    .positiveRating.tr,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .medium,
                                                    fontSize: 14,
                                                    color:
                                                        customTextBlackColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 13,
                                    ),

                                    ///---consultancy-count
                                    Container(
                                      height: 91.h,
                                      width: 106.w,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 215, 241, 216),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/Icons/consultancyCountIcon.svg',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    '${_consultantProfileLogic.consultantProfileModel.data?.userDetail?.appointmentCount ?? '0'}+',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .extraBold,
                                                        fontSize: 16,
                                                        color:
                                                            customThemeColor),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                LanguageConstant.consultancy.tr,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .medium,
                                                    fontSize: 14,
                                                    color:
                                                        customTextBlackColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 13,
                                    ),

                                    ///---experience
                                    Container(
                                      height: 91.h,
                                      width: 106.w,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 215, 241, 216),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/Icons/checkIcon.svg',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    '${_consultantProfileLogic.consultantProfileModel.data?.userDetail?.mentor?.experience ?? '0'}+',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .extraBold,
                                                        fontSize: 16,
                                                        color:
                                                            customThemeColor),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                LanguageConstant
                                                    .yearsOfExperience.tr,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .medium,
                                                    fontSize: 14,
                                                    color:
                                                        customTextBlackColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 30.h,
                                ),

                                ///---about
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.about.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(
                                      _consultantProfileLogic
                                              .consultantProfileModel
                                              .data
                                              ?.userDetail
                                              ?.mentor
                                              ?.about ??
                                          'N/A',
                                      style: state.dataTextStyle,
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 30.h,
                                ),

                                ///---types
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.availableOptions.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Wrap(
                                      children: List.generate(
                                          _consultantProfileLogic
                                              .appointmentTypes
                                              .length, (index) {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 18.w, 11.h),
                                          child: Container(
                                            height: 47.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: -2,
                                                    blurRadius: 15,
                                                    // offset: Offset(1,5)
                                                  )
                                                ]),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 14.w),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SvgPicture.asset(
                                                    '${_consultantProfileLogic.imagesForAppointmentTypes[_consultantProfileLogic.appointmentTypes[index].appointmentTypeId! - 1]}',
                                                    height: 12.h,
                                                    width: 19.w,
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Text(
                                                    _consultantProfileLogic
                                                        .appointmentTypes[index]
                                                        .appointmentType!
                                                        .name!
                                                        .toUpperCase(),
                                                    style: state.typesTextStyle,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ]),

                    ///---bottom-bar

                    _consultantProfileLogic.consultantProfileLoader!
                        ? const SizedBox()
                        : Get.find<GeneralController>()
                                .storageBox
                                .hasData('authToken')
                            ? widget.reschedule == true
                                ? Positioned(
                                    bottom: 0.h,
                                    left: 15.w,
                                    right: 15.w,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(SlotSelection(
                                            appointmentId: widget.appointmentId,
                                            mentorId: widget.mentorId,
                                            reschedule: true));
                                      },
                                      child: MyCustomBottomBar(
                                        title:
                                            LanguageConstant.bookAppointment.tr,
                                        disable: false,
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    bottom: 0.h,
                                    left: 15.w,
                                    right: 15.w,
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(PageRoutes.slotSelection);
                                      },
                                      child: MyCustomBottomBar(
                                        title:
                                            LanguageConstant.bookAppointment.tr,
                                        disable: false,
                                      ),
                                    ),
                                  )
                            : Positioned(
                                bottom: 0.h,
                                left: 15.w,
                                right: 15.w,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(PageRoutes.login);
                                  },
                                  child: MyCustomBottomBar(
                                    title: LanguageConstant.login.tr,
                                    disable: false,
                                  ),
                                ),
                              )
                  ],
                )),
          ),
        );
      });
    });
  }
}
