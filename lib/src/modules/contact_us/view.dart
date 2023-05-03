import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/api_services/post_service.dart';
import 'package:ista_app/src/api_services/urls.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/contact_us/logic.dart';
import 'package:ista_app/src/modules/contact_us/repo.dart';
import 'package:ista_app/src/modules/main_repo/main_logic.dart';
import 'package:ista_app/src/utils/colors.dart';
import 'package:ista_app/src/widgets/custom_button_bar.dart';
import 'package:ista_app/src/widgets/custom_sliver_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:resize/resize.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final logic = Get.put(ContactUsLogic());

  final state = Get.find<ContactUsLogic>().state;

  final GlobalKey<FormState> _contactUsFormKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Get.put(MainLogic());
    super.initState();

    Get.find<ContactUsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ContactUsLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<ContactUsLogic>()
        .scrollController!
        .removeListener(Get.find<ContactUsLogic>().scrollListener);
    Get.find<ContactUsLogic>().scrollController!.dispose();
    super.dispose();
  }

  String?
      _selectedSubject; // Variable pour stocker la valeur sélectionnée dans la liste déroulante principale
  String?
      _selectedSubSubject; // Variable pour stocker la valeur sélectionnée dans la deuxième liste déroulante (sous-menu)
  final List<String> _subjectList = [
    "Problem with consultant",
    "Problem with customer",
    "Other"
  ]; // Liste des sujets pour la liste déroulante principale
  final List<String> _problemWithCustomerSubSubjectList = [
    "He wasn't on time",
    "Voice/video quality is bad"
  ]; // Liste des sous-sujets pour la deuxième liste déroulante (sous-menu)
  final List<String> _otherSubSubjectList = [
    'Say Hello',
    'Technical issue',
    'Finance issue',
  ];
  final List<String> _consultantSubSubjectList = [
    "He wasn't on time",
    "Not satisfied at all",
    "Voice/video quality is bad",
    "This is not what I was looking for"
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ContactUsLogic>(builder: (_contactUsLogic) {
        return ModalProgressHUD(
          inAsyncCall: _generalController.formLoaderController,
          child: GestureDetector(
            onTap: () {
              _generalController.focusOut(context);
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xffFBFBFB),
              body: NestedScrollView(
                  controller: _contactUsLogic.scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      MyCustomSliverAppBar(
                        heading: LanguageConstant.contactUs.tr,
                        subHeading:
                            LanguageConstant.weAreJustOneStepAwayReachOut.tr,
                        isShrink: _contactUsLogic.isShrink,
                      ),
                    ];
                  },
                  body: Container(
                      color: const Color(0xffFCFCFC),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 19.w),
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height * .7,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 30,
                                          )
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.r))),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.w, 0, 15.w, 30.h),
                                      child: Form(
                                        key: _contactUsFormKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 25.h),

                                            /// Address
                                            InkWell(
                                              onTap: () {
                                                MapsLauncher.launchCoordinates(
                                                    double.parse((Get.find<
                                                                MainLogic>()
                                                            .getGeneralSettingModel
                                                            .data
                                                            ?.latitude)
                                                        .toString()),
                                                    double.parse((Get.find<
                                                                MainLogic>()
                                                            .getGeneralSettingModel
                                                            .data
                                                            ?.longitude)
                                                        .toString()),
                                                    'Here');
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: customThemeColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.r))),
                                                child: ListTile(
                                                  minLeadingWidth: 20.w,
                                                  leading: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Color.fromARGB(
                                                                    255,
                                                                    202,
                                                                    202,
                                                                    202),
                                                                BlendMode
                                                                    .srcIn),
                                                        child: SvgPicture.asset(
                                                            'assets/Icons/location.svg'),
                                                      ),
                                                    ],
                                                  ),
                                                  title: Text(
                                                    LanguageConstant.address.tr,
                                                    style: state.titleTextStyle,
                                                  ),
                                                  subtitle: Text(
                                                    Get.find<MainLogic>()
                                                            .getGeneralSettingModel
                                                            .data
                                                            ?.address ??
                                                        '',
                                                    style:
                                                        state.subTitleTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8.h),

                                            /// Call
                                            InkWell(
                                              onTap: () {
                                                _contactUsLogic.makePhoneCall(Get
                                                            .find<MainLogic>()
                                                        .getGeneralSettingModel
                                                        .data!
                                                        .phone ??
                                                    '');
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: customThemeColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.r))),
                                                child: ListTile(
                                                  minLeadingWidth: 20.w,
                                                  leading: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Color.fromARGB(
                                                                    255,
                                                                    202,
                                                                    202,
                                                                    202),
                                                                BlendMode
                                                                    .srcIn),
                                                        child: SvgPicture.asset(
                                                            'assets/Icons/drawerContactUsIcon.svg'),
                                                      ),
                                                    ],
                                                  ),
                                                  title: Text(
                                                    LanguageConstant.callUs.tr,
                                                    style: state.titleTextStyle,
                                                  ),
                                                  subtitle: Text(
                                                    Get.find<MainLogic>()
                                                            .getGeneralSettingModel
                                                            .data
                                                            ?.phone ??
                                                        '',
                                                    style:
                                                        state.subTitleTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8.h),

                                            /// Email
                                            InkWell(
                                              onTap: () {
                                                _contactUsLogic.sendMail(Get
                                                            .find<MainLogic>()
                                                        .getGeneralSettingModel
                                                        .data
                                                        ?.companyEmail ??
                                                    '');
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: customThemeColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.r))),
                                                child: ListTile(
                                                  minLeadingWidth: 20.w,
                                                  leading: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Color.fromARGB(
                                                                    255,
                                                                    202,
                                                                    202,
                                                                    202),
                                                                BlendMode
                                                                    .srcIn),
                                                        child: SvgPicture.asset(
                                                            'assets/Icons/message.svg'),
                                                      ),
                                                    ],
                                                  ),
                                                  title: Text(
                                                    LanguageConstant.emailUs.tr,
                                                    style: state.titleTextStyle,
                                                  ),
                                                  subtitle: Text(
                                                    Get.find<MainLogic>()
                                                            .getGeneralSettingModel
                                                            .data
                                                            ?.companyEmail ??
                                                        '',
                                                    style:
                                                        state.subTitleTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 20.h),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  LanguageConstant.name.tr,
                                                  style: state.subTitleTextStyle
                                                      ?.copyWith(
                                                          color:
                                                              customTextGreyColor),
                                                ),

                                                /// Name form field
                                                TextFormField(
                                                  controller: _nameController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            "[a-z A-Z ]"))
                                                  ],
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 0.0),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customThemeColor)),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customHintColor)),
                                                    border: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                customHintColor)),
                                                  ),
                                                  validator: (String? value) {
                                                    if ((value ?? '').isEmpty) {
                                                      return LanguageConstant
                                                          .fieldRequired.tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 20.h),
                                                Text(
                                                  LanguageConstant.email.tr,
                                                  style: state.subTitleTextStyle
                                                      ?.copyWith(
                                                          color:
                                                              customTextGreyColor),
                                                ),

                                                /// email form field
                                                TextFormField(
                                                  controller: _emailController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 0.0),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customThemeColor)),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customHintColor)),
                                                    border: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                customHintColor)),
                                                  ),
                                                  validator: (String? value) {
                                                    if ((value ?? "").isEmpty) {
                                                      return LanguageConstant
                                                          .fieldRequired.tr;
                                                    }
                                                    if (!GetUtils.isEmail(
                                                        _emailController
                                                            .text)) {
                                                      return LanguageConstant
                                                          .enterValidEmail.tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 20.h),

                                                ///---subject
                                                Text(
                                                  LanguageConstant.subject.tr,
                                                  style: state.subTitleTextStyle
                                                      ?.copyWith(
                                                          color:
                                                              customTextGreyColor),
                                                ),
                                                /* DropdownButtonFormField<String>(
                                                  value:
                                                      _selectedSubject, // La valeur sélectionnée dans la liste déroulante
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 0.0),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customThemeColor)),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customHintColor)),
                                                    border: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                customHintColor)),
                                                  ),
                                                  items: _subjectList
                                                      .map((String subject) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: subject,
                                                      child: Text(subject),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String?
                                                      selectedSubject) {
                                                    setState(() {
                                                      _selectedSubject =
                                                          selectedSubject; // Mettre à jour la valeur sélectionnée dans l'état
                                                    });
                                                  },
                                                  validator: (String? value) {
                                                    if ((value ?? "").isEmpty) {
                                                      return LanguageConstant
                                                          .fieldRequired.tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
*/
                                                /* DropdownButtonFormField<String>(
                                                  value: _selectedSubject,
                                                  items: _subjectList
                                                      .map((String subject) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: subject,
                                                      child: Text(subject),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      _selectedSubject = value;
                                                      _selectedOption =
                                                          null; // Réinitialiser la valeur de la deuxième liste déroulante lors de la sélection d'un nouveau sujet
                                                    });
                                                  },
                                                ),
                                                if (_selectedSubject ==
                                                    'Sujet 2') // Afficher la deuxième liste déroulante uniquement si "Sujet 2" est sélectionné dans la première liste déroulante
                                                  DropdownButtonFormField<
                                                      String>(
                                                    value: _selectedOption,
                                                    items: _optionsMap[
                                                            _selectedSubject]
                                                        ?.map((String option) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _selectedOption = value;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Option',
                                                    ),
                                                  ),
                                                SizedBox(height: 20.h),

                                                Text(
                                                  LanguageConstant.message.tr,
                                                  style: state.subTitleTextStyle
                                                      ?.copyWith(
                                                          color:
                                                              customTextGreyColor),
                                                ),*/
                                                /*DropdownButtonFormField<String>(
                                                  value: _selectedSubject,
                                                  decoration: InputDecoration(
                                                      // Décoration pour la liste déroulante principale
                                                      ),
                                                  items: _subjectList
                                                      .map((String subject) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: subject,
                                                      child: Text(subject),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String?
                                                      selectedSubject) {
                                                    setState(() {
                                                      _selectedSubject =
                                                          selectedSubject; // Mettre à jour la valeur sélectionnée dans l'état
                                                    });
                                                  },
                                                  validator: (String? value) {
                                                    if ((value ?? "").isEmpty) {
                                                      return LanguageConstant
                                                          .fieldRequired.tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                if (_selectedSubject ==
                                                    "Problem with customer") // Vérifier si le sujet 2 est sélectionné
                                                  DropdownButtonFormField<
                                                      String>(
                                                    value: _selectedSubSubject,
                                                    decoration:
                                                        const InputDecoration(
                                                      // Décoration pour la deuxième liste déroulante (sous-menu)
                                                      hintText: "Options",
                                                    ),
                                                    items: _subSubjectList.map(
                                                        (String subSubject) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: subSubject,
                                                        child: Text(subSubject),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String?
                                                        selectedSubSubject) {
                                                      setState(() {
                                                        _selectedSubSubject =
                                                            selectedSubSubject; // Mettre à jour la valeur sélectionnée dans l'état
                                                      });
                                                    },
                                                    validator: (String? value) {
                                                      if ((value ?? "")
                                                          .isEmpty) {
                                                        return LanguageConstant
                                                            .fieldRequired.tr;
                                                      }
                                                      return null;
                                                    },
                                                  ),*/
                                                DropdownButtonFormField<String>(
                                                  value: _selectedSubject,
                                                  decoration: InputDecoration(),
                                                  items: _subjectList
                                                      .map((String subject) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: subject,
                                                      child: Text(subject),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String?
                                                      selectedSubject) {
                                                    setState(() {
                                                      _selectedSubject =
                                                          selectedSubject;
                                                      _selectedSubSubject =
                                                          null; // réinitialiser la valeur sélectionnée dans la sous-liste
                                                    });
                                                  },
                                                  validator: (String? value) {
                                                    if ((value ?? "").isEmpty) {
                                                      return LanguageConstant
                                                          .fieldRequired.tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                if (_selectedSubject ==
                                                    "Problem with consultant")
                                                  DropdownButtonFormField<
                                                      String>(
                                                    value: _selectedSubSubject,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "Options",
                                                    ),
                                                    items:
                                                        _consultantSubSubjectList
                                                            .map((String
                                                                subSubject) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: subSubject,
                                                        child: Text(subSubject),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String?
                                                        selectedSubSubject) {
                                                      setState(() {
                                                        _selectedSubSubject =
                                                            selectedSubSubject;
                                                      });
                                                    },
                                                    validator: (String? value) {
                                                      if ((value ?? "")
                                                          .isEmpty) {
                                                        return LanguageConstant
                                                            .fieldRequired.tr;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                if (_selectedSubject ==
                                                    "Problem with customer")
                                                  DropdownButtonFormField<
                                                      String>(
                                                    value: _selectedSubSubject,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "Options",
                                                    ),
                                                    items:
                                                        _problemWithCustomerSubSubjectList
                                                            .map((String
                                                                subSubject) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: subSubject,
                                                        child: Text(subSubject),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String?
                                                        selectedSubSubject) {
                                                      setState(() {
                                                        _selectedSubSubject =
                                                            selectedSubSubject;
                                                      });
                                                    },
                                                    validator: (String? value) {
                                                      if ((value ?? "")
                                                          .isEmpty) {
                                                        return LanguageConstant
                                                            .fieldRequired.tr;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                if (_selectedSubject == "Other")
                                                  DropdownButtonFormField<
                                                      String>(
                                                    value: _selectedSubSubject,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "Options",
                                                    ),
                                                    items: _otherSubSubjectList
                                                        .map((String
                                                            subSubject) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: subSubject,
                                                        child: Text(subSubject),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String?
                                                        selectedSubSubject) {
                                                      setState(() {
                                                        _selectedSubSubject =
                                                            selectedSubSubject;
                                                      });
                                                    },
                                                    validator: (String? value) {
                                                      if ((value ?? "")
                                                          .isEmpty) {
                                                        return LanguageConstant
                                                            .fieldRequired.tr;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                SizedBox(height: 20.h),
                                                Text(
                                                  LanguageConstant.message.tr,
                                                  style: state.subTitleTextStyle
                                                      ?.copyWith(
                                                          color:
                                                              customTextGreyColor),
                                                ),

                                                /// message form field
                                                TextFormField(
                                                  controller:
                                                      _messageController,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: 3,
                                                  minLines: 1,
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 0.0),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customThemeColor)),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    customHintColor)),
                                                    border: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                customHintColor)),
                                                  ),
                                                  validator: (String? value) {
                                                    if ((value ?? '').isEmpty) {
                                                      return LanguageConstant
                                                          .fieldRequired.tr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .15),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.h,
                          left: 15.w,
                          right: 15.w,
                          child: InkWell(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (_contactUsFormKey.currentState!
                                    .validate()) {
                                  _generalController
                                      .updateFormLoaderController(true);
                                  postMethod(
                                      context,
                                      contactUsUrl,
                                      {
                                        'token': '123',
                                        'name': _nameController.text,
                                        'email': _emailController.text,
                                        'subject': _subjectController.text,
                                        'message': _messageController.text
                                      },
                                      true,
                                      contactUsRepo);
                                }
                              },
                              child: MyCustomBottomBar(
                                  title: LanguageConstant.submit.tr,
                                  disable: false)),
                        ),
                      ]))),
            ),
          ),
        );
      });
    });
  }
}
