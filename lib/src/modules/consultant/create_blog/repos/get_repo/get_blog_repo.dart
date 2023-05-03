import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_logic.dart';
import 'package:ista_app/src/modules/consultant/create_blog/models/blog_categories_model.dart';
import 'package:ista_app/src/modules/consultant/create_blog/repos/get_repo/get_blog_details.dart';

blogCategoriesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    print(response);
    Get.find<CreateBlogLogic>().blogCategoriesModel =
        BlogCategoriesModel.fromJson(response);
    //
    Get.find<CreateBlogLogic>().updateBlogCategoryLoader(true);

    ///---category
    Get.find<CreateBlogLogic>().emptyCategoryDropDownList();
    for (var element
        in (Get.find<CreateBlogLogic>().blogCategoriesModel.data?.categories ??
            [])) {
      Get.find<CreateBlogLogic>().updateCategoryDropDownList(element.name);
    }
    if (Get.find<CreateBlogLogic>().blogId != null) {
      Get.find<CreateBlogLogic>().updateFormLoaderController(true);

      getMethod(
          Get.context!,
          blogDetailUrl,
          {
            'token': 123,
            'platform': 'app',
            "id": Get.find<CreateBlogLogic>().blogId
          },
          true,
          blogDetailsRepo);
    }
  }
}
