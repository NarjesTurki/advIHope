import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/home/get_repo.dart';
import 'package:ista_app/src/modules/user/home/logic.dart';
import 'package:ista_app/src/modules/user/home/widgets/categories.dart';
import 'package:ista_app/src/modules/user/home/widgets/top_consultants.dart';
import 'package:ista_app/src/modules/user/home/widgets/top_rated_consultant.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/notification_icon.dart';
import 'package:resize/resize.dart';
//import 'package:resize/resize.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final logic = Get.put(UserHomeLogic());

  final state = Get.find<UserHomeLogic>().state;

  @override
  void initState() {
    super.initState();
    if (Get.find<GeneralController>().storageBox.hasData('userID')) {
      Get.find<GeneralController>().updateFcmToken(context);

      ///---get-user-API-call
      getMethod(
          context,
          getMenteeProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
    }

    ///---featured-API-call
    getMethod(context, getFeaturedURL, {'token': '123'}, false,
        getFeaturedConsultantRepo);

    ///---categories-API-call
    getMethod(
        context, getCategoriesURL, {'token': '123'}, false, getCategoriesRepo);

    ///---top-rated-API-call
    getMethod(context, getTopRatedConsultantURL, {'token': '123'}, false,
        getTopRatedConsultantRepo);

    Get.find<UserHomeLogic>().scrollController = ScrollController()
      ..addListener(Get.find<UserHomeLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<UserHomeLogic>()
        .scrollController!
        .removeListener(Get.find<UserHomeLogic>().scrollListener);
    Get.find<UserHomeLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                controller: _userHomeLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .35,
                      floating: false,
                      pinned: true,
                      snap: false,
                      elevation: 1,
                      backgroundColor: _userHomeLogic.isShrink
                          ? customThemeColor
                          : Colors.white,
                      leading: InkWell(
                        onTap: () {
                          Get.toNamed(PageRoutes.userDrawer);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              child: SvgPicture.asset(
                                  'assets/Icons/drawerIcon.svg'),
                            ),
                          ],
                        ),
                      ),
                      actions: const [
                        ///---notifications
                        CustomNotificationIcon(
                          color: Colors.white,
                        )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/images/homeBackground.svg',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.fill,
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 20, 16, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      LanguageConstant.findYour.tr,
                                      style: const TextStyle(
                                          fontFamily: SarabunFontFamily.medium,
                                          fontSize: 17,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(LanguageConstant.mentor.tr,
                                        style: TextStyle(
                                            fontFamily: SarabunFontFamily.bold,
                                            fontSize: 28.sp,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    ///---search-field
                                    TextFormField(
                                      onTap: () {
                                        Get.toNamed(
                                            PageRoutes.searchConsultant);
                                      },
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsetsDirectional
                                                .fromSTEB(15, 15, 15, 15),
                                        suffixIcon: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/Icons/searchIcon.svg'),
                                          ],
                                        ),
                                        hintText:
                                            LanguageConstant.searchHere.tr,
                                        hintStyle: const TextStyle(
                                            fontFamily:
                                                SarabunFontFamily.medium,
                                            fontSize: 14,
                                            color: Color(0xffA3A7AA)),
                                        fillColor: customTextFieldColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            borderSide: const BorderSide(
                                                color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant
                                              .fieldRequired.tr;
                                        } else if (!GetUtils.isEmail(value)) {
                                          return LanguageConstant
                                              .enterValidEmail.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: ListView(
                    padding: const EdgeInsets.only(top: 0),
                    children: const [
                      ///---top-consultants
                      TopConsultants(),

                      ///---categories
                      CategoriesWidget(),

                      ///---top-rated-consultant
                      TopRatedConsultants(),
                    ])),
          ),
        );
      });
    });
  }
}
