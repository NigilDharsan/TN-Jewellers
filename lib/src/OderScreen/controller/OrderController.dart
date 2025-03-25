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
import 'package:intl/intl.dart';

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
    recordedFiles = [];
  }

  Future<Map<String, List<Map<String, String>>>> convertMultipleImagesToBytes(
      List<Map<String, dynamic>> imageFiles) async {
    List<Map<String, String>> imgByteList = [];
    List<Map<String, String>> videoByteList = [];

    for (var file in imageFiles) {
      Uint8List bytes = await File(file['path']).readAsBytes();
      String base64String = base64Encode(bytes);

      if (file['type'] == 'video') {
        videoByteList.add({"base64": base64String});
      } else {
        imgByteList.add({"base64": base64String});
      }
    }

    return {
      "videos": videoByteList,
      "images": imgByteList,
    };
  }

  Future<List<Map<String, String>>> convertMultipleAudioToBytes(
      List<String> audioFiles) async {
    List<Map<String, String>> audioByteList = [];

    for (var file in audioFiles) {
      Uint8List bytes = await File(file).readAsBytes();
      String base64String = base64Encode(bytes);

      audioByteList.add({"base64": base64String});
    }

    return audioByteList;
  }

  Future<bool> orderCreateResponse() async {
    _hideKeyboard();
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    int? daysToAdd = int.tryParse(
        deliveryDateController.text == "" ? "1" : deliveryDateController.text);
    DateTime futureDate = DateTime.now().add(Duration(days: daysToAdd!));
    String formattedDate = DateFormat('yyyy-MM-dd').format(futureDate);

    Map<String, List<Map<String, String>>> result =
        await convertMultipleImagesToBytes(selectedFiles);

    final audioArr = await convertMultipleAudioToBytes(recordedFiles);

    Map<String, dynamic> order_details = {
      "nick_name": firstnameController.text,
      "customized_ref_no": invoiceController.text,
      "customized_product_name": productTypeController.text,
      "customized_design_name": designController.text,
      "dimension": sizeController.text == ""
          ? "1"
          : sizeController.text + " " + inchController.text,
      "pieces": int.parse(
          quantityController.text == "" ? "0" : quantityController.text),
      "gross_wt": weightController.text,
      "less_wt": "0",
      "net_wt":
          "${double.parse(weightController.text) - double.parse(stoneWeightController.text == "" ? "0" : stoneWeightController.text)}",
      "customer_due_date": formattedDate,
      "customized_stone_name": stoneController.text,
      "customized_stone_wt": int.parse(
          stoneWeightController.text == "" ? "0" : stoneWeightController.text),
      "remarks": descriptionController.text,
      "stone_details": [],
      "order_images": result['images'],
      "order_videos": result['videos'],
      "order_voices": audioArr,
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
