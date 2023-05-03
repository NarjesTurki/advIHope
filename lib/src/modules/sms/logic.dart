import 'package:get/get.dart';

class SmsLogic extends GetxController {
  String? phoneNumber;
  updatePhoneNumber(String? newValue) {
    phoneNumber = newValue;
    update();
  }
}
