import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/user/book_appointment/easy_paisa_payment/easy_paisa_payment_repo.dart';
import 'package:ista_app/src/modules/user/book_appointment/logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_app_bar.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentEasyPaisaView extends StatefulWidget {
  const PaymentEasyPaisaView({Key? key}) : super(key: key);

  @override
  _PaymentEasyPaisaViewState createState() => _PaymentEasyPaisaViewState();
}

class _PaymentEasyPaisaViewState extends State<PaymentEasyPaisaView>
    with TickerProviderStateMixin {
  final logic = Get.put(BookAppointmentLogic());
  final state = Get.find<BookAppointmentLogic>().state;

  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  final GlobalKey<FormState> _paymentFormKey = GlobalKey();

  AnimationController? slidAbleAnimationController1;
  AnimationController? slidAbleAnimationController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slidAbleAnimationController1 = AnimationController.unbounded(vsync: this);
    slidAbleAnimationController2 = AnimationController.unbounded(vsync: this);
    _init();
  }

  Future<void> _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? debugPrint('This device can vibrate')
          : debugPrint('This device cannot vibrate');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    slidAbleAnimationController1!.dispose();
    slidAbleAnimationController2!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<BookAppointmentLogic>(
        builder: (_bookAppointmentLogicController) =>
            GetBuilder<GeneralController>(builder: (_generalController) {
          return ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            inAsyncCall: _generalController.formLoaderController,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: const MyCustomAppBar(
                    drawerShow: false, whiteBackground: true),
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Form(
                      key: _paymentFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///---fee-section
                          Container(
                            height: 52,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: customThemeColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  // Expanded(
                                  //   child: Align(
                                  //     alignment: _generalController.isDirectionRTL(context) ? Alignment.centerRight : Alignment.centerLeft,
                                  //     // child: Text(
                                  //     //   '${'you_will_be_charge'.tr}:',
                                  //     //   style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                  //     // ),
                                  //   ),
                                  // ),
                                  Center(
                                    child: Text(
                                      // '${'rs'.tr}. ${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}',
                                      'No Transaction Available',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          // ///---heading
                          // Text(
                          //   'Enter Easypaisa Details',
                          //   style: state.subHeadingTextStyle,
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          //
                          // ///---easy pesa-number-field
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: const Color(0xffF4F6FB),
                          //       borderRadius: BorderRadius.circular(7)),
                          //   child: Padding(
                          //     padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                          //     child: Column(
                          //       children: [
                          //         ///---number-field
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Text('Account No',
                          //                     style:
                          //                     state.textFieldLabelTextStyle),
                          //               ],
                          //             ),
                          //             TextFormField(
                          //               inputFormatters: [
                          //                 LengthLimitingTextInputFormatter(13),
                          //                 FilteringTextInputFormatter.allow(
                          //                     RegExp("[0-9]"))
                          //               ],
                          //               style: state.textFieldTextStyle,
                          //               controller:
                          //               _bookAppointmentLogicController
                          //                   .jazzCashCnicTextController,
                          //               keyboardType: TextInputType.number,
                          //               decoration: const InputDecoration(
                          //                 isDense: true,
                          //                 filled: true,
                          //                 fillColor: Color(0xffF4F6FB),
                          //                 contentPadding: EdgeInsets.symmetric(
                          //                     vertical: 10.0, horizontal: 0.0),
                          //                 focusedBorder: UnderlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: customThemeColor)),
                          //                 errorBorder: UnderlineInputBorder(
                          //                     borderSide:
                          //                     BorderSide(color: Colors.red)),
                          //                 enabledBorder: UnderlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Color(0xffDEE8EE))),
                          //                 border: UnderlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Color(0xffDEE8EE))),
                          //               ),
                          //               validator: (String? value) {
                          //                 if (value!.isEmpty) {
                          //                   return 'field_required'.tr;
                          //                 } else {
                          //                   return null;
                          //                 }
                          //               },
                          //             ),
                          //           ],
                          //         ),
                          //         const SizedBox(
                          //           height: 20,
                          //         ),
                          //
                          //         ///---email-field
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Text('Email',
                          //                     style:
                          //                     state.textFieldLabelTextStyle),
                          //               ],
                          //             ),
                          //             TextFormField(
                          //
                          //               style: state.textFieldTextStyle,
                          //               controller:
                          //               _bookAppointmentLogicController
                          //                   .paymentAccountNumberTextController,
                          //               keyboardType: TextInputType.emailAddress,
                          //
                          //               decoration: const InputDecoration(
                          //                 isDense: true,
                          //                 filled: true,
                          //                 fillColor: Color(0xffF4F6FB),
                          //                 contentPadding: EdgeInsets.symmetric(
                          //                     vertical: 10.0, horizontal: 0.0),
                          //                 focusedBorder: UnderlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: customThemeColor)),
                          //                 errorBorder: UnderlineInputBorder(
                          //                     borderSide:
                          //                     BorderSide(color: Colors.red)),
                          //                 enabledBorder: UnderlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Color(0xffDEE8EE))),
                          //                 border: UnderlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Color(0xffDEE8EE))),
                          //               ),
                          //               validator: (String? value) {
                          //                 if (value!.isEmpty) {
                          //                   return 'field_required'.tr;
                          //                 }else if(!GetUtils.isEmail(value)){
                          //                   return 'Provide Valid Email!';
                          //                 } else {
                          //                   return null;
                          //                 }
                          //               },
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          const Spacer(),

                          ///---button
                          // Center(
                          //   child: SlidableButton(
                          //     controller: slidAbleAnimationController1,
                          //     dismissible: true,
                          //     initialPosition: SlidableButtonPosition.left,
                          //     width: MediaQuery.of(context).size.width * .55,
                          //     height: 60,
                          //     buttonWidth: 50.0,
                          //     buttonColor: customThemeColor,
                          //     color: const Color(0xffF6F7FC),
                          //     label: const Icon(
                          //       Icons.logout,
                          //       color: Colors.white,
                          //       size: 30,
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                          //       child: Row(
                          //         children: [
                          //           Expanded(
                          //             child: Align(
                          //               alignment: Alignment.centerRight,
                          //               child: Text(
                          //                 'slide_pay_later'.tr,
                          //                 softWrap: true,
                          //                 overflow: TextOverflow.ellipsis,
                          //                 style: state.sliderTextStyle,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     onChanged: (position) {
                          //       setState(() {
                          //         if (position == SlidableButtonPosition.right) {
                          //           Future.delayed(
                          //               const Duration(milliseconds: 250))
                          //               .whenComplete(() =>
                          //           slidAbleAnimationController1!.value =
                          //           0.0);
                          //           if (_canVibrate) {
                          //             log('vibrate hooooo');
                          //             Vibrate.feedback(FeedbackType.heavy);
                          //           }
                          //         } else {}
                          //       });
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 50,
                          // ),

                          // ///---button
                          // Center(
                          //   child: SlidableButton(
                          //     controller: slidAbleAnimationController2,
                          //     dismissible: true,
                          //     initialPosition: SlidableButtonPosition.left,
                          //     width: MediaQuery.of(context).size.width * .55,
                          //     height: 60,
                          //     buttonWidth: 50.0,
                          //     buttonColor: customThemeColor,
                          //     color: const Color(0xffF6F7FC),
                          //     label: const Icon(
                          //       Icons.logout,
                          //       color: Colors.white,
                          //       size: 30,
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                          //       child: Row(
                          //         children: [
                          //           Expanded(
                          //             child: Align(
                          //               alignment: Alignment.centerRight,
                          //               child: Text(
                          //                 'slide_pay_now'.tr,
                          //                 style: state.sliderTextStyle,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     onChanged: (position) {
                          //       setState(() {
                          //         if (position == SlidableButtonPosition.right) {
                          //           Future.delayed(
                          //               const Duration(milliseconds: 250))
                          //               .whenComplete(() =>
                          //           slidAbleAnimationController2!.value =
                          //           0.0);
                          //           setState(() {});
                          //           if (_canVibrate) {
                          //             log('vibrate hooooo');
                          //             Vibrate.feedback(FeedbackType.heavy);
                          //           }
                          //           log('InitialUrl ${paymentBaseUrl}easypaisa?'
                          //           'amount=${Get.find<SingleCategoryMentorListPageLogic>().selectMentorAppointmentType!.fee}&'
                          //               'bookAppointmentId=${Get.find<BookAppointmentLogic>().bookAppointmentModel.data!.appointmentNo}');
                          //           Get.to(InAppWebViewExampleScreen());
                          //         } else {}
                          //       });
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 50,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: InkWell(
                  onTap: () {
                    if (_canVibrate) {
                      log('vibrate');
                      Vibrate.feedback(FeedbackType.heavy);
                    }
                    log('InitialUrl ${baseUrl}easypaisa?'
                        'amount=${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}&'
                        'bookAppointmentId=${Get.find<BookAppointmentLogic>().bookAppointmentModel.data!.appointmentNo}');
                    Get.to(const InAppWebViewExampleScreen());
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.w, 0, 20.w, 0),
                    child: MyCustomBottomBar(
                      title: LanguageConstant.continueText.tr,
                      disable: false,
                    ),
                  ),
                )),
          );
        }),
      ),
    );
  }
}

class InAppWebViewExampleScreen extends StatefulWidget {
  const InAppWebViewExampleScreen({super.key});

  @override
  _InAppWebViewExampleScreenState createState() =>
      _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              // contextMenu: contextMenu,
              initialUrlRequest: URLRequest(
                url: Uri.parse("${baseUrl}easypaisa?"
                    "amount=${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}&"
                    "bookAppointmentId=${Get.find<BookAppointmentLogic>().bookAppointmentModel.data!.appointmentNo}"),
              ),
              // initialFile: "assets/index.html",
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                  if (await canLaunch(url)) {
                    // Launch the App
                    await launch(
                      url,
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }

                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
                debugPrint('URL--->>> ${url.toString()}');
                if (url.toString().contains("easypaisa-after-payment")) {
                  // get your token from url
                  // Navigator.pop(scaffoldKey.currentContext); // No need of this
                  // Navigator.pushReplacement(scaffoldKey.currentContext,
                  //     MaterialPageRoute(builder: (context) => DD()));
                  Future.delayed(const Duration(seconds: 4)).whenComplete(() {
                    getMethod(
                        context,
                        getAppointmentPaymentStatusUrl,
                        {
                          'token': '123',
                          'bookAppointmentId': Get.find<BookAppointmentLogic>()
                              .bookAppointmentModel
                              .data!
                              .appointmentNo
                        },
                        true,
                        easyPaisaPaymentRepo);
                    Get.find<GeneralController>()
                        .updateFormLoaderController(true);
                    Get.back();
                  });
                }
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ],
        ),
      ),
    ])));
  }
}
