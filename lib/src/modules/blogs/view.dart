import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/blogs/logic.dart';
import 'package:ista_app/src/modules/blogs/repo.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  final logic = Get.put(BlogsLogic());

  final state = Get.find<BlogsLogic>().state;

  TabController? blogsTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMethod(context, categoriesBlogUrl, {'token': '123'}, false, blogRepo);

    Get.find<BlogsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<BlogsLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<BlogsLogic>()
        .scrollController!
        .removeListener(Get.find<BlogsLogic>().scrollListener);
    Get.find<BlogsLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BlogsLogic>(builder: (_blogsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _blogsLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: LanguageConstant.blog.tr,
                      subHeading:
                          LanguageConstant.exploreTodayTrendingArticles.tr,
                      isShrink: _blogsLogic.isShrink,
                    ),
                  ];
                },
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///---recommended-blogs
                          !_blogsLogic.blogLoader
                              ? SkeletonLoader(
                                  period: const Duration(seconds: 2),
                                  highlightColor: Colors.grey,
                                  direction: SkeletonDirection.ltr,
                                  builder: SizedBox(
                                    height: 207.h,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(3, (index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 15, 0),
                                          child: Container(
                                            width: 183.w,
                                            height: 207.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ))
                              : (_blogsLogic.getAllBlogModel.data
                                              ?.featuredBlogs ??
                                          [])
                                      .isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Text(
                                            LanguageConstant
                                                .recommendedBlogs.tr,
                                            style: state.headingTextStyle,
                                          ),
                                          SizedBox(height: 16.h),
                                          SizedBox(
                                            height: 207.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: List.generate(
                                                  (_blogsLogic
                                                              .getAllBlogModel
                                                              .data
                                                              ?.featuredBlogs ??
                                                          [])
                                                      .length,
                                                  (index) => Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 12.w, 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _blogsLogic.updateSelectedBlogForView(
                                                            _blogsLogic
                                                                .getAllBlogModel
                                                                .data!
                                                                .featuredBlogs![index],
                                                            'Anonymous');
                                                        Get.toNamed(PageRoutes
                                                            .blogDetail);
                                                      },
                                                      child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              height: 207.h,
                                                              width: 183.w,
                                                              foregroundDecoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14.r),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    customThemeColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                    customThemeColor
                                                                        .withOpacity(
                                                                            0.2),
                                                                    customThemeColor
                                                                        .withOpacity(
                                                                            0.5),
                                                                    customThemeColor
                                                                        .withOpacity(
                                                                            0.7),
                                                                  ],
                                                                  begin: Alignment
                                                                      .topCenter,
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.r)),
                                                              ),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              14),
                                                                  child: _blogsLogic
                                                                              .getAllBlogModel
                                                                              .data!
                                                                              .featuredBlogs![
                                                                                  index]
                                                                              .imagePath
                                                                              .toString() !=
                                                                          'null'
                                                                      ? Image
                                                                          .network(
                                                                          _blogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath!.contains('assets')
                                                                              ? '$mediaUrl${_blogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath}'
                                                                              : '${_blogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath}',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                      : Image
                                                                          .asset(
                                                                          'assets/images/real-estate-01.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                            ),
                                                            Positioned(
                                                              bottom: 20,
                                                              left: 15,
                                                              right: 15,
                                                              child: Text(
                                                                _blogsLogic
                                                                        .getAllBlogModel
                                                                        .data
                                                                        ?.featuredBlogs?[
                                                                            index]
                                                                        .title ??
                                                                    "N/A",
                                                                maxLines: 3,
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: state
                                                                    .categoryTextStyle,
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ]),
                          SizedBox(height: 30.h),

                          /// Text
                          Text(
                            LanguageConstant.forYou.tr,
                            style: state.headingTextStyle,
                          ),
                          SizedBox(height: 30.h),

                          ///---tabs
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            child: !_blogsLogic.blogLoader
                                ? SkeletonLoader(
                                    period: const Duration(seconds: 2),
                                    highlightColor: Colors.grey,
                                    direction: SkeletonDirection.ltr,
                                    builder: SizedBox(
                                      height: 220.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView(
                                        children: List.generate(3, (index) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 15, 0),
                                            child: Container(
                                              height: 220.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ))
                                : DefaultTabController(
                                    length: (_blogsLogic.getAllBlogModel.data
                                                ?.categoryBlogs ??
                                            [])
                                        .length,
                                    child: TabBar(
                                        onTap: (index) {
                                          setState(() {
                                            _blogsLogic
                                                .updateSelectedBlogCategoryIndex(
                                                    index);
                                          });
                                        },
                                        isScrollable: true,
                                        controller: blogsTabController,
                                        indicatorColor: customThemeColor,
                                        indicator: UnderlineTabIndicator(
                                            insets: EdgeInsetsDirectional.only(
                                                end: 20.w),
                                            borderSide: BorderSide(
                                              width: 2.w,
                                              color: customThemeColor,
                                            )),
                                        labelStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: customThemeColor),
                                        labelColor: customThemeColor,
                                        unselectedLabelColor:
                                            const Color(0xff727377),
                                        unselectedLabelStyle: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff727377),
                                        ),
                                        labelPadding:
                                            const EdgeInsetsDirectional.all(1),
                                        tabs: List.generate(
                                            _blogsLogic
                                                .getAllBlogModel
                                                .data!
                                                .categoryBlogs!
                                                .length, (tabIndex) {
                                          return Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                bottom: 5.h, end: 20.w),
                                            child: Text(
                                              '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![tabIndex].category!.name}',
                                            ),
                                          );
                                        })),
                                  ),
                          ),

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            child: SingleChildScrollView(
                                child: !_blogsLogic.blogLoader
                                    ? SkeletonLoader(
                                        period: const Duration(seconds: 2),
                                        highlightColor: Colors.grey,
                                        direction: SkeletonDirection.ltr,
                                        builder: Wrap(
                                            children: List.generate(
                                                1,
                                                (index) => Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(bottom: 10),
                                                    child: Container(
                                                      height: 174.h,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    )))))
                                    : SizedBox(
                                        child:
                                            (_blogsLogic.getAllBlogModel.data
                                                            ?.categoryBlogs ??
                                                        [])
                                                    .isEmpty
                                                ? Center(
                                                    child: Text(
                                                        '${LanguageConstant.noRecordFound.tr}!',
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily:
                                                                SarabunFontFamily
                                                                    .light,
                                                            color:
                                                                customTextBlackColor)),
                                                  )
                                                : Builder(builder: (_) {
                                                    return (_blogsLogic
                                                                    .getAllBlogModel
                                                                    .data
                                                                    ?.categoryBlogs?[
                                                                        _blogsLogic
                                                                            .selectedBlogCategoryIndex!]
                                                                    .blogs ??
                                                                [])
                                                            .isEmpty
                                                        ? Center(
                                                            child: Text(
                                                                '${LanguageConstant.noRecordFound.tr}!',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFamily:
                                                                        SarabunFontFamily
                                                                            .light,
                                                                    color:
                                                                        customTextBlackColor)),
                                                          )
                                                        : Wrap(
                                                            children:
                                                                List.generate(
                                                            (_blogsLogic
                                                                        .getAllBlogModel
                                                                        .data
                                                                        ?.categoryBlogs?[
                                                                            _blogsLogic.selectedBlogCategoryIndex!]
                                                                        .blogs ??
                                                                    [])
                                                                .length,
                                                            (index) => Column(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      _blogsLogic.updateSelectedBlogForView(
                                                                          _blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![
                                                                              index],
                                                                          _blogsLogic
                                                                              .getAllBlogModel
                                                                              .data!
                                                                              .categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!]
                                                                              .category!
                                                                              .name);
                                                                      Get.toNamed(
                                                                          PageRoutes
                                                                              .blogDetail);
                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: 25.h,
                                                                                width: 108.w,
                                                                                decoration: BoxDecoration(color: customLightOrangeColor, borderRadius: BorderRadius.all(Radius.circular(6.r))),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].category!.name}',
                                                                                    style: state.blogCategoryTextStyle,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 15.h),

                                                                              /// Time
                                                                              Row(
                                                                                children: [
                                                                                  SvgPicture.asset('assets/Icons/blogTimeIcon.svg'),
                                                                                  SizedBox(width: 4.w),
                                                                                  Text(
                                                                                    DateFormat('dd-MM-yyyy').format(DateTime.parse(_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].createdAt!)),
                                                                                    style: state.blogCategoryTextStyle?.copyWith(color: customTextBlackColor),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 10.h),

                                                                              /// Blog name
                                                                              Text(
                                                                                '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].title}',
                                                                                softWrap: true,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                style: state.blogNameTextStyle,
                                                                              ),
                                                                              SizedBox(height: 20.h),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              16.w,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                153.h,
                                                                            width:
                                                                                128.w,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.grey,
                                                                              borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                                            ),
                                                                            child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(14),
                                                                                child: _blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].imagePath.toString() != 'null'
                                                                                    ? Image.network(
                                                                                        _blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].imagePath!.contains('assets') ? '$mediaUrl${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].imagePath}' : '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].imagePath}',
                                                                                        fit: BoxFit.cover,
                                                                                      )
                                                                                    : Image.asset(
                                                                                        'assets/images/blogImage1.png',
                                                                                        fit: BoxFit.cover,
                                                                                      )),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          15.h),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            16.w,
                                                                            0),
                                                                    child:
                                                                        const Divider(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          20.h),
                                                                ]),
                                                          ));
                                                  }),
                                      )
                                // }),
                                ),
                          ),

                          /// ========///
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        );
      });
    });
  }
}
