import 'package:TNJewellers/utils/app_constants.dart';
import 'package:TNJewellers/utils/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> validateUser(String email) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*'
    };

    return await apiClient.getData("${AppConstants.configUrl}$email",
        headers: headers);
  }

  Future<Response?> login(
      {required String email, required String password}) async {
    var body = {"password": password, "username": email};

    return await apiClient.postLoginData(
      AppConstants.customerLogin,
      body,
    );
  }

  Future<Response?> signupVerification(Map<String, String> body) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return await apiClient.postData(AppConstants.customerSignup, body,
        headers: headers);
  }

  // Future<Response?> forgetPasswordOTP(String email,
  //     {required String isVerifyEmail}) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Accept': 'application/json'
  //   };

  //   return await apiClient.postData(AppConstants.forgotPasswordOTP,
  //       {"id": "0", "email": email, "channel": isVerifyEmail},
  //       headers: headers);
  // }

  // Future<Response?> changePassword({required String password}) async {
  //   var body = {'password': password};

  //   return await apiClient.postData(AppConstants.changePassword, body);
  // }

  // Future<Response?> getAntiForgeryToken() async {
  //   Map<String, String> headers = {'Accept': 'application/json'};
  //   return await apiClient.getData(AppConstants.getAntiForgeryToken,
  //       headers: headers);
  // }

  // Future<Response?> verifyPhoneOTP(String phoneNumber, String otp) async {
  //   return await apiClient.postData(
  //       AppConstants.verifyPhoneOTP, {'phone': phoneNumber, 'otp': otp});
  // }

  // Future<Response?> resendPhoneOTP(String phoneNumber) async {
  //   return await apiClient
  //       .postData(AppConstants.resendPhoneOTP, {'phone': phoneNumber});
  // }

  // // login
  // Future<Response?> getPhoneLoginOTP(String phoneNumber) async {
  //   return await apiClient
  //       .postData(AppConstants.getPhoneLoginOTP, {'phone': phoneNumber});
  // }

  // Future<Response?> verifyLoginPhoneOTP(String phoneNumber, String otp) async {
  //   return await apiClient.postData(
  //       AppConstants.verifyLoginPhoneOTP, {'phone': phoneNumber, 'otp': otp});
  // }

  // Future<Response?> verifyEmailOTP(String email, String otp) async {
  //   return await apiClient
  //       .postData(AppConstants.verifyEmailOTP, {"email": email, "otp": otp});
  // }

  // Future<Response?> resendEmailOTP(String email) async {
  //   return await apiClient
  //       .postData(AppConstants.resendEmailOTP, {'email': email});
  // }

  Future<void> saveUserNumberAndEmail(String number, String email) async {
    try {
      await sharedPreferences.setString(AppConstants.userEmail, email);
      await sharedPreferences.setString(AppConstants.userNumber, number);
    } catch (e) {
      rethrow;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.userNumber) ?? "";
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.userEmail) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.notification) ?? true;
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    await sharedPreferences.remove(AppConstants.userCountryCode);
    return await sharedPreferences.remove(AppConstants.userNumber);
  }

  Future<bool?> saveRefreshToken(String token) async {
    print(token);
    return await sharedPreferences.setString(AppConstants.refreshToken, token);
  }

  String getRefreshToken() {
    return sharedPreferences.getString(AppConstants.refreshToken) ?? "";
  }

  Future<bool?> saveUserToken(String token) async {
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool isSupplier() {
    return sharedPreferences.containsKey(AppConstants.isSupplier);
  }

  ///user address and language code should not be deleted
  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.clear();
    return true;
  }
}

class SingleTon {
  static final SingleTon qwerty = SingleTon._internal();

  factory SingleTon() {
    return qwerty;
  }

  SingleTon._internal();

  String ImageData = "";
  String LoginType = "";
  bool isPhoneVerified = false;
  bool isEmailVerified = false;
  bool isEstablishPhoneVerified = false;
  bool isEstablishEmailVerified = false;
  bool isRecurring = false;
}
