import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/user/home/get_repo.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class TopRatedConsultants extends StatefulWidget {
  const TopRatedConsultants({Key? key}) : super(key: key);

  @override
  _TopRatedConsultantsState createState() => _TopRatedConsultantsState();
}

class _TopRatedConsultantsState extends State<TopRatedConsultants> {
  final state = Get.find<UserHomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
      return _userHomeLogic.topRatedLoader!
          ? SkeletonLoader(
              period: const Duration(seconds: 2),
              highlightColor: Colors.grey,
              direction: SkeletonDirection.ltr,
              builder: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0.h),
                      child: Container(
                        height: 15.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r)),
                      )),
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: Wrap(
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 0.h, 15.w, 15.h),
                          child: Container(
                            height: 109.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: -2,
                                    blurRadius: 15,
                                    // offset: Offset(1,5)
                                  )
                                ]),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ))
          : _userHomeLogic.topRatedModel.data == null
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LanguageConstant.topRatedConsultant.tr,
                            style: state.subHeadingTextStyle,
                          ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Text(
                          //     'View All',
                          //     style: state.viewAllTextStyle,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Center(
                      child: Wrap(
                        children: List.generate(
                            _userHomeLogic.topRatedConsultantList.length,
                            (index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.w, 0.h, 15.w, 15.h),
                            child: InkWell(
                              onTap: () {
                                _userHomeLogic.selectedConsultantID =
                                    _userHomeLogic
                                        .topRatedConsultantList[index].id;
                                _userHomeLogic.selectedConsultantName =
                                    '${_userHomeLogic.topRatedConsultantList[index].title}';
                                _userHomeLogic.update();
                                Get.toNamed(
                                    PageRoutes.consultantProfileForUser);
                              },
                              child: Container(
                                height: 109.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: -2,
                                        blurRadius: 15,
                                        // offset: Offset(1,5)
                                      )
                                    ]),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      18.w, 12.h, 18.w, 12.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ///---profile-image
                                      Material(
                                        color: Colors.transparent,
                                        shape: const CircleBorder(
                                          side: BorderSide(
                                              color: Colors.green, width: 0.5),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: _userHomeLogic
                                                    .topRatedConsultantList[
                                                        index]
                                                    .image ==
                                                null
                                            ? SizedBox(
                                                width: 76.w,
                                                height: 100.h,
                                              )
                                            : ClipOval(
                                                child: Image.network(
                                                  _userHomeLogic
                                                          .topRatedConsultantList[
                                                              index]
                                                          .image!
                                                          .contains('assets')
                                                      ? '$mediaUrl${_userHomeLogic.topRatedConsultantList[index].image}'
                                                      : '${_userHomeLogic.topRatedConsultantList[index].image}',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.20,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.20,
                                                  fit: BoxFit.fill,
                                                  errorBuilder:
                                                      (context, object, trace) {
                                                    return SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.20,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.20,
                                                      child: const Icon(
                                                        Icons.person,
                                                        color: Color.fromARGB(
                                                            255, 17, 82, 19),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                      ),

                                      SizedBox(
                                        width: 21.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 6.h,
                                          ),

                                          ///---title
                                          Text(
                                            '${_userHomeLogic.topRatedConsultantList[index].title}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.topTitleTextStyle!
                                                .copyWith(
                                                    color:
                                                        customTextBlackColor),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),

                                          ///---sub-title
                                          Text(
                                            '${_userHomeLogic.topRatedConsultantList[index].subTitle}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: state.topSubTitleTextStyle!
                                                .copyWith(
                                                    color:
                                                        customTextBlackColor),
                                          ),
                                          const SizedBox(),

                                          ///---rating-bar
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            initialRating: double.parse(
                                                _userHomeLogic
                                                    .topRatedConsultantList[
                                                        index]
                                                    .rating
                                                    .toString()),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 15,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 0.0),
                                            itemBuilder: (context, _) =>
                                                SvgPicture.asset(
                                                    'assets/Icons/ratingStarIcon.svg'),
                                            onRatingUpdate: (rating) {},
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      SvgPicture.asset(
                                        'assets/Icons/forwardBlueIcon.svg',
                                        width: 29.w,
                                        height: 29.h,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    _userHomeLogic.topRatedLoaderMore!
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: customThemeColor,
                            ),
                          )
                        : _userHomeLogic.topRatedModel.data!.topRatedMentors!
                                    .currentPage! <
                                _userHomeLogic.topRatedModel.data!
                                    .topRatedMentors!.lastPage!
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 30.h),
                                  child: InkWell(
                                    onTap: () {
                                      _userHomeLogic
                                          .updateTopRatedLoaderMore(true);

                                      ///---top-rated-API-call
                                      getMethod(
                                          context,
                                          getTopRatedConsultantURL,
                                          {
                                            'token': '123',
                                            'page': _userHomeLogic
                                                    .topRatedModel
                                                    .data!
                                                    .topRatedMentors!
                                                    .currentPage! +
                                                1
                                          },
                                          false,
                                          getTopRatedConsultantMoreRepo);
                                    },
                                    child: Container(
                                      height: 36.h,
                                      width: 116.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: customThemeColor),
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      child: Center(
                                        child: Text(
                                          LanguageConstant.loadMore.tr,
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.medium,
                                              fontSize: 12.sp,
                                              color: customThemeColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                  ],
                );
    });
  }
}
