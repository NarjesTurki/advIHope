import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/local_notification_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/agora_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'agora.config.dart' as config;

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  const JoinChannelVideo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;

  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  _callEndCheckMethod() {
    if (callEnd == 2) {
      _leaveChannel();
      Get.back();
    }
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _callEndCheckMethod();
    });
    if (Get.find<GeneralController>().callerType == 1) {
      Future.delayed(
        const Duration(seconds: 2),
      ).whenComplete(() => _joinChannel());
    }

    _initEngine();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
    _engine.destroy();
  }

  int? callEnd = 0;

  _initEngine() async {
    _engine =
        await RtcEngine.createWithContext(RtcEngineContext(config.agoraAppId));
    _addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          remoteUid.add(uid);
          callEnd = 1;
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
          if (callEnd == 1) {
            callEnd = 2;
          }
        });
        if (remoteUid.isEmpty) {}
      },
      leaveChannel: (stats) {
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  Future<dynamic> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(
        Get.find<GeneralController>().tokenForCall,
        Get.find<GeneralController>().channelForCall!,
        null,
        Get.find<GeneralController>().callerType);
    _addListeners();
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: _renderVideo(),
        onWillPop: () async {
          return false;
        });
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  bool muted = false;

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : customThemeColor,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? customThemeColor : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _leaveChannel();
              // _onCallEnd(context);
              Get.back();
            },
            child: const Icon(
              Icons.clear,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: const Icon(
              Icons.switch_camera,
              color: customThemeColor,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  _renderVideo() {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: remoteUid.isEmpty && callEnd == 0
            ? Get.find<GeneralController>().callerType == 2
                ? _receiverView()
                : _ringingView()
            : Stack(
                children: [
                  remoteUid.isEmpty
                      ? const SizedBox()
                      : rtc_remote_view.SurfaceView(
                          channelId:
                              Get.find<GeneralController>().channelForCall!,
                          uid: remoteUid[0],
                        ),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: rtc_local_view.SurfaceView(),
                  ),
                  _toolbar()
                ],
              ),
      ),
    );
  }

  _ringingView() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              customThemeColor,
              customLightThemeColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Container(
                height: 130,
                width: 130,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage('assets/Icons/splash_logo.png'))),
              ),
              isJoined
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(0, 27, 0, 0),
                      child: Text(
                        'Ringing',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: SarabunFontFamily.extraBold,
                            color: Colors.white),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.fromLTRB(0, 27, 0, 0),
                      child: Text(
                        'Calling',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: SarabunFontFamily.extraBold,
                            color: Colors.white),
                      ),
                    ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        _leaveChannel();
                        _onCallEnd(context);
                        LocalNotificationService.cancelAllNotifications();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      shape: const CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.redAccent,
                      padding: const EdgeInsets.all(15.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _receiverView() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              customThemeColor,
              customLightThemeColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SvgPicture.asset(
                'assets/images/callAlert.svg',
                width: MediaQuery.of(context).size.width * .6,
              )),
              const Text(
                'Call Alert',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: SarabunFontFamily.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${LanguageConstant.youAreReceivingCallFrom.tr}'
                '${Get.find<GeneralController>().storageBox.read('userRole').toString().toUpperCase() == 'MENTEE' ? 'CONSULTANT' : 'USER'}',
                style: const TextStyle(
                    fontSize: 15,
                    fontFamily: SarabunFontFamily.regular,
                    color: Colors.white),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              LocalNotificationService.cancelAllNotifications();
                              _leaveChannel();
                              Get.back();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 35,
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              LocalNotificationService.cancelAllNotifications();
                              _joinChannel();
                            },
                            child: const CircleAvatar(
                              backgroundColor: customGreenColor,
                              radius: 35,
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CallWaitingView extends StatefulWidget {
  const CallWaitingView({Key? key}) : super(key: key);

  @override
  _CallWaitingViewState createState() => _CallWaitingViewState();
}

class _CallWaitingViewState extends State<CallWaitingView> {
  late final RtcEngine _engine;
  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              customThemeColor,
              customLightThemeColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Get.find<AgoraLogic>().userImage == null
                  ? Container(
                      height: 130,
                      width: 130,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    )
                  : Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(Get.find<AgoraLogic>()
                                      .userImage!
                                      .contains('assets')
                                  ? '$mediaUrl${Get.find<AgoraLogic>().userImage}'
                                  : Get.find<AgoraLogic>().userImage!))),
                    ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 27, 0, 0),
                child: Text(
                  'Calling To',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: SarabunFontFamily.extraBold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                child: Text(
                  '${Get.find<AgoraLogic>().userName}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: SarabunFontFamily.regular,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        LocalNotificationService.cancelAllNotifications();
                        _leaveChannel();
                        Get.find<GeneralController>().updateGoForCall(false);

                        Get.back();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      shape: const CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.redAccent,
                      padding: const EdgeInsets.all(15.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
