import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ista_app/multi_language/language_constants.dart';
import 'package:ista_app/src/modules/sign_up/model.dart';
import 'package:ista_app/src/modules/sign_up/state.dart';

class SignUpLogic extends GetxController {
  final SignUpState state = SignUpState();

  SignupModel signupModel = SignupModel();
  TabController? tabController;

  List<Tab> signupRoleTabList = [
    Tab(text: LanguageConstant.user.tr),
    Tab(text: LanguageConstant.mentor.tr)
  ];

  String? selectedRole = 'Mentee';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? emailValidator;
}
