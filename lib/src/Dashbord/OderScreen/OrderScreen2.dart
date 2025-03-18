import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'OrderScreen3.dart';
import 'StepIndicator.dart';

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
  int currentStep = 2;
  String? selectedProduct;
  String? selectedMaterial;
  String? selectedDiamond;
  String? selectedStone;
  String? selectedquantity;
  DateTime? selectedDate;
  int calculatedDays = 0;

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(Duration(days: 365)), // Limit to 1 year ahead
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        calculatedDays = picked.difference(today).inDays; // Calculate days from today
      });
    }
  }


  void nextStep() {
    Get.to(() => const OrderScreenThree());
  }

  void previousStep() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Order')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text('Create New Order',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            StepIndicator(currentStep: currentStep),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildDropdownRow(
                      'PRODUCT TYPE', ['Ring', 'Gold'], selectedProduct,
                      (value) {
                    setState(() => selectedProduct = value);
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDropdownRow(
                      'MATERIAL', ['Gold', 'Ring'], selectedMaterial, (value) {
                    setState(() => selectedMaterial = value);
                  }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTextFieldRow(
                      'REQUIRED WEIGHT', '12 Grams', weightController),
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
                  child: _buildDropdownRow(
                      'STONE REQUIRED', ['Diamond', 'Ruby'], selectedDiamond,
                      (value) {
                    setState(() => selectedDiamond = value);
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextFieldRow(
                      'STONE WEIGHT', '3 Grams', stoneWeightController),
                ),
              ],
            ),
            _buildDropdownRow(
                'STONE QUALITY CODE', ['XX234', 'XXX678'], selectedStone,
                (value) {
              setState(() => selectedStone = value);
            }),
            Row(
              children: [
                Expanded(
                  child: _buildDropdownRow(
                    'ORDER QUANTITY',
                    ['2 Pieces', '3 Pieces'],
                    selectedquantity,
                        (value) {
                      setState(() => selectedquantity = value);
                    },
                  ),
                ),
                const SizedBox(width: 10), // Spacing between elements
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EXPECTED DELIVERY DATE",
                        style: Order2,
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                              SizedBox(width: 10),
                              Text(
                                selectedDate == null
                                    ? "Select Date"
                                    : "${DateFormat('').format(selectedDate!)} ($calculatedDays days)",
                                style: TextStyle(fontSize: 16, color: Colors.black),
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
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: brandPrimaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: brandPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: nextStep,
                child: const Text(
                  'Next',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: white4),
                ),
              ),
            ),
          ],
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
          Text(label,
              style: Order2),
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
          Text(label,
              style: Order2),
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
          const Text('DIMENSIONS (MM)',
              style: Order2),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: _buildTextField('Width', widthController)),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField('Height', heightController)),
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
