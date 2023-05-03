import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/my-profile/get_repo.dart';
import 'package:ista_app/src/modules/consultant/my-profile/logic.dart';
import 'package:ista_app/src/modules/image_full_view/view.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ConsultantMyProfilePage extends StatefulWidget {
  const ConsultantMyProfilePage({Key? key}) : super(key: key);

  @override
  State<ConsultantMyProfilePage> createState() =>
      _ConsultantMyProfilePageState();
}

class _ConsultantMyProfilePageState extends State<ConsultantMyProfilePage> {
  final logic = Get.put(MyProfileLogic());

  final state = Get.find<MyProfileLogic>().state;

  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<MyProfileLogic>().scrollController = ScrollController()
      ..addListener(Get.find<MyProfileLogic>().scrollListener);
    getMethod(context, mentorProfileGenericDataUrl, {'token': '123'}, false,
        getGenericDataForProfileViewRepo);
  }

  @override
  void dispose() {
    Get.find<MyProfileLogic>()
        .scrollController!
        .removeListener(Get.find<MyProfileLogic>().scrollListener);
    Get.find<MyProfileLogic>().scrollController!.dispose();
    super.dispose();
  }

  ///

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<MyProfileLogic>(builder: (_myProfileLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: _myProfileLogic.loader!
                ? SkeletonLoader(
                    period: const Duration(seconds: 2),
                    highlightColor: Colors.grey,
                    direction: SkeletonDirection.ltr,
                    builder: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.all(20.0),
                            child: Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width * .5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .35,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 20),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),

                                  Container(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  ///---rating
                                  Container(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 0, 15, 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ]))
                : NestedScrollView(
                    controller: _myProfileLogic.scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        ///---header

                        SliverAppBar(
                          expandedHeight:
                              MediaQuery.of(context).size.height * .35,
                          // floating: true,
                          pinned: true,
                          // snap: true,
                          elevation: 0,

                          backgroundColor: _myProfileLogic.isShrink
                              ? customLightThemeColor
                              : Colors.white,
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {
                              // Action à effectuer lors du clic sur la flèche en arrière
                              Navigator.pop(context);
                            },
                          ),
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(30),
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(0.r)),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 4,
                                        offset: Offset(0, 0))
                                  ]),
                            ),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              background: SafeArea(
                                child: Hero(
                                  tag: _generalController
                                          .getConsultantProfileModel
                                          .data!
                                          .userDetail!
                                          .imagePath!
                                          .contains('assets')
                                      ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}'
                                      : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                  child: Material(
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(25.r),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(ImageViewScreen(
                                          networkImage: _generalController
                                                  .getConsultantProfileModel
                                                  .data!
                                                  .userDetail!
                                                  .imagePath!
                                                  .contains('assets')
                                              ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}'
                                              : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                        ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(25.r),
                                          ),
                                        ),
                                        // color: customLightThemeColor,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: _generalController
                                                      .getConsultantProfileModel
                                                      .data!
                                                      .userDetail!
                                                      .imagePath
                                                      .toString() !=
                                                  'null'
                                              ? ClipOval(
                                                  child: Image.network(
                                                    _generalController
                                                            .getConsultantProfileModel
                                                            .data!
                                                            .userDetail!
                                                            .imagePath!
                                                            .contains('assets')
                                                        ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}'
                                                        : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                                    fit: BoxFit.fill,
                                                    width: 100.r,
                                                    height: 100.r,
                                                  ),
                                                )
                                              : ClipOval(
                                                  child: Image.asset(
                                                    'assets/images/stackImage.png',
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ];
                    },
                    body: Stack(
                      children: [
                        ListView(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.w, 0, 15.w, 0),
                            children: [
                              ///---name
                              Text(
                                '${_generalController.getConsultantProfileModel.data!.userDetail!.firstName} '
                                '${_generalController.getConsultantProfileModel.data!.userDetail!.lastName}',
                                style: state.profileNameTextStyle,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),

                              ///---category-rating
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ///---category
                                  Text(
                                    '${_generalController.getConsultantProfileModel.data!.userDetail!.mentor!.categories![0].category!.name}',
                                    style: state.categoryTextStyle,
                                  ),

                                  ///---rating-bar
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: _generalController
                                        .getConsultantProfileModel
                                        .data!
                                        .userDetail!
                                        .ratingsAvg!
                                        .toDouble(),
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
                                  ),
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
                                    height: 73.h,
                                    width: 106.w,
                                    decoration: BoxDecoration(
                                      color: customTextFieldColor,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/Icons/ratingStarIcon.svg'),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                '${_generalController.getConsultantProfileModel.data!.userDetail!.ratingsAvg!}',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .extraBold,
                                                    fontSize: 16.sp,
                                                    color: customThemeColor),
                                              )
                                            ],
                                          ),
                                          Text(
                                              LanguageConstant
                                                  .positiveRating.tr,
                                              style: state.ratingTextStyle)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),

                                  ///---consultancy-count
                                  Container(
                                    height: 73.h,
                                    width: 106.w,
                                    decoration: BoxDecoration(
                                        color: customTextFieldColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/Icons/consultancyCountIcon.svg'),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                '${_generalController.getConsultantProfileModel.data!.userDetail!.appointmentCount}',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .extraBold,
                                                    fontSize: 16.sp,
                                                    color: customThemeColor),
                                              )
                                            ],
                                          ),
                                          Text(LanguageConstant.consultancy.tr,
                                              style: state.ratingTextStyle)
                                        ],
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  ///---experience
                                  Container(
                                    height: 73.h,
                                    width: 106.w,
                                    decoration: BoxDecoration(
                                        color: customTextFieldColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/Icons/checkIcon.svg'),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                '${_generalController.getConsultantProfileModel.data!.userDetail!.mentor!.experience}',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .extraBold,
                                                    fontSize: 16.sp,
                                                    color: customThemeColor),
                                              )
                                            ],
                                          ),
                                          Text(
                                              LanguageConstant
                                                  .yearsOfExperience.tr,
                                              style: state.ratingTextStyle)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 20.h,
                              ),

                              /// General Info

                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 15,
                                        // offset: Offset(1,5)
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            LanguageConstant
                                                .generalInfo.tr.capitalize!,
                                            style:
                                                state.sectionHeadingTextStyle,
                                          ),
                                          // SvgPicture.asset(
                                          //   'assets/Icons/editIcon.svg',
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      ///---first-last-father-name
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.firstName.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.firstName}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.lastName.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.lastName}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant
                                                      .fatherName.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.fatherName}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),

                                      ///---gender-religion-occupation
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.gender.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.gender}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.religion.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.religion}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant
                                                      .occupation.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_myProfileLogic.occupation}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),

                                      ///---dob-city-country
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant
                                                      .dateOfBirth.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.dob}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.city.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.city}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.country.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.userCountry!.name}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 18.h,
                                      ),

                                      ///---cnic
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.cnic.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.cnic}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 18.h,
                                      ),

                                      ///---email
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.email.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.email}',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 18.h,
                                      ),

                                      ///---address
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.address.tr,
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '${_generalController.getConsultantProfileModel.data!.userDetail!.address}',
                                                  style: state
                                                      .previewValueTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),

                              /// Educational Info

                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 15,
                                        // offset: Offset(1,5)
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            LanguageConstant
                                                .education.tr.capitalize!,
                                            style:
                                                state.sectionHeadingTextStyle,
                                          ),
                                          // SvgPicture.asset(
                                          //   'assets/Icons/editIcon.svg',
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Wrap(
                                        children: List.generate(
                                            _generalController
                                                .getConsultantProfileModel
                                                .data!
                                                .userDetail!
                                                .educations!
                                                .length, (index) {
                                          return Column(
                                            children: [
                                              Column(
                                                children: [
                                                  ///---institution-year
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              LanguageConstant
                                                                  .institute.tr,
                                                              style: state
                                                                  .previewLabelTextStyle,
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              '${_generalController.getConsultantProfileModel.data!.userDetail!.educations![index].institute}',
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: state
                                                                  .previewValueTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              LanguageConstant
                                                                  .year.tr,
                                                              style: state
                                                                  .previewLabelTextStyle,
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              '${_generalController.getConsultantProfileModel.data!.userDetail!.educations![index].period}',
                                                              style: state
                                                                  .previewValueTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 18.h,
                                                  ),

                                                  ///---degree-
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              LanguageConstant
                                                                  .degree.tr,
                                                              style: state
                                                                  .previewLabelTextStyle,
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              '${_generalController.getConsultantProfileModel.data!.userDetail!.educations![index].degree}',
                                                              style: state
                                                                  .previewValueTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 18.h,
                                                  ),

                                                  ///---subject
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              LanguageConstant
                                                                  .subject.tr,
                                                              style: state
                                                                  .previewLabelTextStyle,
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              '${_generalController.getConsultantProfileModel.data!.userDetail!.educations![index].subject}',
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: state
                                                                  .previewValueTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              index ==
                                                      _generalController
                                                              .getConsultantProfileModel
                                                              .data!
                                                              .userDetail!
                                                              .educations!
                                                              .length -
                                                          1
                                                  ? const SizedBox()
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 0, 20, 0),
                                                      child: Divider(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    )
                                            ],
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20.h,
                              ),

                              ///---experience-info
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 15,
                                          // offset: Offset(1,5)
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.h, horizontal: 15.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant
                                              .experience.tr.capitalize!,
                                          style: state.sectionHeadingTextStyle,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Wrap(
                                          children: List.generate(
                                              _generalController
                                                  .getConsultantProfileModel
                                                  .data!
                                                  .userDetail!
                                                  .experiences!
                                                  .length, (index) {
                                            return Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    ///---company
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                LanguageConstant
                                                                    .company.tr,
                                                                style: state
                                                                    .previewLabelTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                '${_generalController.getConsultantProfileModel.data!.userDetail!.experiences![index].company}',
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: state
                                                                    .previewValueTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 18.h,
                                                    ),

                                                    ///---from-to
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                LanguageConstant
                                                                    .from.tr,
                                                                style: state
                                                                    .previewLabelTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                '${_generalController.getConsultantProfileModel.data!.userDetail!.experiences![index].from}',
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: state
                                                                    .previewValueTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                LanguageConstant
                                                                    .to.tr,
                                                                style: state
                                                                    .previewLabelTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                '${_generalController.getConsultantProfileModel.data!.userDetail!.experiences![index].to}',
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: state
                                                                    .previewValueTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                index ==
                                                        _generalController
                                                                .getConsultantProfileModel
                                                                .data!
                                                                .userDetail!
                                                                .experiences!
                                                                .length -
                                                            1
                                                    ? const SizedBox()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 0, 20, 0),
                                                        child: Divider(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                        ),
                                                      )
                                              ],
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),

                              ///---category-info
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 15,
                                          // offset: Offset(1,5)
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.h, horizontal: 15.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant
                                              .speciality.tr.capitalize!,
                                          style: state.sectionHeadingTextStyle,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            ///---speciality
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                (_generalController
                                                            .getConsultantProfileModel
                                                            .data
                                                            ?.userDetail
                                                            ?.mentor
                                                            ?.categories ??
                                                        [])
                                                    .length,
                                                (index) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              index == 0
                                                                  ? 0
                                                                  : 5,
                                                              5,
                                                              0,
                                                              0),
                                                      child: Text(
                                                        _generalController
                                                                .getConsultantProfileModel
                                                                .data
                                                                ?.userDetail
                                                                ?.mentor
                                                                ?.categories?[
                                                                    index]
                                                                .category
                                                                ?.name ??
                                                            "N/A",
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     Expanded(
                                            //       child: Column(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment.start,
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment
                                            //                 .start,
                                            //         children: [
                                            //           Text(
                                            //             'category'.tr,
                                            //             style: state
                                            //                 .previewLabelTextStyle,
                                            //           ),
                                            //           const SizedBox(
                                            //             height: 4,
                                            //           ),
                                            //           // Text(
                                            //           //   '${_generalController.getConsultantProfileModel.data!.userDetail!.mentor!.parentCategory!.name}',
                                            //           //   softWrap: true,
                                            //           //   overflow: TextOverflow
                                            //           //       .ellipsis,
                                            //           //   maxLines: 1,
                                            //           //   style: state
                                            //           //       .previewValueTextStyle,
                                            //           // ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     Expanded(
                                            //       child: Column(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment.start,
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment
                                            //                 .start,
                                            //         children: [
                                            //           Text(
                                            //             'sub_category'.tr,
                                            //             style: state
                                            //                 .previewLabelTextStyle,
                                            //           ),
                                            //           const SizedBox(
                                            //             height: 4,
                                            //           ),
                                            //           // Text(
                                            //           //   '${_generalController.getConsultantProfileModel.data!.userDetail!.mentor!.category!.name}',
                                            //           //   softWrap: true,
                                            //           //   overflow: TextOverflow
                                            //           //       .ellipsis,
                                            //           //   maxLines: 1,
                                            //           //   style: state
                                            //           //       .previewValueTextStyle,
                                            //           // ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),

                              SizedBox(
                                height: 20.h,
                              ),

                              ///---account-info
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 15,
                                          // offset: Offset(1,5)
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.h, horizontal: 15.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageConstant
                                              .accountInfo.tr.capitalize!,
                                          style: state.sectionHeadingTextStyle,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            ///---bank
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        LanguageConstant
                                                            .bank.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_generalController.getConsultantProfileModel.data!.userDetail!.cardDetail!.bank}',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 18.h,
                                            ),

                                            ///---account-name
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        LanguageConstant
                                                            .accountTitle.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_generalController.getConsultantProfileModel.data!.userDetail!.cardDetail!.accountTitle}',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 18.h,
                                            ),

                                            ///---account-number
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        LanguageConstant
                                                            .accountNumber.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_generalController.getConsultantProfileModel.data!.userDetail!.cardDetail!.accountNumber}',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                            ]),
                      ],
                    )),
          ),
        );
      });
    });
  }
}
