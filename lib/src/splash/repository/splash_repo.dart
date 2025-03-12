import 'package:get/get.dart';
import 'package:TNJewellers/utils/app_constants.dart';
import 'package:TNJewellers/utils/data/provider/client_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getConfigData() async {
    Map<String, String> mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Response response =
        await apiClient.getData(AppConstants.configUrl, headers: mainHeaders);
    return response;
  }

  Future<bool> initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.theme)) {
      sharedPreferences.setBool(AppConstants.theme, false);
    }

    if (!sharedPreferences.containsKey(AppConstants.notification)) {
      sharedPreferences.setBool(AppConstants.notification, true);
    }
    return Future.value(true);
  }

  Future<bool> setSplashSeen(bool isSplashSeen) async {
    return await sharedPreferences.setBool(
        AppConstants.isOnBoardScreen, isSplashSeen);
  }

  Future<bool> setLoginMode(String isSupplier) async {
    return await sharedPreferences.setString(
        AppConstants.isSupplier, isSupplier);
  }

  String getLoginMode() {
    return sharedPreferences.getString(AppConstants.isSupplier) != null
        ? sharedPreferences.getString(AppConstants.isSupplier)!
        : '';
  }

  bool isSplashSeen() {
    return sharedPreferences.getBool(AppConstants.isOnBoardScreen) != null
        ? sharedPreferences.getBool(AppConstants.isOnBoardScreen)!
        : false;
  }

  Future<Response> subscribeEmail(String email) async {
    return await apiClient
        .postData(AppConstants.subscriptionUrl, {'email': email});
  }

  Future<bool> setNotificationTap(bool isTapNotification) async {
    return await sharedPreferences.setBool(
        AppConstants.isTapNotification, isTapNotification);
  }

  bool isTapNotification() {
    return sharedPreferences.getBool(AppConstants.isTapNotification) != null
        ? sharedPreferences.getBool(AppConstants.isTapNotification)!
        : false;
  }

  Future<bool> setNotificationChannel(String channelType) async {
    return await sharedPreferences.setString(
        AppConstants.notificationChannel, channelType);
  }

  String getNotificationChannel() {
    return sharedPreferences.getString(AppConstants.notificationChannel) != null
        ? sharedPreferences.getString(AppConstants.notificationChannel)!
        : '';
  }
}
