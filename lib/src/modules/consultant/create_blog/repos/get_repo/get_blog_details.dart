import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_logic.dart';
import 'package:ista_app/src/modules/consultant/create_blog/models/blog_details_model.dart';

blogDetailsRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<CreateBlogLogic>().updateFormLoaderController(false);
  if (responseCheck) {
    print(response);
    Get.find<CreateBlogLogic>().blogDetailsModel = BlogDetailsModel.fromJson(response);
    Get.find<CreateBlogLogic>().initializeValue();
  }
}
