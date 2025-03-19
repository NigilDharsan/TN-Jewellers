import 'dart:io';
import 'package:TNJewellers/src/Dashbord/OderScreen/OrderScreen2.dart';
import 'package:TNJewellers/src/Dashbord/OderScreen/StepIndicator.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:collection/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:record/record.dart';

class Orderbasicscreen extends StatefulWidget {
  const Orderbasicscreen({super.key});

  @override
  State<Orderbasicscreen> createState() => _OrderbasicscreenState();
}

class _OrderbasicscreenState extends State<Orderbasicscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController invoiceController = TextEditingController();
  String? selectedAudioFile;
  String? selectedPhoto;
  String? selectedVideo;
  int currentStep = 1;

  // Pick File Function
  void pickFile(String type) async {
    FileType fileType;
    if (type == 'audio') {
      fileType = FileType.audio;
    } else if (type == 'video') {
      fileType = FileType.video;
    } else {
      fileType = FileType.image;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      setState(() {
        if (type == 'audio') {
          selectedAudioFile = result.files.single.path;
        } else if (type == 'video') {
          selectedVideo = result.files.single.path;
        } else {
          selectedPhoto = result.files.single.path;
        }
      });
    }
  }


  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  bool _isPaused = false;
  String? _currentFilePath;
  List<String> _recordedFiles = [];
  int _elapsedTime = 0;
  Timer? _timer;
  final TextEditingController _filenameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _loadRecordedFiles();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }
  Future<void> _startRecording() async {
    if (_isRecording) return;
    Directory dir = await getApplicationDocumentsDirectory();
    String filename = _filenameController.text.trim().isEmpty
        ? "Audio_${DateTime.now().millisecondsSinceEpoch}"
        : _filenameController.text.trim();
    _currentFilePath = '${dir.path}/$filename.mp4';
    if (await _recorder.hasPermission()) {
      await _recorder.start(const RecordConfig(), path: _currentFilePath!);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime++;
        });
      });

      setState(() {
        _isRecording = true;
        _isPaused = false;
      });
    }
  }
  Future<void> _pauseRecording() async {
    if (!_isRecording || _isPaused) return;

    await _recorder.pause();
    _timer?.cancel();
    setState(() {
      _isPaused = true;
    });
  }
  Future<void> _resumeRecording() async {
    if (!_isRecording || !_isPaused) return;
    await _recorder.resume();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
    setState(() {
      _isPaused = false;
    });
  }
  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    await _recorder.stop();
    _timer?.cancel();

    setState(() {
      _isRecording = false;
      _isPaused = false;
      _elapsedTime = 0;
      if (_currentFilePath != null) {
        _recordedFiles.add(_currentFilePath!);
      }
    });

    _loadRecordedFiles();
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
  Future<void> _loadRecordedFiles() async {
    Directory dir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = dir.listSync();

    setState(() {
      _recordedFiles = files
          .where((file) => file.path.endsWith(".mp4")) // Filter only MP4 files
          .map((file) => file.path)
          .toList();

      _recordedFiles.sort((a, b) =>
          compareNatural(a.split('/').last, b.split('/').last)
      );
    });
  }
  Future<void> _openFile(String filePath) async {
    await OpenFile.open(filePath);
  }



  void nextStep() {
    if (_formKey.currentState!.validate()) {
      Get.to(() => OrderScreenTwo());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Order')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Create New Order',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              StepIndicator(currentStep: currentStep),
              SizedBox(height: 20),
              _buildTextField('Enter your nickname', 'NICK NAME', firstnameController,false),
              SizedBox(height: 10),
              _buildTextField('Enter Invoice/Ref No', 'INVOICE/REF NO', invoiceController,false),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: buildAttachmentSection(
                      text: "Upload Photo",
                      label: "Photo",
                      icon: Icons.camera_alt,
                      onPick: () => pickFile('image'),
                      fileName: selectedPhoto,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: buildAttachmentSection(
                      text: "Upload Video",
                      label: "Video",
                      icon: Icons.video_library,
                      onPick: () => pickFile('video'),
                      fileName: selectedVideo,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: buildAudioAttachment(),
              ),
              _buildDescriptionContainer(),
              SizedBox(height: 20),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  // Text Input Field
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
          ),),
      ],
    );
  }


  // Attachment Section
  Widget buildAttachmentSection({
    required String label,
    required String text,
    required IconData icon,
    required VoidCallback onPick,
    String? fileName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onPick,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white70,
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
              children: [Icon(icon), SizedBox(width: 10), Text(label)],
            ),
          ),
        ),
      ],
    );
  }

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



  Widget buildAudioAttachment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[350],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    _isRecording
                        ? (_isPaused ? "Paused" : "Recording... $_elapsedTime sec")
                        : "Attach Audio",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              _isRecording
                  ? Row(
                children: [
                  IconButton(
                    icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause, color: Colors.black, size: 25),
                    onPressed: _isPaused ? _resumeRecording : _pauseRecording,
                  ),
                  IconButton(
                    icon: Icon(Icons.stop, color: Colors.black, size: 25),
                    onPressed: _stopRecording,
                  ),
                ],
              )
                  : GestureDetector(
                onTap: _startRecording,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.mic, color: Colors.black, size: 25),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200, // Set a fixed height to avoid Expanded inside Column issue
          child: ListView.builder(
            itemCount: _recordedFiles.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.volume_up_rounded, color: Colors.deepPurple),
                  title: Text(_recordedFiles[index].split('/').last), // Show file name
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_arrow, color: Colors.green),
                        onPressed: () => _openFile(_recordedFiles[index]),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteRecording(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}