import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/all_blogs_state.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/models/consultant_blogs_model.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/repos/get_repo/get_blog_repo.dart';

class AllBlogsLogic extends GetxController {
  final AllBlogsState state = AllBlogsState();

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController()..addListener(scrollListener);
    getMethod(
        Get.context!,
        consultantBlogUrl,
        {
          'token': 123,
          'platform': 'app',
          "user_id": Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getAllBlogsRepo);
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  ScrollController scrollController = ScrollController();
  bool lastStatus = true;

  double height = 100;
  bool get isShrink {
    return scrollController.hasClients &&
        scrollController.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  bool getAllBlogsLoader = false;

  ConsultantBlogsModel consultantBlogsModel = ConsultantBlogsModel();

  /// --- update-post-loader
  updateAllConsultantBlogsLoader(bool value) {
    getAllBlogsLoader = value;
    update();
  }

  bool formLoaderController = false;

  updateFormLoaderController(bool newValue) {
    formLoaderController = newValue;
    update();
  }
}
