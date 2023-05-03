import 'dart:math' hide log;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ista_app/src/modules/agora_call/agora_logic.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/chat/logic.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/model_file_attachment.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/model_mark_as_complete.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/state.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:resize/resize.dart';

class ConsultantAppointmentDetailLogic extends GetxController {
  final ConsultantAppointmentDetailState state =
      ConsultantAppointmentDetailState();
  String? fileName;
  ModelFileAttachment modelFileAttachment = ModelFileAttachment();
  ConsultantAppointmentsData selectedAppointmentData =
      ConsultantAppointmentsData();
  ModelMarkAsComplete modelMarkAsComplete = ModelMarkAsComplete();

  /// Loader
  bool? formLoaderController = false;

  updateFormLoaderController(bool? newValue) {
    formLoaderController = newValue;
    update();
  }

  int? appointmentStatus;

  List<Color> colorForAppointmentTypes = [
    customOrangeColor,
    customLightThemeColor,
    customGreenColor,
    customRedColor,
    customTextGreyColor
  ];

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

  int showAppointment = 0;
  bool? showAudioCallButton = false;
  bool? showVideoCallButton = false;

  Future<int> getAudioDifference() async {
    String time1 = DateTime.now().toString().substring(11, 19);
    log('This is first.....$time1');
    String time2 = intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse(
        '${selectedAppointmentData.time.toString().substring(0, 5)}'
        '${selectedAppointmentData.time.toString().substring(5, 8).toUpperCase()}'));
    log('This is second.....$time2');
    String time3 = intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse(
        '${selectedAppointmentData.endTime.toString().substring(0, 5)}'
        '${selectedAppointmentData.endTime.toString().substring(5, 8).toUpperCase()}'));

    log('last time ${selectedAppointmentData.endTime}');
    log('This is third.....$time3');

    intl.DateFormat dateFormat = intl.DateFormat("yyyy-MM-dd");

    var _date = dateFormat.format(DateTime.now());

    DateTime a = DateTime.parse('$_date $time1');
    DateTime b = DateTime.parse('${selectedAppointmentData.date} $time2');
    DateTime endDateTime =
        DateTime.parse('${selectedAppointmentData.date} $time3');

    if ((b.difference(a).inMinutes <= 2) &&
        DateTime.now().isBefore(endDateTime)) {
      showAudioCallButton = true;
      showAppointment = selectedAppointmentData.id!;
      update();
    } else {
      showAudioCallButton = false;

      update();
    }
    log('difference.........${b.difference(a).inMinutes}');
    return b.difference(a).inMinutes;
  }

  Future<int> getVideoDifference() async {
    String time1 = DateTime.now().toString().substring(11, 19);
    log('This is first.....$time1');
    String time2 = intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse(
        '${selectedAppointmentData.time.toString().substring(0, 5)}'
        '${selectedAppointmentData.time.toString().substring(5, 8).toUpperCase()}'));
    log('This is second.....$time2');
    String time3 = intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse(
        '${selectedAppointmentData.endTime.toString().substring(0, 5)}'
        '${selectedAppointmentData.endTime.toString().substring(5, 8).toUpperCase()}'));
    log('last time ${selectedAppointmentData.endTime}');
    log('This is third.....$time3');

    intl.DateFormat dateFormat = intl.DateFormat("yyyy-MM-dd");

    var _date = dateFormat.format(DateTime.now());

    DateTime a = DateTime.parse('$_date $time1');
    DateTime b = DateTime.parse('${selectedAppointmentData.date} $time2');
    DateTime endDateTime =
        DateTime.parse('${selectedAppointmentData.date} $time3');

    if ((b.difference(a).inMinutes <= 2) &&
        DateTime.now().isBefore(endDateTime)) {
      showAppointment = selectedAppointmentData.id!;
      showVideoCallButton = true;
      update();
    } else {
      showVideoCallButton = false;

      update();
    }
    log('difference.........${b.difference(a).inMinutes}');
    return b.difference(a).inMinutes;
  }

  ///

  chatOnTap(BuildContext context) {
    Get.find<ChatLogic>().userName =
        '${selectedAppointmentData.mentee!.firstName} '
        '${selectedAppointmentData.mentee!.lastName}';
    Get.find<ChatLogic>().userEmail = selectedAppointmentData.mentee!.email;
    Get.find<ChatLogic>().userImage = selectedAppointmentData.mentee!.imagePath;
    Get.find<ChatLogic>().updateGetMessagesLoader(true);
    Get.find<ChatLogic>().updateSenderMessageGetId(
        Get.find<GeneralController>().storageBox.read('userID'));
    Get.find<ChatLogic>()
        .updateReceiverMessageGetId(selectedAppointmentData.menteeId);
    Get.toNamed(PageRoutes.chatScreen);
  }

  videoOnTap(BuildContext context) {
    Get.find<AgoraLogic>().userName =
        '${selectedAppointmentData.mentee!.firstName} '
        '${selectedAppointmentData.mentee!.lastName}';
    Get.find<AgoraLogic>().userImage =
        selectedAppointmentData.mentee!.imagePath;
    Get.find<AgoraLogic>().update();
    Get.find<GeneralController>().updateSelectedChannel(
        Get.find<GeneralController>().getRandomString(10));
    Get.find<GeneralController>()
        .updateChannelForCall(Get.find<GeneralController>().selectedChannel);
    getMethod(
        context,
        agoraTokenUrl,
        {
          'token': '123',
          'channel': Get.find<GeneralController>().selectedChannel
        },
        true,
        getAgoraTokenRepo);
    Get.find<GeneralController>().updateGoForCall(true);
    Get.toNamed(PageRoutes.videoCallWaiting);
  }

  audioOnTap(BuildContext context) {
    Get.find<AgoraLogic>().userName =
        '${selectedAppointmentData.mentee!.firstName} '
        '${selectedAppointmentData.mentee!.lastName}';
    Get.find<AgoraLogic>().userImage =
        selectedAppointmentData.mentee!.imagePath;
    Get.find<AgoraLogic>().update();
    Get.find<GeneralController>().updateSelectedChannel(
        Get.find<GeneralController>().getRandomString(10));
    Get.find<GeneralController>()
        .updateChannelForCall(Get.find<GeneralController>().selectedChannel);
    getMethod(
        context,
        agoraTokenUrl,
        {
          'token': '123',
          'channel': Get.find<GeneralController>().selectedChannel
        },
        true,
        getAgoraTokenForAudioRepo);
    Get.find<GeneralController>().updateGoForCall(true);
    Get.toNamed(PageRoutes.videoCallWaiting);
  }
}
