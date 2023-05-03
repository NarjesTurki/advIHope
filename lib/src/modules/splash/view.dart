import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/controller/general_controller.dart';
import 'package:ista_app/src/modules/consultant/dashboard/view.dart';
import 'package:ista_app/src/modules/on_board/view_1.dart';
import 'package:ista_app/src/modules/splash/logic.dart';
import 'package:ista_app/src/modules/user/home/view.dart';
import 'package:ista_app/src/utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final logic = Get.put(SplashLogic());

  final state = Get.find<SplashLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(const ScreenController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash_background.png'),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                customThemeColor.withOpacity(0.7),
                customLightThemeColor.withOpacity(0.9),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                Expanded(
                    child: Image.asset(
                  'assets/Icons/v1.png',
                  width: MediaQuery.of(context).size.width * .4,
                )),
                SizedBox(height: MediaQuery.of(context).size.height * .2),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .1),
                        Text(
                          'Top Notch Consultants',
                          textAlign: TextAlign.center,
                          style: state.titleTextStyle,
                        ),
                        Text(
                          'In One Place',
                          textAlign: TextAlign.center,
                          style: state.subTitleTextStyle,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class ScreenController extends StatelessWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.find<GeneralController>().storageBox.hasData('authToken')) {
      if (Get.find<GeneralController>()
              .storageBox
              .read('userRole')
              .toString() ==
          'Mentee') {
        return const UserHomePage();
      } else {
        return const ConsultantDashboardPage();
      }
    } else if (Get.find<GeneralController>().storageBox.hasData('onBoard')) {
      return const UserHomePage();
    } else {
      return const OnBoard1Page();
    }
  }
}
