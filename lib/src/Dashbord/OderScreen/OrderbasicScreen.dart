import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:TNJewellers/src/Dashbord/OderScreen/OrderScreen2.dart';
import 'package:TNJewellers/src/Dashbord/OderScreen/OrderScreen3.dart';
import 'package:TNJewellers/src/Dashbord/OderScreen/StepIndicator.dart';
import 'package:TNJewellers/src/Dashbord/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController invoiceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
  List<String> photoPaths = [];
  List<String> videoPaths = [];
  List<VideoPlayerController> videoControllers = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _loadRecordedFiles();
    _loadMedia();
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
    String filename = "Audio_${DateTime.now().millisecondsSinceEpoch}.mp4";
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
  void _downloadRecording(String filePath) {
    print("Downloading: $filePath");
  }
  // Future<void> _playSegment(String filePath, int seconds) async {
  //   if (_isPlaying) {
  //     await _player.stopPlayer();
  //     setState(() {
  //       _isPlaying = false;
  //       _playbackProgress = 0.0;
  //       _currentFilePath = null;
  //     });
  //   }
  //
  //   _currentFilePath = filePath; // Set currently playing file
  //   _selectedDuration = Duration(seconds: seconds);
  //
  //   await _player.startPlayer(
  //     fromURI: filePath,
  //     codec: Codec.aacMP4,
  //     whenFinished: () {
  //       setState(() {
  //         _isPlaying = false;
  //         _playbackProgress = 0.0;
  //         _currentFilePath = null;
  //       });
  //     },
  //   );
  //
  //   setState(() => _isPlaying = true);
  //
  //   double interval = 0.1; // Update every 100ms
  //   int totalUpdates = (seconds / interval).ceil();
  //   int currentUpdate = 0;
  //
  //   Timer.periodic(Duration(milliseconds: (interval * 1000).toInt()), (timer) {
  //     if (!_isPlaying || currentUpdate >= totalUpdates) {
  //       timer.cancel();
  //       _player.stopPlayer();
  //       setState(() {
  //         _isPlaying = false;
  //         _playbackProgress = 0.0;
  //         _currentFilePath = null;
  //       });
  //     } else {
  //       setState(() {
  //         _playbackProgress = currentUpdate / totalUpdates;
  //       });
  //       currentUpdate++;
  //     }
  //   });
  // }

  Future<void> pickMedia(bool isPhoto, bool isCamera) async {
    XFile? pickedFile;
    if (isCamera) {
      pickedFile = isPhoto
          ? await _imagePicker.pickImage(source: ImageSource.camera)
          : await _imagePicker.pickVideo(source: ImageSource.camera);
    } else {
      if (isPhoto) {
        List<XFile>? pickedImages = await _imagePicker.pickMultiImage();
        if (pickedImages != null) {
          for (var file in pickedImages) {
            _addMedia(file.path, isPhoto);
          }
        }
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.video,
          allowMultiple: true,
        );
        if (result != null) {
          for (var file in result.files) {
            if (file.path != null) {
              _addMedia(file.path!, isPhoto);
            }
          }
        }
      }
    }

    if (pickedFile != null) {
      _addMedia(pickedFile.path, isPhoto);
    }
  }

  void _addMedia(String path, bool isPhoto) {
    setState(() {
      selectedFiles.add({'path': path, 'type': isPhoto ? 'image' : 'video'});
      if (!isPhoto) {
        VideoPlayerController controller =
        VideoPlayerController.file(File(path))
          ..initialize().then((_) {
            setState(() {});
          });
        videoControllers.add(controller);
      }
    });
    _saveMedia();
  }

  Future<void> _saveMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedFiles', json.encode(selectedFiles));
  }

  Future<void> _loadMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedFiles = prefs.getString('selectedFiles');
    if (storedFiles != null) {
      List<dynamic> files = json.decode(storedFiles);
      setState(() {
        selectedFiles = files.cast<Map<String, dynamic>>();
        for (var file in selectedFiles) {
          if (file['type'] == 'video') {
            VideoPlayerController controller =
            VideoPlayerController.file(File(file['path']))
              ..initialize().then((_) {
                setState(() {});
              });
            videoControllers.add(controller);
          }
        }
      });
    }
  }

  void _clearSingleMedia(int index) {
    setState(() {
      if (selectedFiles[index]['type'] == 'video') {
        videoControllers[index].dispose();
        videoControllers.removeAt(index);
      }
      selectedFiles.removeAt(index);
    });
    _saveMedia();
  }

  void _showMediaOptions(bool isCamera) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera, color: Colors.blue),
              title: const Text("Take Photo"),
              onTap: () {
                Navigator.pop(context);
                pickMedia(true, isCamera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: Colors.blue),
              title: const Text("Take Video"),
              onTap: () {
                Navigator.pop(context);
                pickMedia(false, isCamera);
              },
            ),
          ],
        );
      },
    );
  }

  void _showuploadMediaOptions(bool isCamera) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera, color: Colors.blue),
              title: const Text("Photo"),
              onTap: () {
                Navigator.pop(context);
                pickMedia(true, isCamera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: Colors.blue),
              title: const Text("Video"),
              onTap: () {
                Navigator.pop(context);
                pickMedia(false, isCamera);
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
      Get.find<OrderController>().screenType.value = "ordertwo";
      setState(() {
        currentStep = 2;
      });
    } else if (Get.find<OrderController>().screenType.value == "ordertwo") {
      Get.find<OrderController>().screenType.value = "orderthree";
      setState(() {
        currentStep = 3;
      });
    } else {
      Get.back();
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<OrderController>().screenType.value = "orderone";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Order')),
      body: GetBuilder<OrderController>(builder: (controller) {
        return _buildBody(controller);
      }),
    );
  }

  Widget _buildBody(OrderController controller) {
    return
       Column(
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _buildTextField('Enter your nickname', 'NICK NAME',
                      firstnameController, false),
                  SizedBox(height: 10),
                  _buildTextField('Enter Invoice/Ref No',
                      'INVOICE/REF NO', invoiceController, false),
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
                          onPick: () => _showMediaOptions(true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildAttachmentSection(
                          label: "Upload image\nvideo",
                          icon: Icons.link,
                          onPick: () =>
                              _showuploadMediaOptions(false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "RECORD/ATTACH AUDIO *",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: brandGreyColor),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 100 * selectedFiles.length.toDouble(),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(selectedFiles.length,
                              (index) {
                            return buildMediaItem(
                                selectedFiles[index]['path'],
                                selectedFiles[index]['type'] == 'video',
                                index);
                          }),
                    ),
                  ),
                  buildAudioAttachment(
                    isRecording: _isRecording,
                    elapsedTime: '$_elapsedTime',
                    recordedFiles: _recordedFiles,
                    onRecord: _startRecording,
                    onStop: _stopRecording,// Fixed typo
                    onDelete: _deleteRecording,
                    onPlay: _playSegment,
                    onDownload: _downloadRecording,
                    currentFilePath: _currentFilePath ?? "",
                    isPlaying: _isPlaying,
                    playbackProgress: _playbackProgress,
                  ),
                  _buildDescriptionContainer(
                    'Description', // Label outside
                    'Some text description change the customer looking for retailers',
                    // Hint inside the box
                    descriptionController,
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
              child: const Text(
                'Next',
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

  Widget _buildTextField(String hintName, String label,
      TextEditingController controller, bool isPassword) {
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
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintName,
                hintStyle: const TextStyle(color: brandGreySoftColor),
                filled: true,
                fillColor: brandGoldLightColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isVideo &&
                  videoControllers.length > index &&
                  videoControllers[index].value.isInitialized
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
                    VideoPlayer(videoControllers[index]),
                    if (!videoControllers[index].value.isPlaying)
                      const Icon(Icons.play_circle_fill,
                          color: Colors.white, size: 40),
                  ],
                ),
              )
                  : Image.file(File(path), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 0,
            right: 1,
            child: IconButton(
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 40,
              ),
              onPressed: () => _clearSingleMedia(index),
            ),
          ),
        ],
      ),
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
              border: Border.all(color: Colors.white, width: 2), // White border with width 2
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
              return Column(
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: Icon(
                        _isPlaying &&
                            _currentFilePath == filePath
                            ? Icons.stop
                            : Icons.play_arrow,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () {
                        if (_isPlaying &&
                            _currentFilePath == filePath) {
                          _stopRecording();
                        } else {
                          _playSegment(filePath); // Plays for 5 seconds
                        }
                      },
                    ),
                    title: Text(filePath.split('/').last, overflow: TextOverflow.ellipsis),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.download, color: Colors.blue),
                          onPressed: () => onDownload(filePath),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => onDelete(index),
                        ),
                      ],
                    ),
                  ),
                  if (isPlaying && currentFilePath == filePath)
                    LinearProgressIndicator(value: playbackProgress),
                ],
              );
            },
          ),
      ],
    );
  }
}
