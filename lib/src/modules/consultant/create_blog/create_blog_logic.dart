import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_state.dart';
import 'package:ista_app/src/modules/consultant/create_blog/models/blog_categories_model.dart';
import 'package:ista_app/src/modules/consultant/create_blog/models/blog_details_model.dart';
import 'package:resize/resize.dart';

class CreateBlogLogic extends GetxController {
  final CreateBlogState state = CreateBlogState();

  HtmlEditorController descriptionController = HtmlEditorController();
  TextEditingController titleController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool lastStatus = true;

  double height = 100.h;

  BlogCategoriesModel blogCategoriesModel = BlogCategoriesModel();
  BlogDetailsModel blogDetailsModel = BlogDetailsModel();

  String? selectedCategory;
  int? selectedCategoryId;
  String? description;

  updateSelectedCategory(String? value) {
    selectedCategory = value;
    selectedCategoryId = null;
    for (Categories element in (blogCategoriesModel.data?.categories ?? [])) {
      if (value!.contains(element.name!)) {
        selectedCategoryId = element.id;
      }
    }
    log(value.toString());
    log(selectedCategoryId.toString());

    update();
  }

  List<String> categoryDropDownList = [];

  updateCategoryDropDownList(String newValue) {
    categoryDropDownList.add(newValue);
    update();
  }

  emptyCategoryDropDownList() {
    categoryDropDownList = [];
    update();
  }

  bool blogCategoryLoader = false;

  updateBlogCategoryLoader(bool value) {
    blogCategoryLoader = value;
    update();
  }

  bool formLoaderController = false;

  updateFormLoaderController(bool newValue) {
    formLoaderController = newValue;
    update();
  }

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

  int? blogId;
  updateBlogId(int? value) {
    blogId = value;
    update();
  }

  String? selectedFileName;
  FilePickerResult? filePickerResult;

  updateSelectedFileName(String? newValue) {
    selectedFileName = newValue;
    update();
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  ///--focus-out
  focusOut(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  initializeValue() async {
    descriptionController.insertHtml(
        (blogDetailsModel.data?.blog?.description ?? "").toString());
    description = blogDetailsModel.data?.blog?.description ?? "";
    titleController.text = blogDetailsModel.data?.blog?.title ?? "";
    selectedCategoryId = blogDetailsModel.data?.blog?.categoryId;
    for (Categories element in (blogCategoriesModel.data?.categories ?? [])) {
      if (selectedCategoryId == element.id) {
        selectedCategory = element.name;
      }
    }

    update();
  }

  clearValue() {
    blogDetailsModel = BlogDetailsModel();
    description = null;
    selectedCategory = null;
    selectedCategoryId = null;
    titleController.clear();
    update();
  }
}
