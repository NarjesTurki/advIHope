import 'package:get/get.dart';
import 'package:ista_app/src/modules/main_repo/main_logic.dart';

/// Get your own App  ID at https://dashboard.agora.io/
final String agoraAppId =
    '${(Get.find<MainLogic>().getConfigCredentialModel.data!.agora![0].value).toString()}';
