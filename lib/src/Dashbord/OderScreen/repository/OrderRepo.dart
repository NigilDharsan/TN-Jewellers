import 'package:TNJewellers/utils/app_constants.dart';
import 'package:TNJewellers/utils/data/provider/client_api.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> orderCreation(Map<String, dynamic> body) async {
    String? accessToken = sharedPreferences.getString(AppConstants.token);

    final headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Token $accessToken'
    };
    return await apiClient.postData(AppConstants.orderCreate, body,
        headers: headers);
  }
}
