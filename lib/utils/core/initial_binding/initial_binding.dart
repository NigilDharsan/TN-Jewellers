import 'package:TNJewellers/src/auth/controller/auth_controller.dart';
import 'package:TNJewellers/src/auth/repository/auth_repo.dart';
import 'package:TNJewellers/src/splash/controller/splash_controller.dart';
import 'package:TNJewellers/src/splash/repository/splash_repo.dart';
import 'package:TNJewellers/utils/config.dart';
import 'package:TNJewellers/utils/core/theme/controller/theme_controller.dart';
import 'package:TNJewellers/utils/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialBinding extends Bindings {
  onInit() {
    initControllers();
  }

  @override
  void dependencies() async {
    //common controller
    Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

    Get.lazyPut(() => SplashController(
        splashRepo:
            SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AuthController(
        authRepo:
            AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));

    // Get.lazyPut(() => SignalRServices());
    // Get.lazyPut(() => StatusController());
    // Get.lazyPut(() => InAppCallController(
    //     inAppCallRepo: InAppCallRepo(apiClient: Get.find())));
  }
}

Future<void> initControllers() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences); // Register it in GetX

  Get.lazyPut(() =>
      ApiClient(appBaseUrl: Config.baseUrl, sharedPreferences: Get.find()));

  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  Get.lazyPut(() => SplashController(
      splashRepo:
          SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
}
