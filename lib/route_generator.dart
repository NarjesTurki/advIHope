import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/about_us/view.dart';
import 'package:ista_app/src/modules/agora_call/join_channel_audio.dart';
import 'package:ista_app/src/modules/agora_call/join_channel_video.dart';
import 'package:ista_app/src/modules/blogs/view.dart';
import 'package:ista_app/src/modules/blogs/view_blogs_detail.dart';
import 'package:ista_app/src/modules/chat/view.dart';
import 'package:ista_app/src/modules/consultant/all_blogs/all_blogs_views.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/request_for_live_view.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment/view.dart';
import 'package:ista_app/src/modules/consultant/consultant_appointment_detail/view.dart';
import 'package:ista_app/src/modules/consultant/consultant_drawer/view.dart';
import 'package:ista_app/src/modules/consultant/create_blog/create_blog_view.dart';
import 'package:ista_app/src/modules/consultant/create_profile/view.dart';
import 'package:ista_app/src/modules/consultant/dashboard/view.dart';
import 'package:ista_app/src/modules/consultant/edit_consultant_profile/view.dart';
import 'package:ista_app/src/modules/consultant/my-profile/view.dart';
import 'package:ista_app/src/modules/consultant/schedule/view.dart';
import 'package:ista_app/src/modules/contact_us/view.dart';
import 'package:ista_app/src/modules/created_password/view.dart';
import 'package:ista_app/src/modules/inapp_web/view.dart';
import 'package:ista_app/src/modules/login/view.dart';
import 'package:ista_app/src/modules/new_password/view.dart';
import 'package:ista_app/src/modules/on_board/view_1.dart';
import 'package:ista_app/src/modules/on_board/view_2.dart';
import 'package:ista_app/src/modules/on_board/view_3.dart';
import 'package:ista_app/src/modules/on_board/view_4.dart';
import 'package:ista_app/src/modules/otp/view.dart';
import 'package:ista_app/src/modules/reset_password/view.dart';
import 'package:ista_app/src/modules/sign_up/view.dart';
import 'package:ista_app/src/modules/splash/view.dart';
import 'package:ista_app/src/modules/user/all_consultants/view.dart';
import 'package:ista_app/src/modules/user/appointment_detail/payment/view_stripe.dart';
import 'package:ista_app/src/modules/user/appointment_detail/view.dart';
import 'package:ista_app/src/modules/user/book_appointment/payment_stripe/view_stripe.dart';
import 'package:ista_app/src/modules/user/book_appointment/view_appointment_question.dart';
import 'package:ista_app/src/modules/user/book_appointment/view_confirmation.dart';
import 'package:ista_app/src/modules/user/book_appointment/view_slot_selection.dart';
import 'package:ista_app/src/modules/user/book_appointment/wallet_payment/view.dart';
//import 'package:ista_app/src/modules/user/book_appointment/wallet_payment/view.dart';
import 'package:ista_app/src/modules/user/consultant_profile/view.dart';
import 'package:ista_app/src/modules/user/edit_user_profile.dart/view.dart';
import 'package:ista_app/src/modules/user/home/view.dart';
import 'package:ista_app/src/modules/user/my_appointment/view.dart';
import 'package:ista_app/src/modules/user/search_consultant/view.dart';
import 'package:ista_app/src/modules/user/user_drawer/view.dart';
import 'package:ista_app/src/modules/wallet/payment_stripe/view_stripe.dart';
import 'package:ista_app/src/modules/wallet/view.dart';
import 'package:ista_app/src/reclamation/view.dart';

routes() => [
      GetPage(name: "/login", page: () => const LoginPage()),
      GetPage(name: "/signUp", page: () => const SignUpPage()),
      GetPage(name: "/userHome", page: () => const UserHomePage()),
      GetPage(
          name: "/consultantProfileForUser",
          page: () => ConsultantProfilePage(),
          transition: Transition.zoom),
      GetPage(name: "/slotSelection", page: () => SlotSelection()),
      GetPage(
          name: "/appointmentQuestion",
          page: () => AppointmentQuestionPage(),
          transition: Transition.noTransition),
      GetPage(
          name: "/paymentStripeView",
          page: () => const StripePaymentView(),
          transition: Transition.noTransition),
      GetPage(name: "/allConsultants", page: () => const AllConsultantsPage()),
      GetPage(name: "/resetPassword", page: () => const ResetPasswordPage()),
      GetPage(name: "/enterOtp", page: () => const OtpPage()),
      GetPage(name: "/newPassword", page: () => const NewPasswordPage()),
      GetPage(
          name: "/createdPassword", page: () => const CreatedPasswordPage()),
      GetPage(
          name: "/appointmentConfirmation",
          page: () => const AppointmentConfirmationView()),
      GetPage(
        name: "/userDrawer",
        page: () => const UserDrawerPage(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(name: "/myAppointment", page: () => const MyAppointmentPage()),
      GetPage(
          name: "/appointmentDetail",
          page: () => const AppointmentDetailPage()),
      GetPage(name: "/chatScreen", page: () => const ChatPage()),
      GetPage(name: "/walletScreen", page: () => const WalletPage()),
      GetPage(
          name: "/onBoard1Screen",
          page: () => const OnBoard1Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/onBoard2Screen",
          page: () => const OnBoard2Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/onBoard3Screen",
          page: () => const OnBoard3Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/onBoard4Screen",
          page: () => const OnBoard4Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/editUserProfile", page: () => const EditUserProfilePage()),
      GetPage(
          name: "/createConsultantProfile",
          page: () => const CreateProfilePage()),
      GetPage(
          name: "/consultantDashboard",
          page: () => const ConsultantDashboardPage()),
      GetPage(
        name: "/consultantDrawer",
        page: () => const ConsultantDrawerPage(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(name: "/scheduleCreate", page: () => const ScheduleCreatePage()),
      GetPage(
          name: "/consultantAllAppointment",
          page: () => const ConsultantAppointmentPage()),
      GetPage(
          name: "/consultantAppointmentDetail",
          page: () => const ConsultantAppointmentDetailPage()),
      GetPage(
          name: "/consultantMyProfile",
          page: () => const ConsultantMyProfilePage()),
      GetPage(
          name: "/editConsultantProfile",
          page: () => const EditConsultantProfilePage()),
      GetPage(name: "/blogs", page: () => const BlogsPage()),
      GetPage(name: "/allBlogs", page: () => AllBlogsPage()),
      GetPage(name: "/createBlog", page: () => const CreateBlogPage()),
      GetPage(name: "/blogDetail", page: () => const BlogDetailPage()),
      GetPage(name: '/videoCall', page: () => const JoinChannelVideo()),
      GetPage(name: '/audioCall', page: () => const JoinChannelAudio()),
      GetPage(name: '/videoCallWaiting', page: () => const CallWaitingView()),
      GetPage(name: '/aboutUs', page: () => const AboutUsPage()),
      GetPage(name: '/contactUs', page: () => const ContactUsPage()),
      GetPage(
          name: '/stripePaymentForWallet',
          page: () => const StripePaymentForWalletView()),
      GetPage(name: '/walletPaymentScreen', page: () => WalletPaymentView()),
      GetPage(name: '/splash', page: () => const SplashPage()),
      GetPage(name: '/inAppWebPage', page: () => const InAppWebPage()),
      GetPage(
          name: '/stripePaymentForLater',
          page: () => const StripePaymentForLater()),
      GetPage(
          name: '/searchConsultant', page: () => const SearchConsultantPage()),
      GetPage(name: '/requestForLive', page: () => const LiveRequest()),
      GetPage(name: '/reclamation', page: () => const ReclamationPage()),
    ];

class PageRoutes {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String userHome = '/userHome';
  static const String consultantProfileForUser = '/consultantProfileForUser';
  static const String slotSelection = '/slotSelection';
  static const String appointmentQuestion = '/appointmentQuestion';
  static const String allConsultants = '/allConsultants';
  static const String resetPassword = '/resetPassword';
  static const String paymentStripeView = '/paymentStripeView';
  static const String enterOtp = '/enterOtp';
  static const String newPassword = '/newPassword';
  static const String createdPassword = '/createdPassword';
  static const String appointmentConfirmation = '/appointmentConfirmation';
  static const String userDrawer = '/userDrawer';
  static const String myAppointment = '/myAppointment';
  static const String appointmentDetail = '/appointmentDetail';
  static const String chatScreen = '/chatScreen';
  static const String walletScreen = '/walletScreen';
  static const String onBoard1Screen = '/onBoard1Screen';
  static const String onBoard2Screen = '/onBoard2Screen';
  static const String onBoard3Screen = '/onBoard3Screen';
  static const String onBoard4Screen = '/onBoard4Screen';
  static const String editUserProfile = '/editUserProfile';
  static const String createConsultantProfile = '/createConsultantProfile';
  static const String consultantDashboard = '/consultantDashboard';
  static const String consultantDrawer = '/consultantDrawer';
  static const String scheduleCreate = '/scheduleCreate';
  static const String consultantAllAppointment = '/consultantAllAppointment';
  static const String consultantAppointmentDetail =
      '/consultantAppointmentDetail';
  static const String consultantMyProfile = '/consultantMyProfile';
  static const String editConsultantProfile = '/editConsultantProfile';
  static const String blogs = '/blogs';
  static const String allBlogs = '/allBlogs';
  static const String createBlog = '/createBlog';
  static const String blogDetail = '/blogDetail';
  static const String depositJazzcash = '/depositJazzcash';
  static const String depositEasypaisa = '/depositEasypaisa';
  static const String videoCall = '/videoCall';
  static const String audioCall = '/audioCall';
  static const String videoCallWaiting = '/videoCallWaiting';
  static const String aboutUs = '/aboutUs';
  static const String contactUs = '/contactUs';
  static const String stripePaymentForWallet = '/stripePaymentForWallet';
  static const String walletPaymentScreen = '/walletPaymentScreen';
  static const String splash = '/splash';
  static const String inAppWebPage = '/inAppWebPage';
  static const String stripePaymentForLater = '/stripePaymentForLater';
  static const String searchConsultant = '/searchConsultant';
  static const String requestForLive = '/requestForLive';
  static const String reclamation = '/reclamation';
  Map<String, WidgetBuilder> routes() {
    return {
      login: (context) => const LoginPage(),
      signUp: (context) => const SignUpPage(),
      userHome: (context) => const UserHomePage(),
      consultantProfileForUser: (context) => ConsultantProfilePage(),
      slotSelection: (context) => SlotSelection(),
      appointmentQuestion: (context) => AppointmentQuestionPage(),
      allConsultants: (context) => const AllConsultantsPage(),
      resetPassword: (context) => const ResetPasswordPage(),
      paymentStripeView: (context) => const StripePaymentView(),
      enterOtp: (context) => const OtpPage(),
      newPassword: (context) => const NewPasswordPage(),
      createdPassword: (context) => const CreatedPasswordPage(),
      appointmentConfirmation: (context) => const AppointmentConfirmationView(),
      userDrawer: (context) => const UserDrawerPage(),
      myAppointment: (context) => const MyAppointmentPage(),
      appointmentDetail: (context) => const AppointmentDetailPage(),
      chatScreen: (context) => const ChatPage(),
      walletScreen: (context) => const WalletPage(),
      onBoard1Screen: (context) => const OnBoard1Page(),
      onBoard2Screen: (context) => const OnBoard2Page(),
      onBoard3Screen: (context) => const OnBoard3Page(),
      onBoard4Screen: (context) => const OnBoard4Page(),
      editUserProfile: (context) => const EditUserProfilePage(),
      createConsultantProfile: (context) => const CreateProfilePage(),
      consultantDashboard: (context) => const ConsultantDashboardPage(),
      consultantDrawer: (context) => const ConsultantDrawerPage(),
      scheduleCreate: (context) => const ScheduleCreatePage(),
      consultantAllAppointment: (context) => const ConsultantAppointmentPage(),
      consultantAppointmentDetail: (context) =>
          const ConsultantAppointmentDetailPage(),
      consultantMyProfile: (context) => const ConsultantMyProfilePage(),
      editConsultantProfile: (context) => const EditConsultantProfilePage(),
      blogs: (context) => const BlogsPage(),
      allBlogs: (context) => AllBlogsPage(),
      createBlog: (context) => const CreateBlogPage(),
      blogDetail: (context) => const BlogDetailPage(),
      videoCall: (context) => const JoinChannelVideo(),
      audioCall: (context) => const JoinChannelAudio(),
      videoCallWaiting: (context) => const CallWaitingView(),
      aboutUs: (context) => const AboutUsPage(),
      contactUs: (context) => const ContactUsPage(),
      stripePaymentForWallet: (context) => const StripePaymentForWalletView(),
      walletPaymentScreen: (context) => WalletPaymentView(),
      splash: (context) => const SplashPage(),
      inAppWebPage: (context) => const InAppWebPage(),
      stripePaymentForLater: (context) => const StripePaymentForLater(),
      searchConsultant: (context) => const SearchConsultantPage(),
      requestForLive: (context) => const LiveRequest(),
      reclamation: (context) => const ReclamationPage(),
    };
  }
}
