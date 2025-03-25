import 'package:TNJewellers/src/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderDetailsScreen extends StatefulWidget {
  const MyOrderDetailsScreen({super.key});

  @override
  State<MyOrderDetailsScreen> createState() => _MyOrderDetailsScreeneState();
}

class _MyOrderDetailsScreeneState extends State<MyOrderDetailsScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("ORDER DETAILS"),
      ),
      body: GetBuilder<OrderController>(
          initState: (state) =>
              Get.find<OrderController>().getOrderDetailsResponse(),
          builder: (controller) {
            return controller.isLoading
                ? SizedBox.shrink()
                : _buildBody(controller);
          }),
    );
  }

  Widget _buildBody(OrderController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRingValue(
                '', controller.orderDetailsModel!.data?.productName ?? ""),
            SizedBox(height: 10),
            _buildcontainerValue(
                'Status', controller.orderDetailsModel!.data?.status ?? ""),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildTextWithValue(
                      'Customer Name',
                      controller.orderDetailsModel!.data?.customerNickName ??
                          ""),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextWithValue('Invoice Number',
                      controller.orderDetailsModel!.data?.orderNo ?? ""),
                ),
              ],
            ),
            (controller.orderDetailsModel!.data?.images?.length ?? 0) != 0
                ? _buildUploadDocumentSection(controller)
                : SizedBox.shrink(),
            (controller.orderDetailsModel!.data?.audios?.length ?? 0) != 0
                ? _buildAudioSection()
                : SizedBox.shrink(),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildTextWithValue('Description',
                      controller.orderDetailsModel!.data?.remarks ?? ""),
                ),
                Expanded(
                  child: _buildTextWithValue(
                      'Expected Delivery Date',
                      controller.orderDetailsModel!.data?.expDeliveryDate ??
                          ""),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTextWithValue('Product Type',
                      controller.orderDetailsModel!.data?.orderType ?? ""),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextWithValue('Design',
                      controller.orderDetailsModel!.data?.designName ?? ""),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildTextWithValue(
                      'Required Weight',
                      controller.orderDetailsModel!.data?.reqWt.toString() ??
                          ""),
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
                  child: _buildTextWithValue('Stone',
                      controller.orderDetailsModel!.data?.stoneName ?? ""),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextWithValue(
                      'Stone Weight',
                      controller.orderDetailsModel!.data?.stoneWt.toString() ??
                          ""),
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

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

  Widget _buildcontainerValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: order_style,
        ),
        SizedBox(height: 10),
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3), color: Colors.green),
          child: Center(
            child: Text(
              value,
              style: order_container,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRingValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: order_style3,
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
        Row(
          children: [
            Icon(Icons.photo, color: brandGreyColor),
            SizedBox(width: 5),
            SizedBox(
                height: 100,
                width: 150,
                child: Image.network(
                  controller.orderDetailsModel!.data?.images?[0].image ?? "",
                  fit: BoxFit.cover,
                ) // Hides the widget if no image is available
                ),
            SizedBox(width: 5),
            Icon(Icons.download, color: brandGreyColor),
            SizedBox(width: 5),
            Icon(Icons.remove_red_eye, color: brandGreyColor),
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
        SizedBox(height: 15),
        Text('Audio File', style: order_style),
        SizedBox(height: 5),
        Container(
          child: Row(
            children: [
              Icon(Icons.volume_up_rounded, color: brandGreyColor),
              SizedBox(width: 5),
              Text(
                'audio.01.mp4',
                style: order_style2,
              ),
              SizedBox(width: 5),
              Icon(Icons.download, color: brandGreyColor),
              SizedBox(width: 5),
              Icon(Icons.play_arrow, color: brandGreyColor),
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
