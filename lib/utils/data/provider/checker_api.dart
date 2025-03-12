import 'package:get/get.dart';
import 'package:TNJewellers/utils/widgets/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode != 200) {
      // Get.find<AuthController>().clearSharedData();
      // Get.offAllNamed(RouteHelper.getSignInRoute('splash'));
    } else {
      customSnackBar("${response.statusCode!}".tr);
    }
  }
}
