import 'dart:io';
import 'package:TNJewellers/src/Dashbord/OderScreen/OrderScreen2.dart';
import 'package:TNJewellers/src/Dashbord/OderScreen/StepIndicator.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class Orderbasicscreen extends StatefulWidget {
  const Orderbasicscreen({super.key});

  @override
  State<Orderbasicscreen> createState() => _OrderbasicscreenState();
}

class _OrderbasicscreenState extends State<Orderbasicscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController invoiceController = TextEditingController();
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  String? _audioPath;
  String? selectedAudioFile;
  String? selectedPhoto;
  String? selectedVideo;
  bool _isPlaying = false;
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
  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initRecorder();
  }
  Future<void> _initRecorder() async {
    await _recorder!.openRecorder();
    await Permission.microphone.request();
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    _audioPath = '${tempDir.path}/audio_record.wav';

    await _recorder!.startRecorder(toFile: _audioPath!);
    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() => _isRecording = false);
  }

  Future<void> _playAudio() async {
    if (_audioPath != null && !_isPlaying) {
      await _player!.startPlayer(
        fromURI: _audioPath!,
        whenFinished: () {
          setState(() => _isPlaying = false);
        },
      );
      setState(() => _isPlaying = true);
    }
  }

  void _deleteAudio() {
    setState(() {
      _audioPath = null;
    });
  }
  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }
  // Go to Next Screen
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
        if (fileName != null) ...[
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: white6,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(fileName, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget buildAudioAttachment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Record or Attach Audio", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        GestureDetector(
          onTap: _isRecording ? _stopRecording : _startRecording,
          child: Container(
            width: 200,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.black),
                SizedBox(width: 10),
                Text(_isRecording ? "Stop Recording" : "Start Recording", style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
          ),
        ),
        if (_audioPath != null) ...[
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Recorded Audio: ${_audioPath!.split('/').last}", overflow: TextOverflow.ellipsis)),
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.green),
                  onPressed: _playAudio,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: _deleteAudio,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}