import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:TNJewellers/src/OderScreen/OrderCreateStep2.dart';
import 'package:TNJewellers/src/OderScreen/OrderCreateStep3.dart';
import 'package:TNJewellers/src/OderScreen/StepIndicator.dart';
import 'package:TNJewellers/src/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/widgets/custom_text_field.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Orderbasicscreen extends StatefulWidget {
  const Orderbasicscreen({super.key});

  @override
  State<Orderbasicscreen> createState() => _OrderbasicscreenState();
}

class _OrderbasicscreenState extends State<Orderbasicscreen> {
  String? selectedAudioFile;
  String? selectedPhoto;
  String? selectedVideo;
  int currentStep = 1;
  final AudioRecorder _recorder = AudioRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _currentFilePath;
  List<String> _recordedFiles = [];
  int _elapsedTime = 0;
  Timer? _timer;
  double _playbackProgress = 0.0;
  Duration? _selectedDuration;
  List<Map<String, dynamic>> selectedFiles = [];
  final ImagePicker _imagePicker = ImagePicker();
  List<String> videoPaths = [];
  List<VideoPlayerController> videoControllers = [];
  final ImagePicker picker = ImagePicker();
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _loadRecordedFiles();
    // _loadMedia();
    _player.openPlayer();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<void> _loadRecordedFiles() async {
    Directory dir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = dir.listSync();
    setState(() {
      _recordedFiles = files
          .where((file) => file.path.endsWith(".mp4"))
          .map((file) => file.path)
          .toList();
      _recordedFiles
          .sort((a, b) => compareNatural(a.split('/').last, b.split('/').last));
    });
  }

  Future<void> _deleteRecording(int index) async {
    File file = File(_recordedFiles[index]);
    if (await file.exists()) {
      await file.delete();
    }
    setState(() {
      _recordedFiles.removeAt(index);
    });
    _loadRecordedFiles();
  }

  Future<void> _startRecording() async {
    if (_isRecording) return;
    Directory dir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = dir.listSync();
    int nextNumber = 1;
    List<int> existingNumbers = [];
    for (var file in files) {
      String name = file.path.split('/').last;
      RegExp regex = RegExp(r'Audio_(\d+)\.mp4');
      Match? match = regex.firstMatch(name);
      if (match != null) {
        existingNumbers.add(int.parse(match.group(1)!));
      }
    }
    if (existingNumbers.isNotEmpty) {
      nextNumber = existingNumbers.reduce((a, b) => a > b ? a : b) + 1;
    }
    String filename = "Audio_${nextNumber.toString().padLeft(3, '0')}.mp4";
    _currentFilePath = '${dir.path}/$filename';
    if (await _recorder.hasPermission()) {
      await _recorder.start(const RecordConfig(), path: _currentFilePath!);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime++;
        });
      });
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;
    await _recorder.stop();
    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _elapsedTime = 0;
      if (_currentFilePath != null) {
        _recordedFiles.add(_currentFilePath!);
      }
    });
    _loadRecordedFiles();
  }

  Future<void> _playSegment(String filePath) async {
    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() {
        _isPlaying = false;
        _playbackProgress = 0.0;
        _currentFilePath = null;
      });
      return;
    }

    _currentFilePath = filePath;
    setState(() => _isPlaying = true);

    await _player.startPlayer(
      fromURI: filePath,
      codec: Codec.aacMP4,
      whenFinished: () {
        setState(() {
          _isPlaying = false;
          _playbackProgress = 0.0;
          _currentFilePath = null;
        });
      },
    );

    double interval = 0.1;
    int totalUpdates = (5 / interval).ceil();
    int currentUpdate = 0;

    Timer.periodic(Duration(milliseconds: (interval * 1000).toInt()), (timer) {
      if (!_isPlaying || currentUpdate >= totalUpdates) {
        timer.cancel();
        _player.stopPlayer();
        setState(() {
          _isPlaying = false;
          _playbackProgress = 0.0;
          _currentFilePath = null;
        });
      } else {
        setState(() {
          _playbackProgress = currentUpdate / totalUpdates;
        });
        currentUpdate++;
      }
    });
  }

  void _stopPlayback() {
    _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _currentFilePath = null;
      _playbackProgress = 0.0;
    });
  }

  void _downloadRecording(String filePath) {
    print("Downloading: $filePath");
  }

  Future<void> _saveMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedFiles', json.encode(selectedFiles));
  }

  Future<void> pickMultipleImages() async {
    List<XFile>? images = await picker.pickMultiImage();
    setState(() {
      for (var image in images) {
        selectedFiles.add({
          'path': image.path,
          'type': 'image',
        });
      }
    });
    _saveMedia();
  }

  Future<void> capturePhoto() async {
    XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        selectedFiles.add({
          'path': photo.path,
          'type': 'image',
        });
      });
    }
    _saveMedia();
  }

  Future<void> pickVideo() async {
    XFile? file = await picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      _addVideo(file.path);
    }
    _saveMedia();
  }

  Future<void> recordVideo() async {
    XFile? file = await picker.pickVideo(source: ImageSource.camera);
    if (file != null) {
      _addVideo(file.path);
    }
    _saveMedia();
  }

  void _addVideo(String path) {
    setState(() {
      selectedFiles.add({
        'path': path,
        'type': 'video',
      });

      VideoPlayerController controller = VideoPlayerController.file(File(path))
        ..initialize().then((_) {
          setState(() {});
        });

      videoControllers.add(controller);
    });
    _saveMedia();
  }

  void _clearSingleMedia(int index) {
    setState(() {
      if (selectedFiles[index]['type'] == 'video') {
        videoControllers[index].dispose();
        videoControllers.removeAt(index);
      }
      selectedFiles.removeAt(index);
    });
  }

  void _showUploadMediaOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text("Capture Photo"),
              onTap: () {
                Navigator.pop(context);
                capturePhoto();
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: Colors.red),
              title: const Text("Record Video"),
              onTap: () {
                Navigator.pop(context);
                recordVideo();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMediaOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.blue),
              title: const Text("Select Photos"),
              onTap: () {
                Navigator.pop(context);
                pickMultipleImages();
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library, color: Colors.red),
              title: const Text("Select Video"),
              onTap: () {
                Navigator.pop(context);
                pickVideo();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> nextStep() async {
    // await Get.find<OrderController>().orderCreateResponse();

    if (Get.find<OrderController>().screenType.value == "orderone") {
      if (Get.find<OrderController>().formKeyOrder1.currentState!.validate()) {
        // if (selectedFiles.isEmpty) {
        //   Get.snackbar("Error", "Please upload at least one photo or video",
        //       backgroundColor: Colors.red, colorText: Colors.white);
        //   return;
        // } else if (_recordedFiles.isEmpty) {
        //   Get.snackbar("Error", "Please record at least one audio file",
        //       backgroundColor: Colors.red, colorText: Colors.white);
        //   return;
        // } else {
        Get.find<OrderController>().selectedFiles = selectedFiles;
        Get.find<OrderController>().recordedFiles = _recordedFiles;
        Get.find<OrderController>().screenType.value = "ordertwo";
        setState(() {
          currentStep = 2;
        });
        // }
      } else {
        return;
      }
    } else if (Get.find<OrderController>().screenType.value == "ordertwo") {
      if (Get.find<OrderController>().formKeyOrder2.currentState!.validate()) {
        Get.find<OrderController>().screenType.value = "orderthree";
        setState(() {
          currentStep = 3;
        });
      }
    } else {
      final results = await Get.find<OrderController>().orderCreateResponse();
      if (results) {
        Navigator.pop(context); // Close the dialog

        Get.back();
      }
    }
  }

  void _showExitConfirmation(BuildContext context, OrderController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Exit"),
          content:
              Text("Are you sure you want to go back? All data will be lost."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.clearCreateDate(); // Clear form or data
                Navigator.pop(context); // Close the dialog
                Get.back();
              },
              child: Text("Yes, Exit", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    Get.find<OrderController>().screenType.value = "orderone";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Order'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Get.find<OrderController>().screenType.value == "orderthree") {
              Get.find<OrderController>().screenType.value = "ordertwo";
              setState(() {
                currentStep = 2;
              });
            } else if (Get.find<OrderController>().screenType.value ==
                "ordertwo") {
              Get.find<OrderController>().screenType.value = "orderone";
              setState(() {
                currentStep = 1; //orderone
              });
            } else {
              _showExitConfirmation(context, Get.find<OrderController>());
            }
          },
        ),
      ),
      body: GetBuilder<OrderController>(builder: (controller) {
        return _buildBody(controller);
      }),
    );
  }

  Widget _buildBody(OrderController controller) {
    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: StepIndicator(currentStep: currentStep),
        ),
        controller.screenType.value == "ordertwo"
            ? OrderScreenTwo()
            : controller.screenType.value == "orderthree"
                ? OrderScreenThree()
                : Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: controller.formKeyOrder1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInputField(
                                'Enter your nickname',
                                "NICK NAME",
                                controller.firstnameController,
                                "Please enter your name",
                                isRequired: false),
                            SizedBox(height: 10),
                            buildInputField(
                                'Enter Invoice/Ref No',
                                "INVOICE/REF NO",
                                controller.invoiceController,
                                "",
                                isRequired: false),
                            SizedBox(height: 20),
                            Text(
                              "UPLOAD PHOTO REFERENCE *",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: brandGreyColor),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: buildAttachmentSection(
                                    label: "Take a Camera\nPhoto",
                                    icon: Icons.camera_alt_outlined,
                                    onPick: () => _showUploadMediaOptions(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: buildAttachmentSection(
                                    label: "Upload image\nvideo",
                                    icon: Icons.link,
                                    onPick: () => _showMediaOptions(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (selectedFiles.isNotEmpty)
                              SizedBox(
                                height: 100,
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    selectedFiles.length,
                                    (index) {
                                      return buildMediaItem(
                                        selectedFiles[index]['path'],
                                        selectedFiles[index]['type'] == 'video',
                                        index,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            Text(
                              "RECORD/ATTACH AUDIO *",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: brandGreyColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            buildAudioAttachment(
                              isRecording: _isRecording,
                              elapsedTime: '$_elapsedTime',
                              recordedFiles: _recordedFiles,
                              onRecord: _startRecording,
                              onStop: _stopRecording, // Fixed typo
                              onDelete: _deleteRecording,
                              onPlay: _playSegment,
                              onDownload: _downloadRecording,
                              currentFilePath: _currentFilePath ?? "",
                              isPlaying: _isPlaying,
                              playbackProgress: _playbackProgress,
                            ),
                            _buildDescriptionContainer(
                              'Description *', // Label outside
                              'Some text description change the customer looking for retailers',
                              // Hint inside the box
                              controller.descriptionController,
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
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
              child: Text(
                currentStep == 3 ? 'Place Order' : "Next",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: white4),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }

  Widget buildAttachmentSection({
    required String label,
    required IconData icon,
    required VoidCallback onPick,
  }) {
    return GestureDetector(
      onTap: onPick, // Triggers when tapping anywhere on the container
      child: Container(
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
          readOnly: true,
          decoration: InputDecoration(
            hintText: label,
            prefixIcon: Icon(icon, color: Colors.black),
            hintStyle: const TextStyle(color: brandGreySoftColor),
            filled: true,
            fillColor: brandGoldLightColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onTap: onPick, // Triggers when tapping inside the TextField
        ),
      ),
    );
  }

  Widget buildMediaItem(String path, bool isVideo, int index) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isVideo
              ? (videoControllers.length > index &&
                      videoControllers[index].value.isInitialized)
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          if (videoControllers[index].value.isPlaying) {
                            videoControllers[index].pause();
                          } else {
                            videoControllers[index].play();
                          }
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio:
                                videoControllers[index].value.aspectRatio,
                            child: VideoPlayer(videoControllers[index]),
                          ),
                          if (!videoControllers[index].value.isPlaying)
                            const Icon(Icons.play_circle_fill,
                                color: Colors.white, size: 40),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator())
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(File(path), fit: BoxFit.cover),
                ),
        ),
        Positioned(
          top: 0,
          right: 1,
          child: IconButton(
            icon:
                const Icon(Icons.cancel_outlined, color: Colors.red, size: 30),
            onPressed: () => _clearSingleMedia(index),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionContainer(
    String label,
    String hintText,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: brandGreyColor),
        ),
        const SizedBox(height: 5),
        Container(
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
            maxLines: 3, // Allows better input for descriptions
            decoration: InputDecoration(
              hintText: hintText,
              // Hint text inside box
              hintStyle: const TextStyle(color: brandGreySoftColor),
              // brandGreySoftColor
              filled: true,
              fillColor: brandGoldLightColor,
              // brandGoldLightColor
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if ((value == null || value.isEmpty))
                return "Please enter description";
            },
          ),
        ),
      ],
    );
  }

  Widget buildAudioAttachment({
    required bool isRecording,
    required String elapsedTime,
    required List<String> recordedFiles,
    required VoidCallback onRecord,
    required VoidCallback onStop,
    required void Function(int index) onDelete,
    required void Function(String filePath) onPlay,
    required void Function(String filePath) onDownload,
    required String currentFilePath,
    required bool isPlaying,
    required double playbackProgress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: isRecording ? onStop : onRecord, // Stop recording if active
          child: Container(
            width: 170,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: brandGoldLightColor, // Inside fill color
              borderRadius: BorderRadius.circular(10), // Inner border radius
              border: Border.all(
                  color: Colors.white, width: 2), // White border with width 2
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isRecording ? Icons.stop : Icons.mic, color: Colors.black),
                const SizedBox(width: 10),
                Text(
                  isRecording ? "$elapsedTime sec" : "ATTACH AUDIO",
                  style: TextStyle(color: brandGreySoftColor),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (recordedFiles.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: recordedFiles.length,
            itemBuilder: (context, index) {
              String filePath = recordedFiles[index];
              bool isCurrentPlaying =
                  _isPlaying && _currentFilePath == filePath;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isCurrentPlaying
                          ? Icons.volume_up_rounded
                          : Icons.volume_mute,
                      color: brandGreyColor,
                    ),
                    onPressed: () {
                      if (isCurrentPlaying) {
                        _stopPlayback();
                      } else {
                        _playSegment(filePath);
                      }
                    },
                  ),
                  Text(
                    filePath.split('/').last,
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    icon: const Icon(Icons.download, color: brandGreyColor),
                    onPressed: () => onDownload(filePath),
                  ),
                  IconButton(
                    icon: Icon(
                      isCurrentPlaying ? Icons.stop : Icons.play_arrow,
                      color: brandGreyColor,
                    ),
                    onPressed: () {
                      if (isCurrentPlaying) {
                        _stopPlayback();
                      } else {
                        _playSegment(filePath);
                      }
                    },
                  ),
                  SizedBox(
                    width: 100, // Fixed width to prevent shifting
                    child: Stack(
                      children: [
                        if (isCurrentPlaying)
                          LinearProgressIndicator(
                            value: playbackProgress,
                            minHeight: 5,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(brandGreyColor),
                          ),
                        // Invisible when not playing (prevents UI shifting)
                        if (!isCurrentPlaying)
                          GestureDetector(
                            onTap: () => onDownload(filePath), // Click event
                            child: Container(
                              height: 2, // Thickness of the line
                              decoration: BoxDecoration(
                                color: textColor, // Line color
                                borderRadius: BorderRadius.circular(
                                    1), // Optional: rounded edges
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Download Button (Fixed Position)

                  IconButton(
                    icon: const Icon(Icons.delete, color: brandGreyColor),
                    onPressed: () => onDelete(index),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
