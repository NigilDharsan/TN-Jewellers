import 'package:TNJewellers/src/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreenThree extends StatefulWidget {
  const OrderScreenThree({super.key});

  @override
  State<OrderScreenThree> createState() => _OrderScreenThreeState();
}

class _OrderScreenThreeState extends State<OrderScreenThree> {
  String? audioFile;
  int currentStep = 3;

  void pickAudioFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        audioFile = result.files.single.name;
      });
    }
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildTextWithValue(
                        'Customer Name', controller.firstnameController.text),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextWithValue(
                        'Invoice Number', controller.invoiceController.text),
                  ),
                ],
              ),
              controller.selectedFiles.length != 0
                  ? _buildUploadDocumentSection(controller)
                  : SizedBox.shrink(),
              controller.recordedFiles.length != 0
                  ? _buildAudioSection(controller)
                  : SizedBox.shrink(),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextWithValue(
                        'Product Type', controller.productTypeController.text),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextWithValue(
                        'Design', controller.designController.text),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextWithValue(
                        'Required Weight', controller.weightController.text),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextWithValue('Size', '15 WX 12 H'),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextWithValue(
                        'Stone', controller.stoneController.text),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextWithValue(
                        'Stone Weight', controller.stoneWeightController.text),
                  ),
                ],
              ),
              SizedBox(height: 15),
              _buildTextWithValue('Expected Delivery Date',
                  controller.deliveryDateController.text),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextWithValue(
                        'Description', controller.descriptionController.text),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

// Widget for displaying label and value
  Widget _buildTextWithValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: order_style,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: order_style2,
        ),
      ],
    );
  }

  Widget _buildContentValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

// Widget for Upload Document Section
  Widget _buildUploadDocumentSection(OrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text('Upload Document', style: order_style),
        SizedBox(height: 5),
        SizedBox(
          height:
              controller.selectedFiles.length * 30, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.selectedFiles.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 30,
                child: Row(
                  children: [
                    Icon(Icons.photo, color: brandGreyColor),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        getLastFileNameWithExtension(
                            controller.selectedFiles[index]['path']),
                        style: order_style2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Icon(Icons.download, color: brandGreyColor),
                    Icon(Icons.remove_red_eye, color: brandGreyColor),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String getLastFileNameWithExtension(String filePaths) {
    if (filePaths.isNotEmpty) {
      return filePaths.split('/').last; // Extract file name with extension
    }
    return "No file selected";
  }

// Widget for Audio Section
  Widget _buildAudioSection(OrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text('Audio File', style: order_style),
        SizedBox(height: 5),
        SizedBox(
          height:
              controller.selectedFiles.length * 50, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.selectedFiles.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Icon(Icons.volume_up, color: brandGreyColor),
                    SizedBox(width: 5),
                    Text(
                        getLastFileNameWithExtension(
                            controller.recordedFiles[index]),
                        style: order_style2),
                    Icon(Icons.download, color: brandGreyColor),
                    Icon(Icons.play_arrow, color: brandGreyColor),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

// Widget for Description Content Box
  Widget _buildDescriptionContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildContentValue(
                  'Description',
                  'some text',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child:
                    _buildContentValue('Expected Delivery Date', '18/03/2025'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
