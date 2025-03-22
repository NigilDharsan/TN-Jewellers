class AppConstants {
  static const String appName = 'Hello Taxi';

  static const String configUrl = 'configs';
  static const String onBoards = 'on-boards';
  static const String socialLoginUrl = 'social-login';

  static const String customerLogin = 'customersettings/customer_login/';
  static const String customerSignup = 'customersettings/customer_signup/';

  static const String orderCreate = 'orders/order/create/';

  static const String isSupplier = 'is_supplier';
  static const String notificationChannel = 'channel_type';
  static const String theme = 'lms_theme';
  static const String token = 'lms_token';
  static const String refreshToken = 'refresh_token';
  static const String countryCode = 'lms_country_code';
  static const String languageCode = 'lms_language_code';
  static const String languagename = 'lms_language_name';
  static const String userPassword = 'lms_user_password';
  static const String userNumber = 'lms_user_number';
  static const String userEmail = 'lms_user_email';
  static const String userCountryCode = 'lms_user_country_code';
  static const String notification = 'lms_notification';
  static const String isOnBoardScreen = 'lms_on_board_seen';
  static const String isTapNotification = 'tap_on_notification';
  static const String topic = 'customer';
  static const String localizationKey = 'X-localization';
  static const String configUri = '/api/v1/customer/config';
  static const String socialRegisterUrl = '/api/v1/auth/social-register';
  static const String tokenUrl = '/api/v1/customer/update/fcm-token';
  static const String notificationCount = '/api/v1/customer/notification';
  static const String resetPasswordUrl = '/api/v1/customer/notification';
  static const String customerInfoUrl = '/api/v1/customer/notification';
  static const String updateProfileUrl = '/api/v1/customer/notification';
  static const String verifyTokenUrl = '/api/v1/customer/notification';
  static const String finishCollectionUrl = 'api/itinerary-uco-details';
  static const String containerDetailListUrl = 'api/containers/itinerary-drop';
  static const String collectOilUrl = 'api/itinerary-uco-details/collect-oil';
  static const String plannedDistanceURL = 'api/itinerary-distance-logs';
  static const String driverContainerCountUrl =
      'api/containers/planned-collected';
  static const String finishcollectOilUrl =
      'api/itinerary-uco-details/finish-collect-oil';
  static const String removeUcoUrl = 'api/itinerary-uco-details/remove-uco';
  static const String addNewContainerUrl = 'api/containers';

  static const String pages = '/api/v1/customer/config/pages';

  static const String verifyPhoneUrl = '/api/v1/customer/config/pages';
  static const String subscriptionUrl = '/api/v1/customer/config/pages';
  static const String getChannelList = 'get-channel-list';
  static const String getConversation = 'get-conversation';
  static const String searchHistory = 'search-history';

  // PAYMENT
  static const String paymentHistoryUrl = '/api/supplier-payments/search?';

  //ITINERARY COMPLETED
  static const String startTripValidationUrl =
      'api/uco-schedule-itineraries/{itineraryId}/driver-journey-start';
  static const String ucoScheduleCancelUrl = 'api/cancellation-remarks';
  static const String updateWorkFlowStatusUrl = 'api/update-workflow-status';
  static const String itineraryRejectUrl =
      'api/uco-schedule-itineraries/{itineraryId}/update-reject-itinerary';

  static const String arrivedAtWarehouse = 'api/uco-schedule-itineraries';
  static const String ucoScheduleItineraryUrl = 'api/uco-schedule-itineraries';

  static const String ucoScheduleWHRouteUrl =
      'api/uco-schedule-itinerary-route-wf-audits/';
  static const String ucoSchedulePickUpRouteUrl =
      'api/uco-schedule-itinerary-route-wf-audits/';

  //SmartFlo Call API
  static const String inAPPClickToCallSupportUrl = "click_to_call_support";
  static const String inAPPClickToCallUrl = "click_to_call";

  //Byufuel Call API
  static const String calllogsUrl = "api/call-logs";
}
