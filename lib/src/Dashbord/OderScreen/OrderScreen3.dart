import 'package:TNJewellers/src/Dashbord/OderScreen/controller/OrderController.dart';
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
              SizedBox(height: 15),
              _buildUploadDocumentSection(),
              SizedBox(height: 15),
              _buildAudioSection(),
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
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 16),
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
  Widget _buildUploadDocumentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload Document',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(Icons.photo, color: Colors.blue),
            SizedBox(width: 5),
            Text('photo.01.jpg'),
            Icon(Icons.download, color: Colors.blue),
            Icon(Icons.remove_red_eye, color: Colors.grey),
          ],
        ),
      ],
    );
  }

// Widget for Audio Section
  Widget _buildAudioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Audio File',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Container(
          child: Row(
            children: [
              Icon(Icons.audiotrack, color: Colors.green),
              Text('audio.01.mp3'),
              Icon(Icons.download, color: Colors.blue),
              Icon(Icons.play_arrow, color: Colors.red),
            ],
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
