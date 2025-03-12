import 'package:TNJewellers/src/auth/signIn/onboard_screen.dart';
import 'package:TNJewellers/src/common/update_screen.dart';
import 'package:TNJewellers/src/splash/controller/splash_controller.dart';
import 'package:TNJewellers/src/splash/splash_screen.dart';
import 'package:TNJewellers/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/onboardscreen';

  static const String language = '/language';
  static const String signUp = '/sign-up';
  static const String signUpEstablish = '/sign-up-establish';
  static const String addLocation = '/add-location';
  static const String onBoardScreen = '/onboard-screen';
  static const String otpVerifyScreen = '/otpVerifyScreen';
  static const String dashboardscreen = '/dashboardscreen';
  static const String profilescreen = '/profilescreen';
  static const String editprofilescreen = '/editprofilescreen';

  static const String riderhistoryscreen = '/riderhistoryscreen';
  static const String ridecompletedetails = '/ridecompletedetails';
  static const String choosemapscreen = '/choosemapscreen';
  static const String bookingscreen = '/bookingscreen';
  static const String ridecompletedscreen = '/ridecompletedscreen';
  static const String userinfoscreen = '/userinfoscreen';
  static const String customercarescreen = '/customercarescreen';

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getSignInRoute() => onBoardScreen;
  static String getOtpVerifyRoute() => otpVerifyScreen;
  static String getDashBoardRoute() => dashboardscreen;
  static String getProfileRoute() => profilescreen;
  static String getEditProfileRoute() => editprofilescreen;
  static String getRiderHistoryRoute() => riderhistoryscreen;
  static String getRideCompleteDetailsRoute() => ridecompletedetails;
  static String getChooseMapRoute() => choosemapscreen;
  static String getBookingRoute() => bookingscreen;
  static String getRideCompleteRoute() => ridecompletedscreen;
  static String getUserInfoRoute() => userinfoscreen;
  static String getCustomerCareRoute() => customercarescreen;
  static String getAddLocation(int id, int accountId) =>
      '$addLocation?userId=$id&accountId=$accountId';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onBoardScreen, page: () => getRoute(const OnboardScreen())),

    // GetPage(
    //     name: addLocation,
    //     page: () => Update_Location_Sceen(
    //           isEditLocation: false,
    //           userId: Get.parameters['userId']!,
    //           accountId: Get.parameters['accountId'],
    //           addressItems: null,
    //           highlightedIndex: null,
    //         )),

    // GetPage(
    //     // binding: InitialBinding(),
    //     name: html,
    //     page: () => HtmlViewerScreen(
    //         htmlType: Get.parameters['page'] == 'terms_and_conditions'
    //             ? HtmlType.termsAndConditions
    //             : Get.parameters['page'] == 'privacy_policy'
    //                 ? HtmlType.privacyPolicy
    //                 : Get.parameters['page'] == 'help_and_support'
    //                     ? HtmlType.helpAndSupport
    //                     : Get.parameters['page'] == 'about_us'
    //                         ? HtmlType.aboutUs
    //                         : HtmlType.aboutUs)),
    // GetPage(
    //     name: update,
    //     page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),

    // GetPage(
    //     name: rateReview,
    //     page: () => getRoute(Get.arguments ?? const NotFoundScreen())),

    // GetPage(
    //     name: notLoggedScreen,
    //     page: () => NotLoggedInScreen(fromPage: Get.parameters['fromPage']!)),

    // GetPage(name: profile, page: () => const ProfileScreen()),
    // GetPage(name: driverprofile, page: () => const DriverProfileScreen()),
    // GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    // GetPage(name: editLocationScreen, page: () => const EditLocationDetails()),

    // GetPage(
    //     name: markYourLocationScreen,
    //     page: () => MarkLocationDetails(
    //         isAddLocation: Get.parameters['locationFlag'] == 'false',
    //         isEditLocation: false,
    //         addressAccountId: Get.parameters['accountId']!,
    //         userId: Get.parameters['userId']!,
    //         accountId: Get.parameters['accountId']!,
    //         physics: const ScrollPhysics())),
  ];

  static getRoute(Widget navigateTo) {
    double minimumVersion = 1;
    if (Get.find<SplashController>().configModel.data != null) {
      if (GetPlatform.isAndroid) {
        minimumVersion = double.parse(Get.find<SplashController>()
            .configModel
            .data!
            .androidVersion
            .latestApkVersion);
      } else if (GetPlatform.isIOS) {
        minimumVersion = double.parse(Get.find<SplashController>()
            .configModel
            .data!
            .iosVersion
            .latestIpaVersion);
      }
    }
    return Config.appVersion < minimumVersion
        ? const UpdateScreen(isUpdate: true)
        : navigateTo;
  }
}
