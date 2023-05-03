import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/get_service.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/chat/fetch_messages_model.dart';
import 'package:ista_app/src/modules/chat/get_repo.dart';
import 'package:ista_app/src/modules/chat/logic.dart';
import 'package:ista_app/src/modules/chat/post_repo.dart';
import 'package:ista_app/src/modules/main_repo/main_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/utils/constants.dart';
import 'package:ista_app/src/widgets/notification_icon.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final logic = Get.put(ChatLogic());

  final state = Get.find<ChatLogic>().state;

  PusherClient? pusher;
  Channel? channel;
  String responseData = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ChatLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ChatLogic>().scrollListener);
    getMethod(
        context,
        fetchMessagesUrl,
        {
          'token': '123',
          'receiver_id': Get.find<ChatLogic>().receiverMessageGetId,
          'sender_id': Get.find<ChatLogic>().senderMessageGetId
        },
        true,
        fetchMessagesRepo);
    pusher = PusherClient(
      '${Get.find<MainLogic>().getConfigCredentialModel.data!.pusher![0].value}',
      // GlobalConfiguration().get('pusher_appId')
      PusherOptions(
        host: '',
        cluster: 'ap2',
        // if local on android use 10.0.2.2
      ),
    );

    pusher!.onConnectionStateChange((state) {});
    pusher!.onConnectionError((error) {});

    channel = pusher!.subscribe("chat");

    channel!.bind(r'App\Events\MessageSent', (event) {
      setState(() {
        responseData = event!.data.toString();
      });

      Map<String, dynamic> tempMap = jsonDecode(responseData);

      Messages tempChatData = Messages.fromJson(tempMap['message']);
      Get.find<ChatLogic>().updateMessageList(tempChatData);
      // Future.delayed(const Duration(seconds: 1)).whenComplete(() =>
      //     Get.find<ChatLogic>().scrollController!.animateTo(
      //         Get.find<ChatLogic>().scrollController!.position.maxScrollExtent,
      //         curve: Curves.easeOut,
      //         duration: const Duration(milliseconds: 500)));
      Future.delayed(const Duration(seconds: 1)).whenComplete(() =>
          Get.find<ChatLogic>().chatScrollController!.animateTo(
              Get.find<ChatLogic>()
                  .chatScrollController!
                  .position
                  .maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 500)));
      // Timer(
      //     const Duration(seconds: 1),
      //     () => Get.find<ChatLogic>().chatScrollController!.jumpTo(
      //         Get.find<ChatLogic>()
      //             .chatScrollController!
      //             .position
      //             .maxScrollExtent));
    });
  }

  @override
  void dispose() {
    Get.find<ChatLogic>()
        .scrollController!
        .removeListener(Get.find<ChatLogic>().scrollListener);
    Get.find<ChatLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ChatLogic>(builder: (_chatLogic) {
        return GestureDetector(
            onTap: () {
              _generalController.focusOut(context);
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: const Color(0xffFBFBFB),
              body: NestedScrollView(
                controller: _chatLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .28,
                      floating: true,
                      pinned: true,
                      snap: false,
                      elevation: 0,
                      backgroundColor: _chatLogic.isShrink
                          ? customThemeColor
                          : Colors.transparent,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      actions: const [
                        ///---notifications

                        CustomNotificationIcon()
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .30,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.w, 25.h, 16.w, 16.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 25.h,
                                            ),

                                            ///---profile-area
                                            ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              leading: Container(
                                                height: 49.h,
                                                width: 49.w,
                                                decoration: const BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle),
                                                child: _chatLogic.userImage ==
                                                        null
                                                    ? const SizedBox()
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.r),
                                                        child: Image.network(
                                                            _chatLogic
                                                                    .userImage!
                                                                    .contains(
                                                                        'assets')
                                                                ? '$mediaUrl${_chatLogic.userImage}'
                                                                : _chatLogic
                                                                    .userImage!),
                                                      ),
                                              ),

                                              ///---name
                                              title: Text(
                                                '${_chatLogic.userName}',
                                                style: state.userNameTextStyle,
                                              ),

                                              ///---email
                                              subtitle: Text(
                                                '${_chatLogic.userEmail}',
                                                style: state.categoryTextStyle,
                                              ),
                                            ),

                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .03,
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: _chatLogic.getMessagesLoader!
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Wrap(
                            children: List.generate(10, (index) {
                              return SkeletonLoader(
                                period: const Duration(seconds: 2),
                                highlightColor: Colors.grey,
                                direction: SkeletonDirection.ltr,
                                builder: Padding(
                                  padding: index % 2 == 0
                                      ? EdgeInsetsDirectional.fromSTEB(
                                          80.w, 7.h, 15.w, 7.h)
                                      : EdgeInsetsDirectional.fromSTEB(
                                          15.w, 7.h, 80.w, 7.h),
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: index % 2 == 0
                                            ? const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              )
                                            : const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              )),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.all(14.0),
                                      child: Container(
                                        color: Colors.white,
                                        height: 50,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          ///---message-list
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                _chatLogic.fetchMessagesModel.data == null
                                    ? Center(
                                        child: Text(
                                          LanguageConstant.notAvailableYet.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              fontFamily:
                                                  SarabunFontFamily.bold,
                                              color: Colors.black),
                                        ),
                                      )
                                    : Expanded(
                                        child: ListView(
                                        controller:
                                            _chatLogic.chatScrollController,
                                        children: List.generate(
                                            _chatLogic.messageList.length,
                                            (index) {
                                          return Padding(
                                            padding: _chatLogic
                                                        .messageList[index]
                                                        .senderId ==
                                                    Get.find<
                                                            GeneralController>()
                                                        .storageBox
                                                        .read('userID')
                                                ? EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        80.w, 0, 15.w, 7.h)
                                                : EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.w, 15.h, 80.w, 7.h),
                                            child: Row(
                                              mainAxisAlignment: _chatLogic
                                                          .messageList[index]
                                                          .senderId ==
                                                      Get.find<
                                                              GeneralController>()
                                                          .storageBox
                                                          .read('userID')
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: _chatLogic
                                                                    .messageList[
                                                                        index]
                                                                    .senderId ==
                                                                Get.find<
                                                                        GeneralController>()
                                                                    .storageBox
                                                                    .read(
                                                                        'userID')
                                                            ? customTextFieldColor
                                                            : customLightThemeColor,
                                                        borderRadius: _chatLogic
                                                                    .messageList[
                                                                        index]
                                                                    .senderId ==
                                                                Get.find<
                                                                        GeneralController>()
                                                                    .storageBox
                                                                    .read(
                                                                        'userID')
                                                            ? BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20.r),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.r),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.r),
                                                              )
                                                            : BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20.r),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.r),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.r),
                                                              )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .all(14.0),
                                                      child: Text(
                                                          '${_chatLogic.messageList[index].message}',
                                                          style: _chatLogic
                                                                      .messageList[
                                                                          index]
                                                                      .senderId ==
                                                                  Get.find<
                                                                          GeneralController>()
                                                                      .storageBox
                                                                      .read(
                                                                          'userID')
                                                              ? state
                                                                  .replyTextStyle
                                                              : state
                                                                  .messageTextStyle!),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      )),
                                SizedBox(
                                  height: 65.h,
                                )
                              ],
                            ),
                          ),

                          ///---text-field
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0, 15.w, 15.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: SarabunFontFamily.regular,
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                      controller: _chatLogic.messageController,
                                      onTap: () {
                                        Future.delayed(
                                                const Duration(seconds: 1))
                                            .whenComplete(() => Get.find<
                                                    ChatLogic>()
                                                .chatScrollController!
                                                .animateTo(
                                                    Get.find<ChatLogic>()
                                                        .chatScrollController!
                                                        .position
                                                        .maxScrollExtent,
                                                    curve: Curves.easeOut,
                                                    duration: const Duration(
                                                        milliseconds: 500)));
                                      },
                                      textInputAction: TextInputAction.send,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      onChanged: (value) {
                                        if (_chatLogic
                                            .messageController.text.isEmpty) {
                                          _chatLogic.updateShowSendIcon(false);
                                        } else {
                                          _chatLogic.updateShowSendIcon(true);
                                        }
                                      },
                                      onFieldSubmitted: (value) {
                                        Get.find<GeneralController>()
                                            .notificationRouteApp = null;
                                        _generalController.focusOut(context);
                                        postMethod(
                                            context,
                                            sendMessageUrl,
                                            {
                                              'token': '123',
                                              'receiver_id':
                                                  Get.find<ChatLogic>()
                                                      .receiverMessageGetId,
                                              'sender_id': Get.find<ChatLogic>()
                                                  .senderMessageGetId,
                                              'message': _chatLogic
                                                  .messageController.text
                                            },
                                            true,
                                            sendMessagesRepo);
                                      },
                                      textDirection: _generalController
                                              .isDirectionRTL(context)
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 20.w),
                                        filled: true,
                                        fillColor: customThemeColor,
                                        hintText:
                                            '${LanguageConstant.yourTextHere.tr}.....',
                                        hintStyle: state.textFieldTextStyle,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.r),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.r),
                                            borderSide: const BorderSide(
                                                color: customThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.r),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.r),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  _chatLogic.showSendIcon!
                                      ? Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.w, 0, 0, 0),
                                          child: InkWell(
                                            onTap: () {
                                              Get.find<GeneralController>()
                                                  .notificationRouteApp = null;
                                              _generalController
                                                  .focusOut(context);
                                              postMethod(
                                                  context,
                                                  sendMessageUrl,
                                                  {
                                                    'token': '123',
                                                    'receiver_id': Get.find<
                                                            ChatLogic>()
                                                        .receiverMessageGetId,
                                                    'sender_id':
                                                        Get.find<ChatLogic>()
                                                            .senderMessageGetId,
                                                    'message': _chatLogic
                                                        .messageController.text
                                                  },
                                                  true,
                                                  sendMessagesRepo);
                                            },
                                            child: const CircleAvatar(
                                              radius: 20,
                                              child: Icon(
                                                Icons.send,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              backgroundColor: customThemeColor,
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ));
      });
    });
  }
}
