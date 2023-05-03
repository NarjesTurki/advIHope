import 'package:global_configuration/global_configuration.dart';

//  "base_url": "https://demo.consultant.nictusthemes.com/",
//  "api_base_url": "https://demo.consultant.nictusthemes.com/api/",
//  "media_url": "https://demo.consultant.nictusthemes.com/",

//final String baseUrl = "http://10.0.2.2:8000/";
//final String apiBaseUrl = "http://10.0.2.2:8000/api/"final String mediaUrl = "http://10.0.2.2:8000/";

final String baseUrl = GlobalConfiguration().getValue('base_url');
final String apiBaseUrl = GlobalConfiguration().getValue('api_base_url');
final String mediaUrl = GlobalConfiguration().getValue('media_url');

///---fcm
const String fcmService = 'https://fcm.googleapis.com/fcm/send';

///---auth
String signUpWithEmailURL = apiBaseUrl + 'signup-email';
String loginWithEmailURL = apiBaseUrl + 'login-email';
String loginWithGoogleURL = apiBaseUrl + 'auth/google';
String loginWithOtpURL = apiBaseUrl + 'login-signup';

String mentorApprovalStatusUrl = apiBaseUrl + 'mentorStatus';

String contactUsUrl = apiBaseUrl + 'contactus';

///---payment-method
String paymentMethodUrl = apiBaseUrl + 'execute-payment';
String jazzCashPaymentUrl = apiBaseUrl + 'makeJazzcashPayment';
String getAppointmentPaymentStatusUrl = baseUrl + 'getAppointmentStatus';
String getPaymentMethodsUrl = apiBaseUrl + 'payment_methods';

///---search
String searchConsultantUrl = apiBaseUrl + 'search-mentor-mobile';

///---user
String getMenteeProfileUrl = apiBaseUrl + 'get-mentee-profile';

String updateMenteeProfileUrl = apiBaseUrl + 'update-mentee-profile';

///---consultant-profile-by-id
String getUserProfileUrl = apiBaseUrl + 'getUserById';
String getMentorProfileForMenteeUrl = apiBaseUrl + 'get-mentor-details';

///---consultant-profile-section
String mentorProfileGenericDataUrl = apiBaseUrl + 'generic_mentor';
String getCitiesByIdUrl = apiBaseUrl + 'cities';
String getCountriesUrl = apiBaseUrl + 'countries';
String mentorParentCategoryDataUrl = apiBaseUrl + 'mentorCategoriesList';
String mentorChildCategoryDataUrl = apiBaseUrl + 'mentorChildCategoriesList';
String mentorGeneralInfoPostUrl = apiBaseUrl + 'updateMentorProfile';
String mentorEducationalInfoPostUrl = apiBaseUrl + 'mentorEducation';
String mentorExperienceInfoUrl = apiBaseUrl + 'mentorExperience';
String mentorSkillInfoUrl = apiBaseUrl + 'mentorSkill';
String mentorAccountInfoUrl = apiBaseUrl + 'mentor_card';
String mentorEducationalInfoDeleteUrl = apiBaseUrl + 'mentorEducationDelete';
String mentorExperienceInfoDeleteUrl = apiBaseUrl + 'mentorExperienceDelete';
String mentorSkillInfoDeleteUrl = apiBaseUrl + 'mentorSkillDelete';
String mentorRatingsUrl = apiBaseUrl + 'get-ratings-detail';

///---mentor-schedule
String getAppointmentTypeUrl = apiBaseUrl + 'appointmenttypes';
String markDayHolidayUrl = apiBaseUrl + 'mark-day-holiday';
String getAvailableDaysUrl = apiBaseUrl + 'get-available-days';
String saveMentorSchedulesUrl = apiBaseUrl + 'save-mentor-schedule';
String saveMentorChatFeeUrl = apiBaseUrl + 'save-mentor-chat-fee';
String getMentorSchedulesUrl = apiBaseUrl + 'get-mentor-schedules';
String deleteMentorScheduleUrl = apiBaseUrl + 'delete-mentor-schedule';

String mentorProfileStatusUrl = apiBaseUrl + 'mentorProfile';

String changeProfileVisibilityUrl = apiBaseUrl + 'toggle-visibility';
String changeMentorOnlineStatusUrl = apiBaseUrl + 'changeOnlineStatus';
String goLiveForMentorUrl = apiBaseUrl + 'turn-live-mentor';
String inActiveLiveForMentorUrl = apiBaseUrl + 'turn-inactive-mentor';

String mentorChangeAppointmentStatusUrl =
    apiBaseUrl + 'changeAppointmentStatus';

///---get-appointment-counts
String getAppointmentCountUrl = apiBaseUrl + 'mentorAppointmentCount';
String getAppointmentCountForMentorUrl = apiBaseUrl + 'appointment-count';

///---mentor-appointment-log
String mentorAllAppointmentUrl = apiBaseUrl + 'mentorAppointments';
String mentorNewAppointmentUrl = apiBaseUrl + 'newMentorAppointments';
String mentorTodayAppointmentUrl = apiBaseUrl + 'today-appointments';

///---featured
String getFeaturedURL = apiBaseUrl + 'get-featured-mentors';

///---categories
String getCategoriesURL = apiBaseUrl + 'mentorCategories';

///---top-rated
String getTopRatedConsultantURL = apiBaseUrl + 'topRatedMentors';

///---categories-with-mentor
String getCategoriesWithMentorURL = apiBaseUrl + 'categories/with/mentors';

///---book-appointment
String getScheduleAvailableDaysURL =
    apiBaseUrl + 'get-scheduled-available-days';
String getScheduleSlotsForMenteeUrl = apiBaseUrl + 'get-date-schedule';
String bookAppointmentUrl = apiBaseUrl + 'bookAppointment';

///---appointment-log-user
String getUserAllAppointmentsURL = apiBaseUrl + 'all-status-menteeAppointments';
String getConsultantAllAppointmentsURL =
    apiBaseUrl + 'all-status-mentorAppointments';
String fileAttachmentUrl = apiBaseUrl + 'appointment-attachments';
String mentorArchivedAppointmentUrl =
    apiBaseUrl + 'mentor/archieved-appointment';
String mentorUnArchivedAppointmentUrl =
    apiBaseUrl + 'mentor/unarchieved-appointment';

///---appointment-log-user
String getAppointmentsDetailURL = apiBaseUrl + 'appointmentDetails';

/// Blogs
String categoriesBlogUrl = apiBaseUrl + 'categoriesBlogs';
String blogCategoriesUrl = apiBaseUrl + 'blogCategories';
String createConsultantBlogUrl = apiBaseUrl + 'create_consultant_blog';
String consultantBlogUrl = apiBaseUrl + 'consultant_blogs';
String blogDetailUrl = apiBaseUrl + 'blogDetail';
String updateConsultantBlogUrl = apiBaseUrl + 'update_consultant_blog';
String deleteConsultantBlogUrl = apiBaseUrl + 'delete_consultant_blog';

/// wallet
String getWalletBalanceUrl = apiBaseUrl + 'check-balance';
String getWalletTransactionUrl = apiBaseUrl + 'wallet-history';
String walletDepositUrl = apiBaseUrl + 'deposit-wallet';
String walletDepositJazzcashUrl = apiBaseUrl + 'deposit-wallet-jazzcash';
String walletWithdrawUrl = apiBaseUrl + 'withdraw-request';
String walletPaymentUrl = apiBaseUrl + 'wallet-credit-transfer';
String markAsCompleteAppointmentUrl =
    apiBaseUrl + 'mark-appointment-as-complete';

/// rating
String createRatingUrl = apiBaseUrl + 'create-rating';
String getExistRatingUrl = apiBaseUrl + 'rating-exist-appointment';

///---agora
String agoraTokenUrl = apiBaseUrl + 'agoraToken';

///---send-message
String sendSMSUrl = apiBaseUrl + 'send-sms';

///---get-device-id
String fcmUpdateUrl = apiBaseUrl + 'fcm-store-token';
String fcmGetUrl = apiBaseUrl + 'fcm-get-tokens';

///---chat services
String fetchMessagesUrl = apiBaseUrl + 'fetch-messages';
String sendMessageUrl = apiBaseUrl + 'send-message';

///---download-invoice
String downloadAppointmentInvoiceForMenteeUrl =
    baseUrl + 'completed-appointment-invoice';

///---reset-password
String forgotPasswordUrl = apiBaseUrl + 'forget-password';
String newPasswordUrl = apiBaseUrl + 'reset-password';

/// Flutter wave

String flutterWaveUrl = apiBaseUrl + 'flutter-wave-after-payment';

/// Config Credential

String getConfigCredentialUrl = apiBaseUrl + 'notification_settings';

/// General Settings

String getGeneralSettingUrl = apiBaseUrl + 'general_settings';

/// Get Terms and Conditions

String getTermsConditionsUrl = apiBaseUrl + 'terms_conditions';
