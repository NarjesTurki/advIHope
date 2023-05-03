import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/about_us/state.dart';
import 'package:resize/resize.dart';

class AboutUsLogic extends GetxController {
  final AboutUsState state = AboutUsState();

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool? lastStatus = true;
  double? height = 100;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height! - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
}
