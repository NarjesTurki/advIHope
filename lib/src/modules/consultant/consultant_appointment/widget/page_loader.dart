import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class PageLoaderForConsultantAppointments extends StatefulWidget {
  const PageLoaderForConsultantAppointments({Key? key}) : super(key: key);

  @override
  _PageLoaderForConsultantAppointmentsState createState() =>
      _PageLoaderForConsultantAppointmentsState();
}

class _PageLoaderForConsultantAppointmentsState
    extends State<PageLoaderForConsultantAppointments> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConsultantAppointmentLogic>(
        builder: (_consultantAppointmentLogic) {
      return NestedScrollView(
          controller: _consultantAppointmentLogic.scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              ///---header
              MyCustomSliverAppBar(
                heading: LanguageConstant.myAppointments.tr,
                subHeading: LanguageConstant.manageAndSeeYourAppointmentsLog.tr,
                isShrink: _consultantAppointmentLogic.isShrink,
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
                                  height: 234.h,
                                  width: MediaQuery.of(context).size.width,
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
