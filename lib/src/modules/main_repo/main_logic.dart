import 'package:get/get.dart';
import 'package:ista_app/src/modules/main_repo/get_config_credential_model.dart';
import 'package:ista_app/src/modules/main_repo/get_general_setting_model.dart';
import 'package:ista_app/src/modules/main_repo/terms_condition_mode.dart';

class MainLogic extends GetxController {
  GetConfigCredentialModel getConfigCredentialModel =
      GetConfigCredentialModel();
  GetGeneralSettingModel getGeneralSettingModel = GetGeneralSettingModel();
  TermsConditionModel termsConditionModel = TermsConditionModel();
}
