import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/consultant/schedule_info/logic.dart';
import 'package:ista_app/src/modules/user/appointment_detail/payment/model_stripe_payment.dart';
import 'package:ista_app/src/modules/wallet/model_deposit_wallet.dart';
import 'package:ista_app/src/modules/wallet/model_get_all_transaction.dart';
import 'package:ista_app/src/modules/wallet/model_get_wallet_balance.dart';
import 'package:ista_app/src/modules/wallet/state.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resize/resize.dart';

class WalletLogic extends GetxController {
  final WalletState state = WalletState();

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

  ScrollController? scrollController2;
  bool lastStatus2 = true;
  double height2 = 100.h;

  bool get isShrink2 {
    return scrollController2!.hasClients &&
        scrollController2!.offset > (height2 - kToolbarHeight);
  }

  void scrollListener2() {
    if (isShrink2 != lastStatus2) {
      lastStatus2 = isShrink2;
      update();
    }
  }

  GetWalletBalanceModel getWalletBalanceModel = GetWalletBalanceModel();
  GetAllTransactionModel getAllTransactionModel = GetAllTransactionModel();
  DepositWalletModel depositWalletModel = DepositWalletModel();

  TextEditingController amountController = TextEditingController();
  TextEditingController stripeAmountController = TextEditingController();
  TextEditingController easypaisaAmountController = TextEditingController();
  TextEditingController withdrawAmountController = TextEditingController();
  TextEditingController jazzCashCnicTextController = TextEditingController();
  TextEditingController paymentAccountNumberTextController =
      TextEditingController();

  final RefreshController refreshAppointmentsController =
      RefreshController(initialRefresh: false);

  updateRefreshController() {
    refreshAppointmentsController.refreshCompleted();
    update();
  }

  bool? getWalletBalanceLoader = true;

  updateGetWalletBalanceLoader(bool? newValue) {
    getWalletBalanceLoader = newValue;
    update();
  }

  bool? getAllTransactionLoader = true;

  updateGetAllTransactionLoader(bool? newValue) {
    getAllTransactionLoader = newValue;
    update();
  }

  bool? getAllTransactionMoreLoader = false;

  updateGetAllTransactionMoreLoader(bool? newValue) {
    getAllTransactionMoreLoader = newValue;
    update();
  }

  List<TransactionsModel> getAllTransactionList = [];

  updateGetAllTransactionList(TransactionsModel transactionsModel) {
    getAllTransactionList.add(transactionsModel);
    update();
  }

  emptyGetAllTransactionList() {
    getAllTransactionList = [];
    update();
  }

  ModelStripePayment modelStripePayment = ModelStripePayment();

  double myWidth = 0;
  TextEditingController accountCardNumberController = TextEditingController();
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
}
