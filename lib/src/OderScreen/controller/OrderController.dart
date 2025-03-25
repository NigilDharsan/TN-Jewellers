import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:TNJewellers/src/OderScreen/model/OrderDetailsModel.dart';
import 'package:TNJewellers/src/OderScreen/model/OrderListModel.dart';
import 'package:TNJewellers/src/OderScreen/repository/OrderRepo.dart';
import 'package:TNJewellers/src/auth/controller/auth_controller.dart';
import 'package:TNJewellers/utils/Loader/loader_utils.dart';
import 'package:TNJewellers/utils/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  OrderListModel? orderListModel;
  OrderDetailsModel? orderDetailsModel;

  final formKeyOrder1 = GlobalKey<FormState>();
  final formKeyOrder2 = GlobalKey<FormState>();

  List<Map<String, dynamic>> selectedFiles = [];
  List<String> recordedFiles = [];

  var screenType = "orderone".obs; // Observable variable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String selectedProductID = "";

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

  clearCreateDate() {
    firstnameController.clear();
    invoiceController.clear();
    productTypeController.clear();
    designController.clear();
    weightController.clear();
    sizeController.clear();
    inchController.clear();
    stoneController.clear();
    stoneWeightController.clear();
    quantityController.clear();
    deliveryDateController.clear();
    descriptionController.clear();
    selectedFiles = [];
  }

  Future<List<Map<String, String>>> convertMultipleImagesToBytes(
      List<Map<String, dynamic>> imageFiles) async {
    List<Map<String, String>> byteList = [];

    for (dynamic file in imageFiles) {
      Uint8List bytes = await File(file['path']).readAsBytes();
      byteList.add({"base64": base64Encode(bytes)});
    }

    return byteList;
  }

  Future<bool> orderCreateResponse() async {
    _hideKeyboard();
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    List<Map<String, String>> imageBytesList =
        await convertMultipleImagesToBytes(selectedFiles);

    Map<String, dynamic> order_details = {
      "nick_name": firstnameController.text,
      "customized_ref_no": invoiceController.text,
      "customized_product_name": productTypeController.text,
      "customized_design_name": designController.text,
      "dimension": sizeController.text + " " + inchController.text,
      "pieces": int.parse(quantityController.text),
      "gross_wt": weightController.text,
      "less_wt": stoneWeightController.text,
      "net_wt":
          "${double.parse(weightController.text) - double.parse(stoneWeightController.text ?? "0")}",
      "customer_due_date": deliveryDateController.text,
      "customized_stone_name": stoneController.text,
      "customized_stone_wt": int.parse(stoneWeightController.text),
      "remarks": descriptionController.text,
      "stone_details": [],
      "order_images": imageBytesList,
      "order_videos": [],
      "order_voices": [],
      "charges_details": [],
      "attribute_details": [],
      "other_metal_details": []
    };

    Map<String, dynamic> body = {
      "order_branch": 2,
      "customer": Get.find<AuthController>().loginModel?.customer?.idCustomer,
      "order_type": 4,
      "added_through": 2,
      "order_details": [order_details]
    };

    Response? response = await orderRepo.orderCreation(body);
    if (response != null && response.statusCode == 200) {
      print("LOGIN RESPONSE ${response.body}");

      customSnackBar(response.body['message'], isError: false);

      clearCreateDate();

      _isLoading = false;
      loaderController.showLoaderAfterBuild(_isLoading);
      update();

      return true;
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
    return false;
  }

  Future<bool> getOrderListResponse() async {
    _hideKeyboard();
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);

    Map<String, dynamic> body = {
      "id_customer":
          Get.find<AuthController>().loginModel?.customer?.idCustomer,
    };
    Response? response = await orderRepo.orderList(body);
    if (response != null && response.statusCode == 200) {
      orderListModel = OrderListModel.fromJson(response.body);

      print("LOGIN RESPONSE ${response.body}");

      _isLoading = false;
      loaderController.showLoaderAfterBuild(_isLoading);
      update();

      return true;
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
    return false;
  }

  Future<bool> getOrderDetailsResponse() async {
    _hideKeyboard();
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);

    Response? response = await orderRepo.orderDetails(selectedProductID);
    if (response != null && response.statusCode == 200) {
      orderDetailsModel = OrderDetailsModel.fromJson(response.body);

      print("LOGIN RESPONSE ${response.body}");

      _isLoading = false;
      loaderController.showLoaderAfterBuild(_isLoading);
      update();

      return true;
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
    return false;
  }
}
