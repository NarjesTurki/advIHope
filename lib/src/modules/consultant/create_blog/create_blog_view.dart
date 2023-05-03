import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_logic.dart';
import 'package:ista_app/src/modules/consultant/create_blog/repos/get_repo/get_blog_repo.dart';
import 'package:ista_app/src/modules/consultant/create_blog/repos/post_repo/post_blog_repo.dart';
import 'package:ista_app/src/modules/image_full_view/view.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/custom_dialog.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'package:dio/dio.dart' as dio_instance;

class CreateBlogPage extends StatefulWidget {
  const CreateBlogPage({Key? key}) : super(key: key);

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  final logic = Get.put(CreateBlogLogic());

  final state = Get.find<CreateBlogLogic>().state;

  File? profileImage;

  List profileImagesList = [];

  @override
  void initState() {
    super.initState();
    logic.clearValue();
    logic.scrollController = ScrollController()
      ..addListener(logic.scrollListener);

    getMethod(Get.context!, blogCategoriesUrl,
        {'token': 123, 'platform': 'app'}, true, blogCategoriesRepo);
  }

  @override
  void dispose() {
    logic.scrollController.removeListener(logic.scrollListener);
    logic.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateBlogLogic>(builder: (createBlogLogic) {
      return GestureDetector(
        onTap: () {
          createBlogLogic.focusOut(context);
        },
        child: ModalProgressHUD(
          inAsyncCall: createBlogLogic.formLoaderController,
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: NestedScrollView(
                controller: createBlogLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: logic.blogId != null
                          ? "Update Blog"
                          : LanguageConstant.createABlog.tr,
                      subHeading: LanguageConstant.strangerOnce.tr,
                      isShrink: createBlogLogic.isShrink,
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Form(
                      key: logic.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///---question-area
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 25.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 15,
                                    // offset: Offset(1,5)
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Title", style: state.headingTextStyle),
                                SizedBox(height: 14.h),

                                ///---question-field

                                TextFormField(
                                  controller: createBlogLogic.titleController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 3,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    hintText: "Type here",
                                    // contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                    fillColor: customTextFieldColor,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: customLightThemeColor)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.red)),
                                  ),
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return LanguageConstant.fieldRequired.tr;
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 14.h),
                                Text("Category", style: state.headingTextStyle),

                                !createBlogLogic.blogCategoryLoader
                                    ? SkeletonLoader(
                                        period: const Duration(seconds: 2),
                                        highlightColor: Colors.grey,
                                        direction: SkeletonDirection.ltr,
                                        builder: IgnorePointer(
                                          ignoring: true,
                                          child:
                                              DropdownButtonFormField<String>(
                                            hint: Text(
                                              "Category".tr.capitalizeFirst!,
                                              // style: state.hintTextStyle,
                                            ),
                                            decoration: InputDecoration(
                                              filled: true,
                                              isDense: true,
                                              disabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red)),
                                            ),
                                            isExpanded: true,
                                            focusColor: Colors.white,
                                            // style: state.textFieldTextStyle,
                                            iconEnabledColor: customThemeColor,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            iconSize: 25,

                                            items: const [
                                              DropdownMenuItem<String>(
                                                child: Text("Category"),
                                              )
                                            ],

                                            onChanged: createBlogLogic
                                                .updateSelectedCategory,
                                            validator: (String? value) {
                                              if ((value ?? "").isEmpty) {
                                                return LanguageConstant
                                                    .fieldRequired.tr;
                                              }
                                              return null;
                                            },
                                          ),
                                        ))
                                    : Column(
                                        children: [
                                          SizedBox(height: 14.h),
                                          ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField<
                                                  String>(
                                                onTap: () {
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);
                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }
                                                },
                                                hint: Text(
                                                  "Category"
                                                      .tr
                                                      .capitalizeFirst!,
                                                  // style: state.hintTextStyle,
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.w, 20.h,
                                                              0.w, 14.h),
                                                  fillColor:
                                                      customTextFieldColor,
                                                  filled: true,
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide: const BorderSide(
                                                          color:
                                                              customLightThemeColor)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red)),
                                                ),
                                                isExpanded: true,
                                                focusColor: Colors.white,
                                                // style: state.textFieldTextStyle,
                                                iconEnabledColor:
                                                    customThemeColor,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                iconSize: 25,
                                                value: createBlogLogic
                                                    .selectedCategory,
                                                items: createBlogLogic
                                                    .categoryDropDownList
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      // style: state.textFieldTextStyle,
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: createBlogLogic
                                                    .updateSelectedCategory,
                                                validator: (String? value) {
                                                  if ((value ?? "").isEmpty) {
                                                    return LanguageConstant
                                                        .fieldRequired.tr;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                SizedBox(height: 14.h),
                                Text("Description",
                                    style: state.headingTextStyle),
                                SizedBox(height: 14.h),
                                HtmlEditor(
                                    controller:
                                        createBlogLogic.descriptionController,
                                    htmlEditorOptions: const HtmlEditorOptions(
                                      adjustHeightForKeyboard: false,
                                      autoAdjustHeight: true,
                                      shouldEnsureVisible: true,
                                      hint: "Your text here...",
                                    ),
                                    htmlToolbarOptions:
                                        const HtmlToolbarOptions(
                                            initiallyExpanded: false,
                                            toolbarType: ToolbarType.nativeGrid,
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                            dropdownBackgroundColor:
                                                Colors.white),
                                    otherOptions: const OtherOptions(
                                      height: 400,
                                    ),
                                    callbacks: Callbacks(
                                      // onBeforeCommand: (String? currentHtml) {
                                      //   print('html before change is $currentHtml');
                                      // },
                                      onChangeContent: (String? value) {
                                        logic.description = value ?? "";
                                        print('content changed to $value');
                                      },
                                    )),
                                SizedBox(height: 14.h),
                                Text("Image", style: state.headingTextStyle),
                                SizedBox(height: 14.h),

                                ///---picture
                                InkWell(
                                    onTap: () {
                                      if (profileImage == null) {
                                        imagePickerDialog(context);
                                        return;
                                      }
                                      imagePickerDialog(context,
                                          fileImage: profileImage);
                                    },
                                    child: Center(
                                      child: profileImage == null
                                          ? ((logic.blogDetailsModel.data?.blog
                                                          ?.imagePath ??
                                                      "")
                                                  .isNotEmpty)
                                              ? SizedBox(
                                                  height: 200.h,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      child: Image.network(
                                                        logic
                                                                .blogDetailsModel
                                                                .data!
                                                                .blog!
                                                                .imagePath!
                                                                .contains(
                                                                    'assets')
                                                            ? '$mediaUrl${logic.blogDetailsModel.data?.blog?.imagePath}'
                                                            : '${logic.blogDetailsModel.data?.blog?.imagePath}',
                                                        fit: BoxFit.cover,
                                                      )),
                                                )
                                              : Container(
                                                  height: 103.h,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      // color: customTextFieldColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/uploadPicRect.png'),
                                                          fit: BoxFit.fill)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images/cloud-upload-fill.svg',
                                                          height: 22.h,
                                                          width: 23.w),
                                                      SizedBox(height: 17.h),
                                                      Text(
                                                        "Upload Image".tr,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                SarabunFontFamily
                                                                    .regular,
                                                            fontSize: 16.sp,
                                                            color:
                                                                customThemeColor),
                                                      )
                                                    ],
                                                  ),
                                                )
                                          : SizedBox(
                                              height: 200.h,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  child: Image.file(
                                                    profileImage!,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          InkWell(
                            onTap: () async {
                              if (!createBlogLogic.formKey.currentState!
                                  .validate()) {
                                return;
                              }
                              print(createBlogLogic.description);
                              if (((createBlogLogic.description ?? "").trim())
                                  .isEmpty) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                        title: LanguageConstant.sorry.tr,
                                        titleColor: customDialogErrorColor,
                                        descriptions:
                                            "Description is required".tr,
                                        text: LanguageConstant.ok.tr,
                                        functionCall: () {
                                          Navigator.pop(context);
                                        },
                                        img: 'assets/Icons/dialog_error.svg',
                                      );
                                    });
                                return;
                              }
                              if ((logic.blogDetailsModel.data?.blog
                                              ?.imagePath ??
                                          "")
                                      .isEmpty &&
                                  profileImage == null) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                        title: LanguageConstant.sorry.tr,
                                        titleColor: customDialogErrorColor,
                                        descriptions: "Image is required".tr,
                                        text: LanguageConstant.ok.tr,
                                        functionCall: () {
                                          Navigator.pop(context);
                                        },
                                        img: 'assets/Icons/dialog_error.svg',
                                      );
                                    });
                                return;
                              }

                              createBlogLogic.updateFormLoaderController(true);

                              dio_instance.FormData formData = dio_instance
                                  .FormData.fromMap(<String, dynamic>{
                                'token': '123',
                                'title': createBlogLogic.titleController.text,
                                'category_id':
                                    createBlogLogic.selectedCategoryId,
                                'description': createBlogLogic.description,
                                'user_id': Get.find<GeneralController>()
                                    .storageBox
                                    .read('userID'),
                                if (createBlogLogic.blogId != null)
                                  "blog_id": createBlogLogic.blogId,
                                if (profileImage != null)
                                  'image':
                                      await dio_instance.MultipartFile.fromFile(
                                          profileImage!.path)
                              });

                              if (createBlogLogic.blogId != null) {
                                postMethod(context, updateConsultantBlogUrl,
                                    formData, true, postBlogRepo);
                                return;
                              }
                              postMethod(context, createConsultantBlogUrl,
                                  formData, true, postBlogRepo);
                            },
                            child: Center(
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: customThemeColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    createBlogLogic.blogId != null
                                        ? "update".tr
                                        : 'submit'.tr,
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.bold,
                                        fontSize: 16.sp,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      );
    });
  }

  void imagePickerDialog(
    BuildContext context, {
    File? fileImage,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    if (fileImage != null) {
                      Get.to(ImageViewScreen(fileImage: fileImage));
                      return;
                    }

                    setState(() {
                      profileImagesList = [];
                    });
                    profileImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (profileImagesList.isNotEmpty) {
                      setState(() {
                        profileImage = File(profileImagesList[0].path);
                      });
                    }
                  },
                  child: Text(
                    fileImage != null
                        ? LanguageConstant.view.tr
                        : LanguageConstant.camera.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    if (fileImage != null) {
                      imagePickerDialog(context);
                      return;
                    }

                    setState(() {
                      profileImagesList = [];
                    });
                    profileImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (profileImagesList.isNotEmpty) {
                      setState(() {
                        profileImage = File(profileImagesList[0].path);
                      });
                    }
                  },
                  child: Text(
                    fileImage != null
                        ? LanguageConstant.change.tr
                        : LanguageConstant.gallery.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18),
                  )),
            ],
          );
        });
  }
}
