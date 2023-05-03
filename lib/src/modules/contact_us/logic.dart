import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/contact_us/model.dart';
import 'package:ista_app/src/modules/contact_us/state.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsLogic extends GetxController {
  final ContactUsState state = ContactUsState();

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

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

  ContactUsModel contactUsModel = ContactUsModel();

  Future<void> makePhoneCall(String? phoneNumber) async {
    final uri = 'tel:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  sendMail(String? emailId) async {
    final uri = 'mailto:$emailId?subject=Help&body=Hello';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
