import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/blogs/model.dart';
import 'package:ista_app/src/modules/blogs/state.dart';

class BlogsLogic extends GetxController {
  final BlogsState state = BlogsState();

  GetAllBlogModel getAllBlogModel = GetAllBlogModel();

  bool blogLoader = false;
  updateBlogLoader(bool newValue) {
    blogLoader = newValue;
    update();
  }

  String? selectedBlogCategory;
  BlogModel selectedBlogForView = BlogModel();
  updateSelectedBlogForView(
      BlogModel newValue, String? newSelectedBlogCategory) {
    selectedBlogForView = newValue;
    selectedBlogCategory = newSelectedBlogCategory;
    update();
  }

  int? selectedBlogCategoryIndex = 0;
  updateSelectedBlogCategoryIndex(int? newValue) {
    selectedBlogCategoryIndex = newValue;
    update();
  }

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
}
