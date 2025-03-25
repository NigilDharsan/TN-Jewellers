import 'dart:async';

import 'package:TNJewellers/src/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:TNJewellers/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreenTwo extends StatefulWidget {
  const OrderScreenTwo({super.key});

  @override
  State<OrderScreenTwo> createState() => _OrderScreenTwoState();
}

class _OrderScreenTwoState extends State<OrderScreenTwo> {
  int currentStep = 2;
  String? selectedProduct;
  String? selectedMaterial;
  String? selectedDiamond;
  String? selectedStone;
  String? selectedquantity;
  int calculatedDays = 0;
  Timer? _timer;
  bool isDateDisplayed = false;

  void _startConversionTimer(String value) {
    _timer?.cancel(); // Cancel previous timer if any
    if (value.isEmpty) {
      setState(() {
        isDateDisplayed = false; // Reset state when text is cleared
      });
      return;
    }
    int? daysToAdd = int.tryParse(value);
    if (daysToAdd != null && daysToAdd > 0) {
      _timer = Timer(Duration(seconds: 2), () {
        DateTime futureDate = DateTime.now().add(Duration(days: daysToAdd));
        String formattedDate = DateFormat('yyyy-MM-dd').format(futureDate);
        setState(() {
          Get.find<OrderController>().deliveryDateController.text =
              formattedDate;
          isDateDisplayed = true;
        });
      });
    } else {
      setState(() {
        isDateDisplayed = false;
      });
    }
  }

  void _clearInput() {
    setState(() {
      Get.find<OrderController>().deliveryDateController.clear();
      isDateDisplayed = false;
    });
    _timer?.cancel(); // Cancel any running timer
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer
    super.dispose();
  }

  void nextStep() {}

  void previousStep() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return _buildBody(controller);
    });
  }

  Widget _buildBody(OrderController controller) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKeyOrder2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: buildInputField(
                        'Product',
                        "PRODUCT TYPE *",
                        controller.productTypeController,
                        "Please enter your product",
                        isRequired: true),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFieldRow(
                        'DESIGN', 'Design', controller.designController),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: buildInputField('12 Grams', "REQUIRED WEIGHT *",
                        controller.weightController, "Please enter your grams",
                        isRequired: true),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDimensionsRow(controller),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFieldRow(
                        'STONE', 'Stone', controller.stoneController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFieldRow('STONE WEIGHT', 'weight',
                        controller.stoneWeightController),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFieldRow('ORDER QUANTITY', 'Quantity',
                        controller.quantityController),
                  ),

                  const SizedBox(width: 10), // Spacing between elements
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EXPECTED DELIVERY DATE *",
                          style: Order2,
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color:
                                  brandGoldLightColor, // Light grey background
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white,
                                  width: 2), // White border with width 2
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.grey),
                                SizedBox(width: 2),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        controller.deliveryDateController,
                                    keyboardType: TextInputType.number,
                                    readOnly: isDateDisplayed,
                                    decoration: InputDecoration(
                                      labelText: "Enter number of days",
                                      labelStyle: TextStyle(
                                          color:
                                              brandGreySoftColor), // Set label text color to grey
                                      border: InputBorder.none,
                                      suffixIcon: isDateDisplayed
                                          ? IconButton(
                                              icon: Icon(Icons.clear),
                                              onPressed: _clearInput,
                                            )
                                          : null,
                                    ),
                                    validator: (value) {
                                      if ((value == null || value.isEmpty))
                                        return "Please enter delivery date";
                                    },
                                    onChanged: _startConversionTimer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownRow(String label, List<String> items,
      String? selectedValue, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Order2),
          const SizedBox(height: 5),
          _buildDropdown(items, selectedValue, onChanged),
        ],
      ),
    );
  }

  Widget _buildTextFieldRow(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Order2),
          const SizedBox(height: 5),
          _buildTextField(hint, controller),
        ],
      ),
    );
  }

  Widget _buildDimensionsRow(OrderController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SIZE', style: Order2),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                  child: _buildTextField('Ex:1.5', controller.sizeController)),
              const SizedBox(width: 10),
              Expanded(
                  child: _buildTextField('inch', controller.inchController)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Container(
      width: 200,
      child: DropdownButtonFormField(
        value: selectedValue ?? items.first,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none, // No border
          ),
          filled: true,
          fillColor: brandGoldLightColor, // Ensuring background remains grey
        ),
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: 1, // Allows better input for descriptions
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: brandGreySoftColor),
          filled: true,
          fillColor: brandGoldLightColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
