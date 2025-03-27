import 'dart:io';

import 'package:TNJewellers/src/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderScreenThree extends StatefulWidget {
  const OrderScreenThree({super.key});

  @override
  State<OrderScreenThree> createState() => _OrderScreenThreeState();
}

class _OrderScreenThreeState extends State<OrderScreenThree> {
  String? audioFile;
  int currentStep = 3;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isCurrentPlaying = false;
  String? currentPlayingFile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Listen for completion of audio playback
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isCurrentPlaying = false;
        currentPlayingFile = null; // Clear current playing file
        isLoading = false; // Stop loading indicator
      });
    });
  }

  void pickAudioFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        audioFile = result.files.single.name;
      });
    }
  }

  Future<void> _downloadFile(BuildContext context, String filePath) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      if (!(await Permission.storage.isGranted)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Storage permission denied!")),
        );
        return;
      }
    }
    try {
      Directory? directory = await getExternalStorageDirectory();
      String newPath = "";
      if (directory != null) {
        List<String> paths = directory.path.split("/");
        for (int i = 1; i < paths.length; i++) {
          String folder = paths[i];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/Download"; // Saving to Download folder
        directory = Directory(newPath);
      }

      if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }
      String fileName = filePath.split('/').last;
      File sourceFile = File(filePath);
      File newFile = File("${directory?.path}/$fileName");
      await sourceFile.copy(newFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download successful!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download failed: ${e.toString()}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _playSegment(String filePath) async {
    if (currentPlayingFile != filePath) {
      setState(() {
        isLoading = true; // Start loading indicator
      });
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
      isLoading = false; // Stop loading indicator
    });
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
              controller.selectedFiles.isNotEmpty
                  ? _buildUploadDocumentSection(controller)
                  : SizedBox.shrink(),
              controller.recordedFiles.isNotEmpty
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
                      IconButton(
                        icon: Icon(Icons.download, color: brandGreyColor),
                        onPressed: () {
                          _downloadFile(
                              context, controller.selectedFiles[index]['path']);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          controller.selectedFiles[index]['obscureimage'] ??
                                  true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: brandGreyColor,
                        ),
                        onPressed: () {
                          showImageViewer(
                            context,
                            FileImage(
                              File(controller.selectedFiles[index]['path']),
                            ),
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
          height: controller.recordedFiles.isNotEmpty
              ? controller.recordedFiles.length * 50
              : 50, // Ensure a minimum height
          child: controller.recordedFiles.isEmpty
              ? Center(child: Text("No recorded files available"))
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      controller.recordedFiles.length, // Use the same list
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
                            style: order_style2,
                          ),
                          IconButton(
                            icon: Icon(Icons.download, color: brandGreyColor),
                            onPressed: () {
                              _downloadFile(
                                  context, controller.recordedFiles[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              isCurrentPlaying &&
                                      currentPlayingFile ==
                                          controller.recordedFiles[index]
                                  ? Icons.stop
                                  : Icons.play_arrow,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              if (isCurrentPlaying &&
                                  currentPlayingFile ==
                                      controller.recordedFiles[index]) {
                                _stopPlayback();
                              } else {
                                _playSegment(controller.recordedFiles[index]);
                              }
                            },
                          ),
                          SizedBox(
                            width: 60, // Fixed width to prevent shifting
                            child: (isCurrentPlaying &&
                                    currentPlayingFile ==
                                        controller.recordedFiles[index])
                                ? LinearProgressIndicator(
                                    minHeight: 5,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue), // Change color as needed
                                  )
                                : Container(
                                    height:
                                        2, // Placeholder Line when not playing
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                          ),
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
