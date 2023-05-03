import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/modules/user/user_drawer/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class UserDrawerPage extends StatefulWidget {
  const UserDrawerPage({Key? key}) : super(key: key);

  @override
  State<UserDrawerPage> createState() => _UserDrawerPageState();
}

class _UserDrawerPageState extends State<UserDrawerPage> {
  final logic = Get.put(UserDrawerLogic());

  final state = Get.find<UserDrawerLogic>().state;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
      return GetBuilder<UserDrawerLogic>(builder: (_userDrawerLogic) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              ///---background
              PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: Image.asset(
                    'assets/images/drawerBackground.png',
                    width: MediaQuery.of(context).size.width * .8,
                  )),

              ///---body
              SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),

                      Get.find<GeneralController>()
                              .storageBox
                              .hasData('authToken')
                          ?

                          ///---profile-area
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _userHomeLogic
                                                .getUserProfileModel.data ==
                                            null
                                        ? SkeletonLoader(
                                            period: const Duration(seconds: 2),
                                            highlightColor: Colors.grey,
                                            direction: SkeletonDirection.ltr,
                                            builder: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ///---image
                                                Container(
                                                  height: 40.h,
                                                  width: 55.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ///---name
                                                    Container(
                                                      height: 10.h,
                                                      width: 80.w,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r)),
                                                    ),

                                                    SizedBox(
                                                      height: 10.h,
                                                    ),

                                                    ///---email
                                                    Container(
                                                      height: 10.h,
                                                      width: 150.w,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox()
                                              ],
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ///---image
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                decoration: const BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle),
                                                child: _userHomeLogic
                                                            .getUserProfileModel
                                                            .data!
                                                            .user!
                                                            .imagePath ==
                                                        null
                                                    ? const SizedBox()
                                                    : ClipOval(
                                                        child: Image.network(
                                                          _userHomeLogic
                                                                  .getUserProfileModel
                                                                  .data!
                                                                  .user!
                                                                  .imagePath!
                                                                  .contains(
                                                                      'assets')
                                                              ? '$mediaUrl${_userHomeLogic.getUserProfileModel.data!.user!.imagePath}'
                                                              : '${_userHomeLogic.getUserProfileModel.data!.user!.imagePath}',
                                                          fit: BoxFit.fill,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                        ),
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ///---name
                                                  Text(
                                                    _userHomeLogic
                                                            .getUserProfileModel
                                                            .data!
                                                            .user!
                                                            .firstName ??
                                                        '',
                                                    style: state.nameTextStyle,
                                                  ),

                                                  SizedBox(
                                                    height: 7.h,
                                                  ),

                                                  ///---email
                                                  Text(
                                                    _userHomeLogic
                                                            .getUserProfileModel
                                                            .data!
                                                            .user!
                                                            .email ??
                                                        '',
                                                    style: state.emailTextStyle,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox()
                                            ],
                                          ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            5.w, 5.h, 0, 5.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ColorFiltered(
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.green,
                                                      BlendMode.srcIn),
                                              child: SvgPicture.asset(
                                                  'assets/Icons/drawerBackArrowIcon.svg'),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            )
                          :

                          ///---login-route
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(PageRoutes.login);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 55.h,
                                            width: 55.w,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/Icons/v1.png'))),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Text(
                                            LanguageConstant.letsLogin.tr,
                                            style: state.nameTextStyle,
                                          ),
                                          const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            5.w, 5.h, 0, 5.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ColorFiltered(
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.green,
                                                      BlendMode.srcIn),
                                              child: SvgPicture.asset(
                                                  'assets/Icons/drawerBackArrowIcon.svg'),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),

                      ///---list
                      Expanded(
                          child: ListView(
                        children: List.generate(
                            Get.find<GeneralController>()
                                    .storageBox
                                    .hasData('authToken')
                                ? _userDrawerLogic.drawerLoginList.length
                                : _userDrawerLogic.drawerList.length, (index) {
                          List<DrawerTile> drawerShowList =
                              Get.find<GeneralController>()
                                      .storageBox
                                      .hasData('authToken')
                                  ? _userDrawerLogic.drawerLoginList
                                  : _userDrawerLogic.drawerList;
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 45, right: 70),
                              child: FadedSlideAnimation(
                                slideDuration:
                                    const Duration(milliseconds: 1000),
                                fadeDuration:
                                    const Duration(milliseconds: 2000),
                                beginOffset: const Offset(0.3, 0.2),
                                endOffset: const Offset(0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        if (Get.find<GeneralController>()
                                            .storageBox
                                            .hasData('authToken')) {
                                          _userDrawerLogic
                                              .userLoginDrawerNavigation(
                                                  index, context);
                                        } else {
                                          _userDrawerLogic.userDrawerNavigation(
                                              index, context);
                                        }
                                      },
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ColorFiltered(
                                            colorFilter: const ColorFilter.mode(
                                                Colors.green, BlendMode.srcIn),
                                            child: SvgPicture.asset(
                                              '${drawerShowList[index].icon}',
                                              height: 25.h,
                                              width: 25.w,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                      title: Text(
                                        '${drawerShowList[index].title}',
                                        style: state.titleTextStyle,
                                      ),
                                    ),
                                    Divider(
                                      color: Color.fromARGB(255, 230, 227, 227),
                                      thickness: 1.5,
                                      height: 10.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
