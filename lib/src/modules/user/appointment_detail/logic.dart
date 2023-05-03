import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/route_generator.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/chat/logic.dart';
import 'package:ista_app/src/modules/user/appointment_detail/payment/model_stripe_payment.dart';
import 'package:ista_app/src/modules/user/appointment_detail/state.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/modules/user/my_appointment/model_get_user_appointment.dart';
import 'package:ista_app/src/modules/user/rating/rating_existance_model.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:resize/resize.dart';

class AppointmentDetailLogic extends GetxController {
  final AppointmentDetailState state = AppointmentDetailState();

  UserAppointmentsData selectedAppointmentData = UserAppointmentsData();
  int? appointmentStatus;

  List<Color> colorForAppointmentTypes = [
    customOrangeColor,
    customLightThemeColor,
    customGreenColor,
    customRedColor,
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

  chatOnTap(BuildContext context) {
    Get.find<ChatLogic>().userName =
        '${selectedAppointmentData.mentor!.firstName} '
        '${selectedAppointmentData.mentor!.lastName}';
    Get.find<ChatLogic>().userEmail = selectedAppointmentData.mentor!.email;
    Get.find<ChatLogic>().userImage = selectedAppointmentData.mentor!.imagePath;
    Get.find<ChatLogic>().updateGetMessagesLoader(true);
    Get.find<ChatLogic>().updateSenderMessageGetId(
        Get.find<GeneralController>().storageBox.read('userID'));
    Get.find<ChatLogic>()
        .updateReceiverMessageGetId(selectedAppointmentData.mentorId);
    Get.toNamed(PageRoutes.chatScreen);
  }

  RatingExistModel ratingExistModel = RatingExistModel();
  bool? getRatingDataController = true;

  updateGetRatingDataController(bool value) {
    getRatingDataController = value;
    update();
  }

  bool? isRated = false;

  ScrollController? scrollControllerStripe;
  bool lastStatusStripe = true;
  double heightStripe = 100.h;

  bool get isShrinkStripe {
    return scrollControllerStripe!.hasClients &&
        scrollControllerStripe!.offset > (heightStripe - kToolbarHeight);
  }

  void scrollListenerStripe() {
    if (isShrinkStripe != lastStatusStripe) {
      lastStatusStripe = isShrinkStripe;
      update();
    }
  }

  ModelStripePayment modelStripePayment = ModelStripePayment();
  TextEditingController amountController = TextEditingController();

  double myWidth = 0;
  TextEditingController accountCardNumberController = TextEditingController();
  TextEditingController stripeAmountController = TextEditingController();
  TextEditingController accountCardHolderNameController =
      TextEditingController();
  TextEditingController accountCardExpiresController = TextEditingController();
  TextEditingController accountCardCvcController = TextEditingController();

  var cardNumberMask = MaskTextInputFormatter(mask: '#### #### #### ####');
  var cardExpiryMask = MaskTextInputFormatter(mask: '##/##');
  int? selectedPaymentType;
  List<ShiftType> paymentMethodList = [
    ShiftType(
        title: 'stripe', image: 'assets/Icons/stripe.svg', isSelected: false),
    ShiftType(
        title: 'braintree',
        image: 'assets/Icons/braintreePayment.svg',
        isSelected: false),
    ShiftType(
        title: 'paypal',
        image: 'assets/Icons/paypalPayment.svg',
        isSelected: false),
  ];

  /// Measure Time for Reschedule Appointment
  bool? showRescheduleBtn = false;
  // Future<int> getRescheduleBtn() async {
  //   String time1 = DateTime.now().toString().substring(11, 19);
  //   log('This is first.....$time1');
  //   String time2 =
  //       intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse('${selectedAppointmentData.time.toString().substring(0, 5)}'
  //           '${selectedAppointmentData.time.toString().substring(5, 8).toUpperCase()}'));
  //   log('This is second.....$time2');
  //   String time3 = intl.DateFormat.Hms()
  //       .format(intl.DateFormat('h:mm a').parse('${selectedAppointmentData.endTime.toString().substring(0, 5)}'
  //           '${selectedAppointmentData.endTime.toString().substring(5, 8).toUpperCase()}'));
  //   log('last time ${selectedAppointmentData.endTime}');
  //   log('This is third.....$time3');
  //
  //   intl.DateFormat dateFormat = intl.DateFormat("yyyy-MM-dd");
  //
  //   var _date = dateFormat.format(DateTime.now());
  //
  //   DateTime a = DateTime.parse('$_date $time1');
  //   DateTime b = DateTime.parse('${selectedAppointmentData.date} $time2');
  //   DateTime endDateTime = DateTime.parse('${selectedAppointmentData.date} $time3');
  //
  //   if ((b.difference(a).inMinutes <= 2) && DateTime.now().isBefore(endDateTime)) {
  //     showRescheduleBtn = true;
  //     //  showAppointment = selectedAppointmentData.id!;
  //     update();
  //   } else {
  //     showRescheduleBtn = false;
  //
  //     update();
  //   }
  //   log('difference.........${b.difference(a).inMinutes}');
  //   return b.difference(a).inMinutes;
  // }
}
