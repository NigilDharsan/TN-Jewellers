import 'dart:async';

import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreenTwo extends StatefulWidget {
  const OrderScreenTwo({super.key});

  @override
  State<OrderScreenTwo> createState() => _OrderScreenTwoState();
}

class _OrderScreenTwoState extends State<OrderScreenTwo> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController stoneWeightController = TextEditingController();
  final TextEditingController inputController = TextEditingController();

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
          inputController.text = formattedDate;
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
      inputController.clear();
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextFieldRow(
                    'PRODUCT TYPE *', 'Product', stoneWeightController),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextFieldRow(
                    'DESIGN', 'Design', stoneWeightController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextFieldRow(
                    'REQUIRED WEIGHT *', '12 Grams', weightController),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDimensionsRow(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child:
                    _buildTextFieldRow('STONE', 'Stone', stoneWeightController),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextFieldRow(
                    'STONE WEIGHT', 'weight', stoneWeightController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextFieldRow(
                    'ORDER QUANTITY', 'Quantity', stoneWeightController),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.grey),
                            SizedBox(width: 2),
                            Expanded(
                              child: TextFormField(
                                controller: inputController,
                                keyboardType: TextInputType.number,
                                readOnly: isDateDisplayed,
                                // If date is shown, disable typing
                                decoration: InputDecoration(
                                  labelText: "Enter number of days",
                                  border: InputBorder.none,
                                  suffixIcon: isDateDisplayed
                                      ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: _clearInput,
                                        )
                                      : null,
                                ),
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

  Widget _buildDimensionsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SIZE', style: Order2),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: _buildTextField('Ex:1.5', widthController)),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField('inch', heightController)),
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
          fillColor: white5, // Ensuring background remains grey
        ),
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // No border
        ),
        filled: true,
        fillColor: white5, // Ensuring background remains grey
      ),
    );
  }
}
