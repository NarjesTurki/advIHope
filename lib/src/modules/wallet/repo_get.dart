import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/wallet/logic.dart';
import 'package:ista_app/src/modules/wallet/model_get_all_transaction.dart';
import 'package:ista_app/src/modules/wallet/model_get_wallet_balance.dart';

getWalletBalanceRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<WalletLogic>().getWalletBalanceModel =
        GetWalletBalanceModel.fromJson(response);

    Get.find<WalletLogic>().updateGetWalletBalanceLoader(false);

    if (Get.find<WalletLogic>().getWalletBalanceModel.status == true) {
      Get.find<WalletLogic>().getWalletBalanceModel.data;
    } else {}
  } else if (!responseCheck) {
    Get.find<WalletLogic>().updateGetWalletBalanceLoader(false);
  }
}

getWalletTransactionRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<WalletLogic>().getAllTransactionModel =
        GetAllTransactionModel.fromJson(response);

    if (Get.find<WalletLogic>().getAllTransactionModel.status == true) {
      Get.find<WalletLogic>().emptyGetAllTransactionList();
      if (Get.find<WalletLogic>()
          .getAllTransactionModel
          .data!
          .transactions!
          .isNotEmpty) {
        for (var element in Get.find<WalletLogic>()
            .getAllTransactionModel
            .data!
            .transactions!) {
          Get.find<WalletLogic>().updateGetAllTransactionList(element);
        }
        Get.find<WalletLogic>().updateGetAllTransactionLoader(false);
      } else {
        Get.find<WalletLogic>().updateGetAllTransactionLoader(false);
      }
    } else {
      Get.find<WalletLogic>().updateGetAllTransactionLoader(false);
    }
    Get.find<WalletLogic>().updateRefreshController();
  } else if (!responseCheck) {
    Get.find<WalletLogic>().updateRefreshController();

    Get.find<WalletLogic>().updateGetAllTransactionLoader(false);
  }
}
