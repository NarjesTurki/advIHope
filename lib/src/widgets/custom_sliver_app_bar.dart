import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/notification_icon.dart';
import 'package:resize/resize.dart';

class MyCustomSliverAppBar extends StatefulWidget {
  const MyCustomSliverAppBar(
      {Key? key,
      this.heading,
      this.subHeading,
      this.trailing,
      this.trailingIcon,
      this.fee,
      this.feeImage,
      this.isShrink,
      this.searchIconShow,
      this.onTapTrailing,
      this.showCreateBlogWidget})
      : super(key: key);

  final String? heading;
  final String? subHeading;
  final String? trailing;
  final String? trailingIcon;
  final String? fee;
  final String? feeImage;
  final bool? isShrink;
  final bool? searchIconShow;
  final bool? showCreateBlogWidget;
  final Function? onTapTrailing;

  @override
  _MyCustomSliverAppBarState createState() => _MyCustomSliverAppBarState();
}

class _MyCustomSliverAppBarState extends State<MyCustomSliverAppBar> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.fee == null
          ? MediaQuery.of(context).size.height * .3
          : MediaQuery.of(context).size.height * .30,
      floating: true,
      pinned: true,
      snap: false,
      elevation: 0,
      backgroundColor: widget.isShrink! ? customThemeColor : Colors.transparent,
      leading: InkWell(
        onTap: () {
          if (Get.previousRoute.contains('appointmentConfirmation') ||
              Get.previousRoute.contains('myAppointment')) {
            Get.offAllNamed(PageRoutes.userHome);
          } else {
            Get.back();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
          ],
        ),
      ),
      actions: [
        ///---notifications

        widget.searchIconShow != null
            ? Padding(
                padding: EdgeInsetsDirectional.only(end: 5.w),
                child: SvgPicture.asset(
                  'assets/Icons/searchIcon.svg',
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: 20.w,
        ),
        const CustomNotificationIcon(
          color: Colors.white,
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20.r))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset('assets/images/bookAppointmentAppBar.svg',
                        width: MediaQuery.of(context).size.width * .10,
                        height: MediaQuery.of(context).size.height * .30,
                        fit: BoxFit.cover),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.w, 25.h, 16.w, 16.h),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 50.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${widget.heading}',
                                      style: TextStyle(
                                          fontFamily: SarabunFontFamily.bold,
                                          fontSize: 28.sp,
                                          color: Colors.white),
                                    ),
                                    widget.showCreateBlogWidget ?? false
                                        ? InkWell(
                                            onTap: () {
                                              Get.put(CreateBlogLogic());
                                              Get.find<CreateBlogLogic>()
                                                  .updateBlogId(null);
                                              Get.toNamed(
                                                  PageRoutes.createBlog);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 6),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  border: Border.all(
                                                      color: Colors.white)),
                                              child: Text(
                                                LanguageConstant.createBlog.tr,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .extraBold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(
                                            height: 40,
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                /*Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${widget.subHeading}',
                                      style: TextStyle(
                                          fontFamily: SarabunFontFamily.medium,
                                          fontSize: 12.sp,
                                          color: Colors.white),
                                    ),
                                    widget.trailing == null
                                        ? const SizedBox()
                                        : Text(
                                            '${widget.trailing}',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.medium,
                                                fontSize: 12.sp,
                                                color: Colors.white),
                                          ),
                                  ],
                                ),*/

                                Row(
                                  children: [
                                    //prix
                                    widget.fee == null
                                        ? const SizedBox()
                                        : SizedBox(
                                            height: 15.h,
                                          ),
                                    widget.fee == null
                                        ? const SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                LanguageConstant.youWillPay.tr,
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .medium,
                                                    fontSize: 12.sp,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Text(
                                                    '${widget.fee}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .extraBold,
                                                        fontSize: 25.sp,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                    widget.fee == null
                                        ? const SizedBox()
                                        : SizedBox(
                                            height: 10.h,
                                          ),
                                  ],
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
    );
  }
}
