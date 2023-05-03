import 'dart:developer';
import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ista_app/multi_language/languages.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/local_notification_service.dart';
import 'package:ista_app/src/api_services/logic.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/agora_call/agora_logic.dart';
import 'package:ista_app/src/modules/agora_call/init_video_call_view.dart';
import 'package:ista_app/src/modules/chat/logic.dart';
import 'package:ista_app/src/modules/consultant/create_profile/logic.dart';
import 'package:ista_app/src/modules/consultant/dashboard/repo_post.dart';
import 'package:ista_app/src/modules/main_repo/main_logic.dart';
import 'package:ista_app/src/modules/main_repo/main_repo.dart';
import 'package:ista_app/src/modules/sms/logic.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/consultant_profile/logic.dart';
import 'package:ista_app/src/modules/agora_call/agora.config.dart' as config;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ista_app/src/utils/theme.dart';
import 'package:resize/resize.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");
RtcEngine? _engine;

_initEngine(String? route) async {
  _engine =
      await RtcEngine.createWithContext(RtcEngineContext(config.agoraAppId));

  await _engine!.enableVideo();
  await _engine!.startPreview();
  await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
  await _engine!.setClientRole(ClientRole.Broadcaster);
  Get.toNamed(route!);
}

Future<void> backgroundHandler(RemoteMessage message) async {
  Get.put(GeneralController());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp();
  await GetStorage.init();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      serviceWorkerController.setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          return null;
        },
      ));
    }
  }
  Get.put(GeneralController());
  Get.put(ApiLogic());
  Get.put(AgoraLogic());
  Get.put(SmsLogic());
  Get.put(MainLogic());
  //-----load-configurations-from-local-json
  await GlobalConfiguration().loadFromAsset("configurations");

  runApp(const InitClass());
}

class InitClass extends StatefulWidget {
  const InitClass({Key? key}) : super(key: key);

  @override
  _InitClassState createState() => _InitClassState();
}

class _InitClassState extends State<InitClass> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);

    ///---for-language-check
    Get.find<GeneralController>().checkLanguage();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      String route;

      if (message != null) {
        if (message.data['fee'] != null) {
          Get.find<GeneralController>().notificationMenteeId =
              message.data['mentee_id'];
          Get.find<GeneralController>().notificationFee = message.data['fee'];
          Get.find<GeneralController>().update();
        }
        if (message.data['channel'] != null) {
          Get.find<GeneralController>().updateCallerType(2);

          Get.find<GeneralController>()
              .updateChannelForCall(message.data['channel']);
          Get.find<GeneralController>()
              .updateTokenForCall(message.data['channel_token']);
        }
        if (message.data['routeApp'] != null) {
          route = message.data['routeApp'];
          Get.to(NotificationRoute(
            route: route,
          ));
        }
      }
    });

    ///forground messages
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {}
      String route;
      log('testing it ${message.data}');
      if (message.data['channel'] != null) {
        Get.find<GeneralController>().updateCallerType(2);
        Get.find<GeneralController>()
            .updateChannelForCall(message.data['channel']);
        Get.find<GeneralController>()
            .updateTokenForCall(message.data['channel_token']);
      }
      if (message.data['routeApp'] != null) {
        if (message.data['fee'] != null) {
          Get.find<GeneralController>().notificationMenteeId =
              message.data['mentee_id'];
          Get.find<GeneralController>().notificationFee = message.data['fee'];
          Get.find<GeneralController>().update();
        }
        route = message.data['routeApp'];

        Get.to(NotificationRoute(
          route: route,
        ));
      }
      LocalNotificationService.display(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      String route;
      if (message.data['channel'] != null) {
        Get.find<GeneralController>().updateCallerType(2);
        Get.find<GeneralController>()
            .updateChannelForCall(message.data['channel']);
        Get.find<GeneralController>()
            .updateTokenForCall(message.data['channel_token']);
        if (message.data['routeApp'] != null) {
          if (message.data['fee'] != null) {
            Get.find<GeneralController>().notificationMenteeId =
                message.data['mentee_id'];
            Get.find<GeneralController>().notificationFee = message.data['fee'];
            Get.find<GeneralController>().update();
          }
          route = message.data['routeApp'];
          Get.to(NotificationRoute(
            route: route,
          ));
        }
      } else if (message.data['routeApp'] != null) {
        _initEngine(message.data['routeApp']);
        route = message.data['routeApp'];
      }
    });

    /// Get config Credential

    getMethod(
        context,
        getConfigCredentialUrl,
        {
          'token': 123,
        },
        false,
        getConfigCredentialRepo);

    /// Get General Settings
    getMethod(
        context,
        getGeneralSettingUrl,
        {
          'token': 123,
        },
        false,
        getGeneralSettingRepo);

    /// Get General Settings
    getMethod(
        context,
        getTermsConditionsUrl,
        {
          'token': 123,
        },
        false,
        getTermsConditionsRepo);

    super.initState();
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (Get.find<GeneralController>().storageBox.hasData('userID') &&
        Get.find<GeneralController>().storageBox.hasData('authToken') &&
        !Get.find<GeneralController>().storageBox.hasData('onlineStatus')) {
      switch (state) {
        case AppLifecycleState.resumed:
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id':
                    Get.find<GeneralController>().storageBox.read('userID'),
                'status': 'online'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
        case AppLifecycleState.inactive:
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id':
                    Get.find<GeneralController>().storageBox.read('userID'),
                'status': 'offline'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
        case AppLifecycleState.paused:
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id':
                    Get.find<GeneralController>().storageBox.read('userID'),
                'status': 'offline'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
        case AppLifecycleState.detached:
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id':
                    Get.find<GeneralController>().storageBox.read('userID'),
                'status': 'offline'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return Resize(
        allowtextScaling: true,
        size: const Size(375, 812),
        builder: () {
          Get.put(ChatLogic());
          Get.put(ConsultantProfileLogic());
          Get.put(BookAppointmentLogic());
          Get.put(CreateProfileLogic());
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            translations: LanguagesChang(),
            locale: Locale(
                '${Get.find<GeneralController>().storageBox.read('languageCode')}',
                '${Get.find<GeneralController>().storageBox.read('countryCode')}'),
            fallbackLocale: Locale(
                '${Get.find<GeneralController>().storageBox.read('languageCode')}',
                '${Get.find<GeneralController>().storageBox.read('countryCode')}'),
            initialRoute: PageRoutes.splash,
            getPages: routes(),
            themeMode: ThemeMode.light,
            theme: lightTheme(),
          );
        });
  }
}
