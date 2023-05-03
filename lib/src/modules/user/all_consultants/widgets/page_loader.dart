import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/modules/user/all_consultants/logic.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class PageLoader extends StatefulWidget {
  const PageLoader({Key? key}) : super(key: key);

  @override
  _PageLoaderState createState() => _PageLoaderState();
}

class _PageLoaderState extends State<PageLoader> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllConsultantsLogic>(builder: (_allConsultantsLogic) {
      return NestedScrollView(
          controller: _allConsultantsLogic.scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              ///---header
              MyCustomSliverAppBar(
                heading: LanguageConstant.consultant.tr,
                subHeading: LanguageConstant.bestConsultantsJustOneClickAway.tr,
                isShrink: _allConsultantsLogic.isShrink,
                searchIconShow: true,
              ),
            ];
          },
          body: SingleChildScrollView(
            child: SkeletonLoader(
                period: const Duration(seconds: 2),
                highlightColor: Colors.grey,
                direction: SkeletonDirection.ltr,
                builder: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Wrap(
                            spacing: 12.w,
                            runSpacing: 18.h,
                            alignment: WrapAlignment.start,
                            children: List.generate(
                              4,
                              (index) => Padding(
                                padding: EdgeInsets.only(top: 0.h),
                                child: Container(
                                  height: 217.h,
                                  width: 164.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                )),
          ));
    });
  }
}
