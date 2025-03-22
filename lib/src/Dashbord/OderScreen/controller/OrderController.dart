import 'package:TNJewellers/src/Dashbord/OderScreen/repository/OrderRepo.dart';
import 'package:TNJewellers/utils/Loader/loader_utils.dart';
import 'package:TNJewellers/utils/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  var screenType = "orderone".obs; // Observable variable
  bool _isLoading = false;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController invoiceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController productTypeController = TextEditingController();
  final TextEditingController designController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final TextEditingController stoneController = TextEditingController();
  final TextEditingController stoneWeightController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();

  _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  Future<void> orderCreateResponse() async {
    _hideKeyboard();
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    Map<String, dynamic> order_details = {
      "nick_name": "Vishnu",
      "customized_ref_no": "",
      "customized_product_name": "Ring",
      "customized_design_name": "Antique",
      "dimension": "13",
      "pieces": 8,
      "gross_wt": "10.000",
      "less_wt": "0",
      "net_wt": "10",
      "customer_due_date": "2024-03-20",
      "customized_stone_name": "stone1",
      "customized_stone_wt": 30,
      "remarks": "From sds",
      "stone_details": [],
      "order_images": [],
      "order_videos": [],
      "order_voices": [],
      "charges_details": [],
      "attribute_details": [],
      "other_metal_details": []
    };

    Map<String, dynamic> body = {
      "order_branch": 2,
      "customer": 1,
      "order_type": 4,
      "added_through": 2,
      "order_details": [order_details]
    };

    Response? response = await orderRepo.orderCreation(body);
    if (response != null && response.statusCode == 200) {
      print("LOGIN RESPONSE ${response.body}");
      customSnackBar("Order Placed Successfully", isError: false);
      Get.back();
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }
}
