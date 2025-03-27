import 'package:TNJewellers/src/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MyOrderDetailsScreen extends StatefulWidget {
  const MyOrderDetailsScreen({super.key});

  @override
  State<MyOrderDetailsScreen> createState() => _MyOrderDetailsScreeneState();
}

class _MyOrderDetailsScreeneState extends State<MyOrderDetailsScreen> {
  String? audioFile;
  int currentStep = 3;
  bool isCurrentPlaying = false; // Tracks if audio is currently playing
  String? currentPlayingFile;
  bool _isImageVisible = true; // Variable to track image visibility

  final AudioPlayer _audioPlayer = AudioPlayer(); // Initialize AudioPlayer

  Future<void> _playSegment(String filePath) async {
    if (currentPlayingFile != filePath) {
      await _audioPlayer.stop(); // Stop any currently playing audio
      await _audioPlayer
          .play(DeviceFileSource(filePath)); // Play the selected audio file
      setState(() {
        isCurrentPlaying = true;
        currentPlayingFile = filePath; // Update current playing file
      });
    }
  }

  Future<void> _stopPlayback() async {
    await _audioPlayer.stop();
    setState(() {
      isCurrentPlaying = false;
      currentPlayingFile = null; // Clear current playing file
    });
  }

  Future<void> _downloadFile(BuildContext context, String filePath) async {
    var status =
        await Permission.storage.request(); // Request storage permissions
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
                ? _buildAudioSection(controller)
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
        SizedBox(
          height: (controller.orderDetailsModel?.data?.images?.length ?? 0) *
              30, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.orderDetailsModel?.data?.images?.length,
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
                          "photo.${index}.jpg",
                          style: order_style2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.download, color: brandGreyColor),
                        onPressed: () {
                          _downloadFile(
                              context, controller.selectedFiles[index]['path']);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: brandGreyColor,
                        ),
                        onPressed: () {
                          showImageViewer(
                            context,
                            Image.network(controller.orderDetailsModel?.data
                                        ?.images![index].image ??
                                    "")
                                .image,
                            swipeDismissible: true,
                            doubleTapZoomable: true,
                          );
                        },
                      ),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
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
          height: controller.orderDetailsModel!.data?.audios?.isNotEmpty == true
              ? 100
              : 50,
          child: controller.orderDetailsModel!.data?.audios?.isEmpty == true
              ? Center(child: Text("No recorded files available"))
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      controller.orderDetailsModel!.data?.audios?.length ?? 0,
                  itemBuilder: (context, index) {
                    final audioFile = controller
                            .orderDetailsModel!.data!.audios![index].audio ??
                        "";

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isCurrentPlaying &&
                                      currentPlayingFile == audioFile
                                  ? Icons.volume_up_rounded
                                  : Icons.volume_mute,
                              color: brandGreyColor,
                            ),
                            onPressed: () {
                              if (isCurrentPlaying &&
                                  currentPlayingFile == audioFile) {
                                _stopPlayback();
                              } else {
                                _playSegment(audioFile);
                              }
                            },
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Audio.001.mp3', // Pass the audio file path as an argument
                            style: order_style2,
                          ),
                          IconButton(
                            icon: Icon(Icons.download, color: brandGreyColor),
                            onPressed: () {
                              _downloadFile(context,
                                  audioFile); // Provide the correct audio file
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              isCurrentPlaying &&
                                      currentPlayingFile == audioFile
                                  ? Icons.stop
                                  : Icons.play_arrow,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              if (isCurrentPlaying &&
                                  currentPlayingFile == audioFile) {
                                _stopPlayback();
                              } else {
                                _playSegment(
                                    audioFile); // Provide the correct audio file
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }

  String getLastFileNameWithExtension(int nextNumber) {
    if (nextNumber >= 0) {
      // Generate a new file name based on the next number
      return "Audio_${nextNumber.toString().padLeft(3, '0')}.mp4"; // Format: Audio_001.mp4
    }
    return "No file selected"; // Default message when no valid number is provided
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
