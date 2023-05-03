import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/all_blogs_logic.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/repos/delete_repo/delete_blog_repo.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/utils/helper_function.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class AllBlogsPage extends StatelessWidget {
  final logic = Get.put(AllBlogsLogic());
  final state = Get.find<AllBlogsLogic>().state;

  AllBlogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllBlogsLogic>(builder: (_allBlogsLogic) {
      return ModalProgressHUD(
          inAsyncCall: _allBlogsLogic.formLoaderController,
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
              controller: _allBlogsLogic.scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  ///---header
                  MyCustomSliverAppBar(
                    heading: "My Blogs".tr,
                    subHeading:
                        LanguageConstant.exploreTodayTrendingArticles.tr,
                    isShrink: _allBlogsLogic.isShrink,
                    // trailingIcon: "Create blog",
                    showCreateBlogWidget: (Get.find<GeneralController>()
                            .storageBox
                            .read('userRole')
                            .toString() ==
                        "Mentor"),
                  ),
                ];
              },
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///---rider-items
                      !logic.getAllBlogsLoader
                          ? SkeletonLoader(
                              period: const Duration(seconds: 2),
                              highlightColor: Colors.grey,
                              direction: SkeletonDirection.ltr,
                              items: 5,
                              builder: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 20),
                                child: Container(
                                  height: 143,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                              ))
                          : (logic.consultantBlogsModel.data?.blogs ?? [])
                                  .isEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  child: Center(
                                    child: Text(
                                        '${LanguageConstant.noRecordFound.tr}!',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: SarabunFontFamily.light,
                                            color: customTextBlackColor)),
                                  ))
                              : Wrap(
                                  children: (logic.consultantBlogsModel.data
                                              ?.blogs ??
                                          [])
                                      .map((e) => Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 0, 15, 20),
                                            child: Container(
                                              height: 120,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14.r),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    customThemeColor
                                                        .withOpacity(0.1),
                                                    customThemeColor
                                                        .withOpacity(0.2),
                                                    customThemeColor
                                                        .withOpacity(0.5),
                                                    customThemeColor
                                                        .withOpacity(0.7),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: const [0, 0.2, 0.8, 1],
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ///blog-image
                                                  Container(
                                                    height: 207.h,
                                                    width: 130.w,
                                                    foregroundDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.r),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          customThemeColor
                                                              .withOpacity(0.1),
                                                          customThemeColor
                                                              .withOpacity(0.2),
                                                          customThemeColor
                                                              .withOpacity(0.5),
                                                          customThemeColor
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: const [
                                                          0,
                                                          0.2,
                                                          0.8,
                                                          1
                                                        ],
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14.r)),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        child:
                                                            (e.imagePath ?? "")
                                                                    .isNotEmpty
                                                                ? Image.network(
                                                                    e.imagePath!
                                                                            .contains('assets')
                                                                        ? '$mediaUrl${e.imagePath}'
                                                                        : '${e.imagePath}',
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )
                                                                : Image.asset(
                                                                    'assets/images/real-estate-01.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )),
                                                  ),

                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              10, 5, 0, 0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///-----Title and delete button
                                                          const SizedBox(
                                                              height: 4),
                                                          Row(
                                                            children: [
                                                              ///----name
                                                              Expanded(
                                                                child: Text(
                                                                  '${e.title}',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 2),

                                                              ///---delete-cart-item-button
                                                              InkWell(
                                                                onTap: () {
                                                                  /// -delete-method
                                                                  _allBlogsLogic
                                                                      .updateFormLoaderController(
                                                                          true);
                                                                  getMethod(
                                                                      context,
                                                                      deleteConsultantBlogUrl,
                                                                      {
                                                                        'token':
                                                                            123,
                                                                        'platform':
                                                                            'app',
                                                                        "blog_id":
                                                                            e.id
                                                                      },
                                                                      true,
                                                                      deleteBlogRepo);

                                                                  log('deletePress----->>');
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                          5,
                                                                          10,
                                                                          10,
                                                                          10),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'assets/Icons/deleteIcon.svg',
                                                                    height: 20,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 4),

                                                          ///-----Description and edit button
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  parseHtmlString(
                                                                      e.description ??
                                                                          ''),
                                                                  maxLines: 2,
                                                                  softWrap:
                                                                      true,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  // style: state.textStylePoppinsRegular,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 4),

                                                              ///---edit-blog-button
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  Get.put(
                                                                      CreateBlogLogic());
                                                                  Get.find<
                                                                          CreateBlogLogic>()
                                                                      .updateBlogId(
                                                                          e.id);
                                                                  await Get.toNamed(
                                                                      PageRoutes
                                                                          .createBlog);

                                                                  // if (logic.updateRiderData) {
                                                                  //   logic.changeUpdateRiderData(false);

                                                                  // logic.updateAllConsultantBlogsLoader(false);
                                                                  // getMethod(Get.context!, consultantBlogUrl,
                                                                  //     {'token': 123, 'platform': 'app', "user_id": Get.find<GeneralController>().storageBox.read('userID')}, true, getAllBlogsRepo);
                                                                  // }
                                                                },
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: Icon(
                                                                      Icons
                                                                          .edit),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          Row(
                                                            children: [
                                                              ///----name
                                                              Expanded(
                                                                child: RichText(
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  text: TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text:
                                                                              'Status: ',
                                                                          // style: state.textStylePoppinsMedium.copyWith(fontSize: 14.sp),
                                                                        ),
                                                                        TextSpan(
                                                                          text: e.isApproved == 1
                                                                              ? "Approved"
                                                                              : 'Not Approved',
                                                                          // style: state.textStylePoppinsBold,
                                                                        ),
                                                                      ]),
                                                                ),
                                                              ),

                                                              ///---delete-cart-item-button
                                                              // Switch(
                                                              //   value: e.isActive == 1,
                                                              //   onChanged: (value) {},
                                                              //   inactiveTrackColor: Theme.of(context)
                                                              //       .extension<CustomColors>()!
                                                              //       .customSwitchColor,
                                                              //   activeTrackColor: customSelectorColor,
                                                              //   activeColor: customThemeColor,
                                                              // ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )
                    ],
                  ),
                ),
              ),

              // SizedBox(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   child:
              //
              //
              //
              //
              //   Padding(
              //     padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
              //     child: SingleChildScrollView(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           ///---recommended-blogs
              //           !_allBlogsLogic.blogLoader
              //               ? SkeletonLoader(
              //               period: const Duration(seconds: 2),
              //               highlightColor: Colors.grey,
              //               direction: SkeletonDirection.ltr,
              //               builder: SizedBox(
              //                 height: 207.h,
              //                 width: MediaQuery.of(context).size.width,
              //                 child: ListView(
              //                   scrollDirection: Axis.horizontal,
              //                   children: List.generate(3, (index) {
              //                     return Padding(
              //                       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
              //                       child: Container(
              //                         width: 183.w,
              //                         height: 207.h,
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(14),
              //                           color: Colors.grey,
              //                         ),
              //                       ),
              //                     );
              //                   }),
              //                 ),
              //               ))
              //               : (_allBlogsLogic.getAllBlogModel.data?.featuredBlogs ?? []).isEmpty
              //               ? const SizedBox()
              //               : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //             Text(
              //               LanguageConstant.recommendedBlogs.tr,
              //               style: state.headingTextStyle,
              //             ),
              //             SizedBox(height: 16.h),
              //             SizedBox(
              //               height: 207.h,
              //               width: MediaQuery.of(context).size.width,
              //               child: ListView(
              //                   scrollDirection: Axis.horizontal,
              //                   children: List.generate(
              //                     (_allBlogsLogic.getAllBlogModel.data?.featuredBlogs ?? []).length,
              //                         (index) => Padding(
              //                       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12.w, 0),
              //                       child: InkWell(
              //                         onTap: () {
              //                           _allBlogsLogic.updateSelectedBlogForView(_allBlogsLogic.getAllBlogModel.data!.featuredBlogs![index], 'Anonymous');
              //                           Get.toNamed(PageRoutes.blogDetail);
              //                         },
              //                         child: Stack(alignment: Alignment.center, children: [
              //                           Container(
              //                             height: 207.h,
              //                             width: 183.w,
              //                             foregroundDecoration: BoxDecoration(
              //                               borderRadius: BorderRadius.circular(14.r),
              //                               gradient: LinearGradient(
              //                                 colors: [
              //                                   customThemeColor.withOpacity(0.1),
              //                                   customThemeColor.withOpacity(0.2),
              //                                   customThemeColor.withOpacity(0.5),
              //                                   customThemeColor.withOpacity(0.7),
              //                                 ],
              //                                 begin: Alignment.topCenter,
              //                                 end: Alignment.bottomCenter,
              //                                 stops: const [0, 0.2, 0.8, 1],
              //                               ),
              //                             ),
              //                             decoration: BoxDecoration(
              //                               color: Colors.grey,
              //                               borderRadius: BorderRadius.all(Radius.circular(10.r)),
              //                             ),
              //                             child: ClipRRect(
              //                                 borderRadius: BorderRadius.circular(14),
              //                                 child: _allBlogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath.toString() != 'null'
              //                                     ? Image.network(
              //                                   _allBlogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath!.contains('assets')
              //                                       ? '$mediaUrl${_allBlogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath}'
              //                                       : '${_allBlogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath}',
              //                                   fit: BoxFit.cover,
              //                                 )
              //                                     : Image.asset(
              //                                   'assets/images/real-estate-01.png',
              //                                   fit: BoxFit.cover,
              //                                 )),
              //                           ),
              //                           Positioned(
              //                             bottom: 20,
              //                             left: 15,
              //                             right: 15,
              //                             child: Text(
              //                               _allBlogsLogic.getAllBlogModel.data?.featuredBlogs?[index].title ?? "N/A",
              //                               maxLines: 3,
              //                               softWrap: true,
              //                               overflow: TextOverflow.ellipsis,
              //                               style: state.categoryTextStyle,
              //                             ),
              //                           )
              //                         ]),
              //                       ),
              //                     ),
              //                   )),
              //             ),
              //           ]),
              //           SizedBox(height: 30.h),
              //
              //
              //
              //
              //
              //
              //         ],
              //       ),
              //     ),
              //   ),
              // )),
            ),
          ));
    });
  }
}
