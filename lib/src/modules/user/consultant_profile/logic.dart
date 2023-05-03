import 'package:get/get.dart';
import 'package:ista_app/src/modules/user/consultant_profile/get_mentor_profile_for_mentee_model.dart';
import 'package:ista_app/src/modules/user/consultant_profile/model_consultant_profile.dart';
import 'package:ista_app/src/modules/user/consultant_profile/state.dart';

class ConsultantProfileLogic extends GetxController {
  final ConsultantProfileState state = ConsultantProfileState();

  ConsultantProfileModel consultantProfileModel = ConsultantProfileModel();
  bool? consultantProfileLoader = true;

  updateConsultantProfileLoader(bool? newValue) {
    consultantProfileLoader = newValue;
    update();
  }

  GetMentorProfileForMenteeModel getMentorProfileForMenteeModel =
      GetMentorProfileForMenteeModel();

  bool? loader = true;
  updateLoaderForViewProfile(bool? newValue) {
    loader = newValue;
    update();
  }

  List<ScheduleTypes> appointmentTypes = [];
  List imagesForAppointmentTypes = [
    ///---audio
    'assets/Icons/audio.svg',

    ///---video
    'assets/Icons/videoCallIcon.svg',

    ///---chat
    'assets/Icons/chatIcon.svg',

    ///---on-site
    'assets/Icons/physicalIcon.svg',

    ///---home-visit
    'assets/Icons/house-fill.svg',

    ///---Live
    'assets/Icons/live.svg',
  ];
}
