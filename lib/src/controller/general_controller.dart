import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/modules/agora_call/get_agora_token_model.dart';
import 'package:ista_app/src/modules/agora_call/get_fcm_token_model.dart';
import 'package:ista_app/src/modules/agora_call/repo.dart';
import 'package:ista_app/src/modules/user_profile/get_user_profile_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:math' as math;

class GeneralController extends GetxController {
  //1.
  GetStorage storageBox = GetStorage();
//2.
  bool isDirectionRTL(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    final bool isRTL = currentDirection == TextDirection.rtl;
    return isRTL;
  }

  ///3.---get-user-profile
  GetConsultantProfileModel getConsultantProfileModel =
      GetConsultantProfileModel();

  bool formLoaderController = false;

  updateFormLoaderController(bool newValue) {
    formLoaderController = newValue;
    update();
  }

  ///4.---appbar-open
  String? appBarSelectedCountryCode = '+92';

  updateAppBarSelectedCountryCode(String? newValue) {
    appBarSelectedCountryCode = newValue;
    update();
  }

  ///---appbar-close

  ///5.--focus-out
  focusOut(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  ///6---random-string-open
  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  math.Random rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
//7.
  String? selectedChannel;

  updateSelectedChannel(String? newValue) {
    selectedChannel = newValue;
    update();
  }

//8.
/**ette portion de code est utilisée pour mettre à jour une variable entière
 *  callerType avec une nouvelle valeur et pour notifier le système qu'une mise à 
 * jour a été effectuée.Cela peut être utilisé pour mettre à jour l'état d'une application
 *  lorsque l'utilisateur sélectionne une option ou un type de caller */
  int callerType = 2;

  updateCallerType(int i) {
    callerType = i;
    update();
  }

//9.getAgoraTokenModel est une instance de la classe GetAgoraTokenModel
  GetAgoraTokenModel getAgoraTokenModel = GetAgoraTokenModel();
//10.mettre à jour une variable booléenne goForCall avec une nouvelle valeur
//et pour notifier le système qu'une mise à jour a été effectuée.
//Cela peut être utilisé pour mettre à jour l'état d'une application lorsque l'utilisateur
//active ou désactive une option ou une fonctionnalité.
//Par exemple, cela peut être utilisé pour activer ou désactiver une fonctionnalité d'appel
  bool? goForCall = true;

  updateGoForCall(bool? newValue) {
    goForCall = newValue;
    update();
  }

//11.ces deux fonctions sont utilisées pour mettre à jour deux variables de chaîne de caractères
//. Cela peut être utilisé pour mettre à jour l'état d'une application lorsqu'un
//utilisateur choisit un canal ou un jeton pour une action spécifique,
// telle qu'un appel vidéo ou audio.
  String? channelForCall;
  String? tokenForCall;

  updateTokenForCall(String? newValueToken) {
    tokenForCall = newValueToken;
    update();
  }

  updateChannelForCall(String? newValueChannel) {
    channelForCall = newValueChannel;
    update();
  }

//12.
  GetFcmTokenModel getFcmTokenModel = GetFcmTokenModel();
//13.
  int? userIdForSendNotification;

  updateUserIdForSendNotification(int? newValue) {
    userIdForSendNotification = newValue;
    update();
  }

//14.
  int? appointmentIdForSendNotification;

  updateAppointmentIdForSendNotification(int? newValue) {
    appointmentIdForSendNotification = newValue;
    update();
  }

//15.Cette fonction peut être utilisée pour mettre à jour
// les propriétés d'une notification push avant de l'envoyer.
  String? notificationTitle;
  String? notificationBody;
  String? notificationRouteApp;
  String? notificationRouteWeb;
  String? sound;

  updateNotificationBody(String? newTitle, String? newBody, String? newRouteApp,
      String? newRouteWeb, String? newSound) {
    notificationTitle = newTitle;
    notificationBody = newBody;
    notificationRouteApp = newRouteApp;
    notificationRouteWeb = newRouteWeb;
    sound = newSound;
    update();
  }

//16.La fonction demande d'abord l'autorisation de l'utilisateur pour
//envoyer des notifications push en appelant la méthode
//requestPermission de l'instance FirebaseMessaging.
//Ensuite, la méthode getToken est appelée pour récupérer le jeton
// d'authentification FCM. Si la méthode getToken réussit, la valeur
// du jeton est stockée dans la variable fcmToken, puis elle est
//également enregistrée dans une boîte de stockage local en utilisant storageBox.write.
//La fonction getId est ensuite appelée pour récupérer l'ID de l'utilisateur actuellement
//connecté. Si la récupération de l'ID est réussie, le jeton d'authentification FCM et l'ID
//de l'utilisateur peuvent être envoyés au serveur pour permettre l'envoi de notifications push à cet utilisateur.
  ///---fcm-token
  String? fcmToken;

  updateFcmToken(BuildContext context) async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value;
      storageBox.write('fcmToken', fcmToken);
      getId(context);
    }).catchError((onError) {});
  }

//17.Cette fonction utilise le package device_info pour obtenir l'ID d'appareil unique
//pour l'appareil de l'utilisateur, puis envoie une requête POST à une URL spécifiée (fcmUpdateUrl)
//avec l'ID d'appareil, l'ID de l'utilisateur et le jeton FCM reçu de Firebase Cloud Messaging.
//La fonction renvoie l'ID de l'appareil sous forme de chaîne. Le but de cette fonction est susceptible,de mettre
//à jour le jeton FCM pour l'appareil de l'utilisateur côté serveur afin que le serveur puisse envoyer des notifications push à l'appareil.
  Future<String?> getId(BuildContext context) async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      // ignore: use_build_context_synchronously
      postMethod(
          context,
          fcmUpdateUrl,
          {
            'token': '123',
            'fcm_token': fcmToken,
            'device_id': iosDeviceInfo.identifierForVendor,
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          false,
          updateFcmTokenRepo);
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // ignore: use_build_context_synchronously
      postMethod(
          context,
          fcmUpdateUrl,
          {
            'token': '123',
            'fcm_token': fcmToken,
            'device_id': androidDeviceInfo.id,
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          false,
          updateFcmTokenRepo);
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  //18.
  List<Language> localeList = [
    Language(1, 'English', '🇺🇸', 'en', 'US'),
    Language(2, 'Français', "🇫🇷", 'fr', 'FR'),
  ];
//19.Il est probable que cette variable selectedLocale est utilisée
//dans votre application pour suivre la langue sélectionnée par l'utilisateur.
//La méthode updateSelectedLocale est probablement appelée chaque fois
//que l'utilisateur sélectionne une langue différente dans votre application.
  Language? selectedLocale;

  updateSelectedLocale(Language? newValue) {
    selectedLocale = newValue;
    update();
  }

//20.cette méthode checkLanguage sert à vérifier si une langue a
// été sélectionnée précédemment et à la récupérer le cas échéant,
//sinon elle initialise la langue par défaut dans la mémoire de stockage et la sélectionne.
  checkLanguage() {
    if (storageBox.hasData('languageIndex')) {
      updateSelectedLocale(
          localeList[int.parse(storageBox.read('languageIndex').toString())]);
    } else {
      storageBox.write('languageCode', localeList[0].languageCode);
      storageBox.write('countryCode', localeList[0].countryCode);
      updateSelectedLocale(localeList[0]);
    }
  }

//21.ffiche une boîte de dialogue pour sélectionner la langue.
  customDropDownDialogForLocale(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 3,
                            blurRadius: 9,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              LanguageConstant.selectLanguage.tr,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: ListView(
                          children: List.generate(localeList.length, (index) {
                            return InkWell(
                              onTap: () {
                                storageBox.write('languageCode',
                                    localeList[index].languageCode);
                                storageBox.write('countryCode',
                                    localeList[index].countryCode);
                                storageBox.write('languageIndex', index);
                                selectedLocale = localeList[index];
                                var locale = Locale(
                                    localeList[index].languageCode,
                                    localeList[index].countryCode);
                                Get.updateLocale(locale);
                                update();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      localeList[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      localeList[index].flag,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  String? inAppWebService;
  String? notificationMenteeId, notificationFee;
}

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  final String countryCode;

  Language(this.id, this.name, this.flag, this.languageCode, this.countryCode);
}
