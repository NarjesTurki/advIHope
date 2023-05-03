import 'package:get/get.dart';
import 'package:ista_app/src/modules/agora_call/agora_model.dart';

class AgoraLogic extends GetxController {
  AgoraModel agoraModel = AgoraModel();
  AgoraModel agoraModelDefault = AgoraModel();

  String? userName;
  String? userImage;
  final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
}
