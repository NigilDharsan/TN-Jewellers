import 'dart:async';

import 'package:TNJewellers/src/Dashbord/TabScreen.dart';
import 'package:TNJewellers/src/auth/model/LoginModel.dart';
import 'package:TNJewellers/src/auth/repository/auth_repo.dart';
import 'package:TNJewellers/utils/Loader/loader_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool? _acceptTerms = false;
  bool hasMoreItems = true;
  bool cameFromApp = false;

  bool get isLoading => _isLoading;

  bool? get acceptTerms => _acceptTerms;

  RxBool isEditLocation = false.obs;

  void toggleEditLocation(bool isEdit) {
    isEditLocation.value = isEdit;
  }

  final formKey = GlobalKey<FormState>();
  final formKeySignUP = GlobalKey<FormState>();

  bool obscurePassword = true;

  ///TextEditingController for signUp screen
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

// Model

  LoginModel? loginModel;

  dynamic countryDialCodeForSignup;

  ///textEditingController for signIn screen
  var signInEmailController = TextEditingController();
  var signInPasswordController = TextEditingController();
  dynamic countryDialCodeForSignIn;

  ///TextEditingController for forgot password
  var contactNumberController = TextEditingController();
  final String _mobileNumber = '';

  String get mobileNumber => _mobileNumber;

  late String _emailAddress = '';
  String get emailAddress => _emailAddress;

  ///TextEditingController for new pass screen
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  ///TextEditingController for change pass screen
  final currentPasswordControllerForChangePasswordScreen =
      TextEditingController();
  final newPasswordControllerForChangePasswordScreen = TextEditingController();
  final confirmPasswordControllerForChangePasswordScreen =
      TextEditingController();

  ///ADD Account
  var accountNumber = TextEditingController();
  var accountHolderName = TextEditingController();
  var reaccountNumber = TextEditingController();
  var ifscCode = TextEditingController();
  var branch = TextEditingController();

  ///form validation key

  String? selectedEstablishmentName;
  String? selectedOptionalAreaName;
  String? selectedEstablishmentId;
  String? selectedOptionalAreaId;

  String? contryCodeVal;
  String? contryCodeValId;
  String? fundAccountId;
  String? bankName;

  int? selectedLocationIndex;

  final TextEditingController searchController = TextEditingController();
  String? sessionToken;
  bool isLocationSelected = false;
  var expandedIndex = (-1).obs;

  void toggleExpanded(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }

  bool isExpanded(int index) => expandedIndex.value == index;

  @override
  void onInit() {
    super.onInit();
    nameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    contactNumberController.text = '';
    newPasswordController.text = '';
    confirmNewPasswordController.text = '';
    contactNumberController.text = '';
    signInEmailController.text = '';
    signInPasswordController.text = '';

    newPasswordControllerForChangePasswordScreen.text = '';
    confirmPasswordControllerForChangePasswordScreen.text = '';

    // getUCOGetInfo();
    // getUserProfile(false);
    // getAddressList(1);
    update();
  }

  _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  bool _isValidAccount() {
    return accountNumber.value.text == reaccountNumber.value.text;
  }

  bool _isValidPassword() {
    return passwordController.value.text ==
        confirmPasswordController.value.text;
  }

  bool _isValidResetPassword() {
    return newPasswordControllerForChangePasswordScreen.value.text ==
        confirmPasswordControllerForChangePasswordScreen.value.text;
  }

  Future<bool> validateUser(String username) async {
    _hideKeyboard();
    _isLoading = true;
    update();

    Response? response = await authRepo.validateUser(username);
    if (response != null && response.statusCode == 200) {
      _emailAddress = response.body['email'];
      update();

      return true;
    }

    _isLoading = false;
    update();

    return false;
  }

  Future<void> login() async {
    _hideKeyboard();
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
    Response? response = await authRepo.login(
        email: signInEmailController.value.text,
        password: signInPasswordController.value.text);
    if (response != null && response.statusCode == 200) {
      loginModel = LoginModel.fromJson(response.body);

      print("LOGIN RESPONSE ${response.body}");
      String accessToken = response.body['token'];
      await authRepo.saveUserToken(accessToken);
      signInEmailController.clear();
      signInPasswordController.clear();
      Get.offAll(TabsScreen()); // Perform login action
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> signupVerification() async {
    _hideKeyboard();
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    Map<String, String> body = {
      "firstname": nameController.value.text,
      "lastname": "null",
      // "company_name": companyController.value.text,
      "mobile": mobileController.value.text,
      "gst_number": gstController.value.text,
      "pan_number": panController.value.text,
      "email": emailController.value.text,
      "confirm_password": confirmPasswordController.value.text,
      "cus_type": "2",
      "registered_through": "2"
    };

    Response? response = await authRepo.signupVerification(body);
    if (response != null && response.statusCode == 200) {
      print("LOGIN RESPONSE ${response.body}");
      nameController.clear();
      companyController.clear();
      panController.clear();
      gstController.clear();
      mobileController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      emailController.clear();

      Get.back(); // Perform login action
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  // //forgot password
  // Future<void> forgetPasswordOTP({required String isVerifyEmail}) async {
  //   if (emailController.value.text.isEmpty) return;
  //   _hideKeyboard();
  //   _isLoading = true;
  //   update();

  //   if (await validateUser(emailController.text.trim())) {
  //     Response? response = await authRepo.forgetPasswordOTP(_emailAddress,
  //         isVerifyEmail: isVerifyEmail);
  //     if (response?.statusCode == 201) {
  //       final arguments = {
  //         'email': emailController.value.text,
  //       };

  //       _verificationCode = '';
  //       _otp = '';
  //       customSnackBar(response?.body['message'], isError: false);
  //       // Get.toNamed(RouteHelper.forgotPasswordOTPVerificationScreen,
  //       //     arguments: arguments);
  //     }
  //   }

  //   _isLoading = false;
  //   update();
  // }

  String _verificationCode = '';
  String _otp = '';

  String get otp => _otp;

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if (_verificationCode.isNotEmpty) {
      _otp = _verificationCode;
    }
    update();
  }

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;
  int selectedLangIndex = 0;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms!;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool isSupplier() {
    return authRepo.isSupplier();
  }

  Future<bool> clearSharedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    return authRepo.clearSharedData();
  }

  void saveUserNumberAndEmail(String number, String email) {
    authRepo.saveUserNumberAndEmail(number, email);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserEmail() {
    return authRepo.getUserEmail();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getRefreshToken() {
    return authRepo.getRefreshToken();
  }

  bool isValidPassword(String password) {
    String pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  Future<void> editProfile() async {
    _hideKeyboard();
    _isLoading = true;
    update();

    // UserModel? retrievedUserModel = await AuthRepo.getUserModel();
    // if (retrievedUserModel != null) {
    //   ProfileData user = ProfileData(
    //     id: retrievedUserModel.id,
    //     firstName: firstNameController.text,
    //     lastName: lastNameController.text,
    //     name: establishNameController.text,
    //     countryId: countriesData?[0].id ?? "",
    //     accountTypeId: restaurantIdController.text,
    //     industry: selectedEstablishmentId,
    //     email: establishEmailController.text,
    //     mobile: establishContactController.text,
    //     mobileDialCode: '+91',
    //     isEstablishmentRequired: isEstablishment,
    //     gstinNumber: gstinNumberController.text,
    //   );
    //   print("ESTABLISHMNET ID ${selectedEstablishment?.id}");
    //   final response = await authRepo.editProfile(user);
    //   if (response != null && response.statusCode == 200) {
    //     await getUserProfile(false);
    //     Get.back();
    //     customSnackBar("Profile_Updated_Successfully".tr, isError: false);
    //   }
    // }

    _isLoading = false;
    update();
  }

  Timer? _refreshTokenTimer;

  void startRefreshTokenTimer() {
    _refreshTokenTimer?.cancel();
    _refreshTokenTimer = Timer.periodic(Duration(minutes: 10), (timer) {});
  }

  void stopRefreshTokenTimer() {
    _refreshTokenTimer?.cancel();
  }

  String? _refreshToken;
  bool _isRefreshing = false;
}
