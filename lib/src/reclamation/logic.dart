import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/reclamation/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resize/resize.dart';

class ReclamationLogic extends GetxController {
  final ReaclamtionState state = ReaclamtionState();

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
}
