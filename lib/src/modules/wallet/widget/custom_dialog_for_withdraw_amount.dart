import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/wallet/logic.dart';
import 'package:ista_app/src/modules/wallet/repo_post.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';

GlobalKey<FormState> withdrawAmountFormKey = GlobalKey();
String? selectedOption;
customDialogForWithdrawAmount(BuildContext context) {
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
              child: Form(
                key: withdrawAmountFormKey,
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
                              LanguageConstant.withdrawRequest.tr,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(
                                fontFamily: SarabunFontFamily.regular,
                                fontSize: 16,
                                color: Colors.black),
                            controller: Get.find<WalletLogic>()
                                .withdrawAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      25, 15, 25, 15),
                              hintText: LanguageConstant.addAmount.tr,
                              hintStyle: const TextStyle(
                                  fontFamily: SarabunFontFamily.regular,
                                  fontSize: 16,
                                  color: customTextGreyColor),
                              fillColor: customTextFieldColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: customLightThemeColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return LanguageConstant.fieldRequired.tr;
                              } else if (int.parse(Get.find<WalletLogic>()
                                      .withdrawAmountController
                                      .text
                                      .toString()) >
                                  int.parse(Get.find<WalletLogic>()
                                      .getWalletBalanceModel
                                      .data!
                                      .userBalance!)) {
                                return LanguageConstant
                                    .youDoNotHaveSufficientBalance.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                              height: 16), // Espacement entre les deux champs
                          DropdownButtonFormField<String>(
                            value:
                                selectedOption, // Remplacer "selectedOption" par la valeur sélectionnée dans la liste
                            onChanged: (value) {
                              // Modifier cette méthode pour gérer le changement de valeur
                              /*setState(() {
                                selectedOption = value;
                              }  );*/
                            },
                            items: <String>[
                              'PayPal',
                              'Bank transfer',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      25, 15, 25, 15),
                              hintText:
                                  'Select type of transfer', // Remplacer par le texte d'invite pour la liste déroulante
                              hintStyle: const TextStyle(
                                  fontFamily: SarabunFontFamily.regular,
                                  fontSize: 16,
                                  color: customTextGreyColor),
                              fillColor: customTextFieldColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: customLightThemeColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              LanguageConstant.cancel.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: customThemeColor),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (withdrawAmountFormKey.currentState!
                                  .validate()) {
                                Navigator.pop(context);
                                Get.find<GeneralController>()
                                    .updateFormLoaderController(true);
                                postMethod(
                                    context,
                                    walletWithdrawUrl,
                                    {
                                      'token': '123',
                                      'user_id': Get.find<GeneralController>()
                                          .storageBox
                                          .read('userID'),
                                      'amount': Get.find<WalletLogic>()
                                          .withdrawAmountController
                                          .text
                                    },
                                    true,
                                    withdrawTransactionRepo);
                              }
                            },
                            child: Text(
                              LanguageConstant.submit.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: customThemeColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}
