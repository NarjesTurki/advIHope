import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/local_notification_service.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'agora.config.dart' as config;

/// JoinChannelAudio Example

class JoinChannelAudio extends StatefulWidget {
  final String? channelId;

  const JoinChannelAudio({Key? key, this.channelId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  late final RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = false,
      playEffect = false;

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
    _initEngine();
    if (Get.find<GeneralController>().callerType == 1) {
      Future.delayed(
        const Duration(seconds: 2),
      ).whenComplete(() => _joinChannel());
    }
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

    await _engine.enableAudio();
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
      leaveChannel: (stats) async {
        setState(() {
          isJoined = false;
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          callEnd = 1;
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          if (callEnd == 1) {
            callEnd = 2;
          }
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine
        .joinChannel(
            Get.find<GeneralController>().tokenForCall,
            Get.find<GeneralController>().channelForCall!,
            null,
            Get.find<GeneralController>().callerType)
        .catchError((onError) {});
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {});
  }

  _switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: callEnd == 0
          ? Get.find<GeneralController>().callerType == 2
              ? _receiverView()
              : _ringingView()
          : Scaffold(
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/Icons/splash_logo.png'))),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ///---mute
                                  InkWell(
                                    onTap: () {
                                      _switchMicrophone();
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: !openMicrophone
                                          ? customThemeColor
                                          : Colors.white,
                                      child: Icon(
                                        openMicrophone
                                            ? Icons.mic
                                            : Icons.mic_off,
                                        color: openMicrophone
                                            ? customThemeColor
                                            : Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),

                                  ///---speaker
                                  InkWell(
                                    onTap: () {
                                      _switchSpeakerphone();
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: enableSpeakerphone
                                          ? customThemeColor
                                          : Colors.white,
                                      child: Icon(
                                        enableSpeakerphone
                                            ? Icons.volume_off
                                            : Icons.volume_up,
                                        color: enableSpeakerphone
                                            ? Colors.white
                                            : customThemeColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  LocalNotificationService
                                      .cancelAllNotifications();
                                  _leaveChannel();
                                  Get.back();
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.call_end,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
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
                        LocalNotificationService.cancelAllNotifications();
                        _leaveChannel();
                        _onCallEnd(context);
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
