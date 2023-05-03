import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/consultant_drawer/state.dart';
import 'package:ista_app/src/modules/user/user_drawer/logic.dart';

class ConsultantDrawerLogic extends GetxController {
  final ConsultantDrawerState state = ConsultantDrawerState();

  List<DrawerTile> drawerList = [
    DrawerTile(
        title: LanguageConstant.home.tr,
        icon: 'assets/Icons/drawerHomeIcon.svg'),
    DrawerTile(
        title: LanguageConstant.appointmentLogs.tr,
        icon: 'assets/Icons/agenda.svg'),
    DrawerTile(
        title: LanguageConstant.editProfile.tr,
        icon: 'assets/Icons/editProfile.svg'),
    DrawerTile(
        title: LanguageConstant.mySchedule.tr,
        icon: 'assets/Icons/drawerAppointmentIcon.svg'),
    DrawerTile(
        title: LanguageConstant.myWallet.tr, icon: 'assets/Icons/feeIcon.svg'),
    DrawerTile(
        title: LanguageConstant.contactUs.tr,
        icon: 'assets/Icons/drawerContactUsIcon.svg'),
    //ENA  DrawerTile(title: "My Blogs".tr, icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: LanguageConstant.blogs.tr,
        icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: LanguageConstant.aboutUs.tr,
        icon: 'assets/Icons/drawerPrivacyIcon.svg'),
    DrawerTile(title: 'Languages', icon: 'assets/Icons/language.svg'),
    DrawerTile(
        title: LanguageConstant.logout.tr,
        icon: 'assets/Icons/drawerLogoutIcon.svg'),
  ];

  consultantDrawerNavigation(
    int? index,
    BuildContext context,
  ) {
    switch (index) {
      case 0:
        {
          return Get.back();
        }
      case 1:
        {
          Get.back();
          return Get.toNamed(PageRoutes.consultantAllAppointment);
        }
      case 2:
        {
          Get.back();
          return Get.toNamed(PageRoutes.editConsultantProfile);
        }
      case 3:
        {
          Get.back();
          return Get.toNamed(PageRoutes.scheduleCreate);
        }
      case 4:
        {
          Get.back();
          return Get.toNamed(PageRoutes.walletScreen);
        }
      case 5:
        {
          Get.back();
          return Get.toNamed(PageRoutes.contactUs);
        }

      case 6:
        {
          Get.back();
          return Get.toNamed(PageRoutes.blogs);
        }
      case 7:
        {
          Get.back();
          return Get.toNamed(PageRoutes.aboutUs);
        }
      case 8:
        {
          return Get.find<GeneralController>()
              .customDropDownDialogForLocale(context);
        }
      case 9:
        {
          Get.find<GeneralController>().storageBox.remove('userID');
          Get.find<GeneralController>().storageBox.remove('authToken');
          Get.find<GeneralController>().storageBox.remove('onlineStatus');
          Get.find<GeneralController>().storageBox.remove('userRole');
          Get.find<GeneralController>().storageBox.remove('fcmToken');

          return Get.offAllNamed(PageRoutes.userHome);
        }
      default:
        {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          );
        }
    }
  }
}
