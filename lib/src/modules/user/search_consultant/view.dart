import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/modules/user/search_consultant/get_repo.dart';
import 'package:ista_app/src/modules/user/search_consultant/logic.dart';
import 'package:ista_app/src/modules/user/search_consultant/search_consultant_model.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class SearchConsultantPage extends StatefulWidget {
  const SearchConsultantPage({Key? key}) : super(key: key);

  @override
  State<SearchConsultantPage> createState() => _SearchConsultantPageState();
}

class _SearchConsultantPageState extends State<SearchConsultantPage> {
  final logic = Get.put(SearchConsultantLogic());

  final state = Get.find<SearchConsultantLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchConsultantLogic>(builder: (_searchConsultantLogic) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///---search-field
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _searchConsultantLogic.searchController,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            25.w, 15.h, 25.w, 15.h),
                        hintText: 'Search Consultant Here....',
                        hintStyle: state.hintTextStyle,
                        fillColor: customTextFieldColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: customLightThemeColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: Colors.red)),
                      ),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _searchConsultantLogic.updateSearchLoader(true);
                          getMethod(
                              context,
                              searchConsultantUrl,
                              {
                                'search':
                                    _searchConsultantLogic.searchController.text
                              },
                              true,
                              consultantSearchRepo);
                        }
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _searchConsultantLogic.searchConsultantModel =
                              SearchConsultantModel();
                          _searchConsultantLogic.updateSearchLoader(false);
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LanguageConstant.fieldRequired.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),

                  _searchConsultantLogic.searchLoader!
                      ? SkeletonLoader(
                          period: const Duration(seconds: 2),
                          highlightColor: Colors.grey,
                          direction: SkeletonDirection.ltr,
                          builder: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Wrap(
                                  children: List.generate(4, (index) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.w, 0.h, 15.w, 15.h),
                                      child: Container(
                                        height: 109.h,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ))
                      : _searchConsultantLogic.searchConsultantModel.data ==
                              null
                          ? const SizedBox()
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Wrap(
                                      children: List.generate(
                                          _searchConsultantLogic
                                              .searchConsultantModel
                                              .data!
                                              .results!
                                              .length, (index) {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.w, 0.h, 15.w, 15.h),
                                          child: InkWell(
                                            onTap: () {
                                              Get.find<UserHomeLogic>()
                                                      .selectedConsultantID =
                                                  _searchConsultantLogic
                                                      .searchConsultantModel
                                                      .data!
                                                      .results![index]
                                                      .userId;
                                              Get.find<UserHomeLogic>()
                                                      .selectedConsultantName =
                                                  '${_searchConsultantLogic.searchConsultantModel.data!.results![index].user!.firstName} '
                                                  '${_searchConsultantLogic.searchConsultantModel.data!.results![index].user!.lastName}';
                                              _searchConsultantLogic.update();
                                              Get.toNamed(PageRoutes
                                                  .consultantProfileForUser);
                                            },
                                            child: Container(
                                              height: 109.h,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        18.w, 12.h, 18.w, 12.h),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ///---profile-image
                                                    Material(
                                                      color:
                                                          customLightThemeColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      child: _searchConsultantLogic
                                                                  .searchConsultantModel
                                                                  .data!
                                                                  .results![
                                                                      index]
                                                                  .user!
                                                                  .imagePath ==
                                                              null
                                                          ? SizedBox(
                                                              width: 76.w,
                                                              height: 85.h,
                                                            )
                                                          : ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                              child:
                                                                  Image.network(
                                                                _searchConsultantLogic
                                                                        .searchConsultantModel
                                                                        .data!
                                                                        .results![
                                                                            index]
                                                                        .user!
                                                                        .imagePath!
                                                                        .contains(
                                                                            'assets')
                                                                    ? '$mediaUrl${_searchConsultantLogic.searchConsultantModel.data!.results![index].user!.imagePath}'
                                                                    : '${_searchConsultantLogic.searchConsultantModel.data!.results![index].user!.imagePath}',
                                                                width: 76.w,
                                                                height: 85.h,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return SizedBox(
                                                                      width:
                                                                          76.w,
                                                                      height:
                                                                          85.h,
                                                                      child: const Icon(
                                                                          Icons
                                                                              .broken_image));
                                                                },
                                                              ),
                                                            ),
                                                    ),
                                                    SizedBox(
                                                      width: 21.w,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 6.h,
                                                        ),

                                                        ///---title
                                                        Text(
                                                          '${_searchConsultantLogic.searchConsultantModel.data!.results![index].user!.firstName} '
                                                          '${_searchConsultantLogic.searchConsultantModel.data!.results![index].user!.lastName}',
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: state
                                                              .topTitleTextStyle!
                                                              .copyWith(
                                                                  color:
                                                                      customTextBlackColor),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),

                                                        ///---sub-title
                                                        Text(
                                                          '${_searchConsultantLogic.searchConsultantModel.data!.results![index].category!.name}',
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: state
                                                              .topSubTitleTextStyle!
                                                              .copyWith(
                                                                  color:
                                                                      customTextBlackColor),
                                                        ),
                                                        const Spacer(),

                                                        ///---rating-bar
                                                        RatingBar.builder(
                                                          ignoreGestures: true,
                                                          initialRating: double.parse(
                                                              _searchConsultantLogic
                                                                  .searchConsultantModel
                                                                  .data!
                                                                  .results![
                                                                      index]
                                                                  .ratingAvg
                                                                  .toString()),
                                                          minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: 15,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      0.0),
                                                          itemBuilder: (context,
                                                                  _) =>
                                                              SvgPicture.asset(
                                                                  'assets/Icons/ratingStarIcon.svg'),
                                                          onRatingUpdate:
                                                              (rating) {},
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
                                ],
                              ),
                            ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
