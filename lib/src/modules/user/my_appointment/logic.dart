import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/modules/user/my_appointment/model_get_user_appointment.dart';
import 'package:ista_app/src/modules/user/my_appointment/model_get_user_appointment_more.dart';
import 'package:ista_app/src/modules/user/my_appointment/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resize/resize.dart';

class MyAppointmentLogic extends GetxController {
  final MyAppointmentState state = MyAppointmentState();

  late TabController tabController;

  GetUserAppointmentModel getUserAppointmentModel = GetUserAppointmentModel();
  GetUserAppointmentModelMore getUserAppointmentModelMore =
      GetUserAppointmentModelMore();

  bool? getUserAppointmentLoader = true;
  updateGetUserAppointmentLoader(bool? newValue) {
    getUserAppointmentLoader = newValue;
    update();
  }

  bool? getUserAppointmentMoreLoader = false;
  updateGetUserAppointmentMoreLoader(bool? newValue) {
    getUserAppointmentMoreLoader = newValue;
    update();
  }

  final RefreshController refreshAppointmentsController =
      RefreshController(initialRefresh: false);

  updateRefreshController() {
    refreshAppointmentsController.refreshCompleted();
    update();
  }

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.positions.last.pixels > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  List<Tab> tabBarList = [
    Tab(
      text: LanguageConstant.pending.tr,
    ),
    Tab(
      text: LanguageConstant.accepted.tr,
    ),
    Tab(text: LanguageConstant.completed.tr),
    Tab(text: LanguageConstant.cancelled.tr),
  ];

  List imagesForAppointmentTypes = [
    ///---audio
    'assets/Icons/audio.svg',

    ///---video
    'assets/Icons/videoCallIcon.svg',

    ///---chat
    'assets/Icons/chatIcon.svg',

    ///---on-site
    'assets/Icons/physicalIcon.svg',

    ///---home-visit
    'assets/Icons/house-fill.svg',

    ///---Live
    'assets/Icons/live.svg',
  ];
}
