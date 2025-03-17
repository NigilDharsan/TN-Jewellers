import 'package:TNJewellers/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Orderbasicscreen extends StatefulWidget {
  const Orderbasicscreen({super.key});

  @override
  State<Orderbasicscreen> createState() => _OrderbasicscreenState();
}

class _OrderbasicscreenState extends State<Orderbasicscreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedType;
  String? selectedMaterial;
  String? audioFile;
  int currentStep = 1;

  void pickAudioFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        audioFile = result.files.single.name;
      });
    }
  }

  void nextStep() {
    setState(() {
      if (currentStep < 3) currentStep++;
    });
  }

  void previousStep() {
    setState(() {
      if (currentStep > 1) currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Order')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Create Order',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            currentStep == 1 ? brandPrimaryColor : Colors.grey,
                        child: Text('1', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            currentStep == 2 ? brandPrimaryColor : Colors.grey,
                        child: Text('2', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            currentStep == 3 ? brandPrimaryColor : Colors.grey,
                        child: Text('3', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (currentStep == 1) ...[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'Type', border: OutlineInputBorder()),
                      items: ['Type1', 'Type2'].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value as String?;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(onPressed: nextStep, child: Text('Next')),
                  ],
                ),
              ),
            ],
            if (currentStep == 2) ...[
              Column(
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Material', border: OutlineInputBorder()),
                    items: ['Material1', 'Material2'].map((mat) {
                      return DropdownMenuItem(value: mat, child: Text(mat));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMaterial = value as String?;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: Colors.green,
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Text('Summarize',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18))),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: previousStep, child: Text('Previous')),
                  ElevatedButton(onPressed: nextStep, child: Text('Next')),
                ],
              ),
            ],
            if (currentStep == 3) ...[
              Column(
                children: [
                  ElevatedButton(
                      onPressed: pickAudioFile,
                      child: Text('Upload Latest Audio File')),
                  if (audioFile != null) ...[
                    Text('Audio File: $audioFile'),
                    IconButton(icon: Icon(Icons.play_arrow), onPressed: () {}),
                    IconButton(icon: Icon(Icons.download), onPressed: () {}),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: previousStep, child: Text('Previous')),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
