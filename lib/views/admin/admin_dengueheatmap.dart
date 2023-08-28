import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AdminDengueHeatMapPage extends StatefulWidget {
  const AdminDengueHeatMapPage({super.key});

  @override
  State<AdminDengueHeatMapPage> createState() => _AdminDengueHeatMapPageState();
}

class _AdminDengueHeatMapPageState extends State<AdminDengueHeatMapPage> {
  void _uploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      final filePath = result.files.single.path!;
      // Send this filePath to the backend for further processing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dengue Care'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadFile,
          child: const Text('Upload Excel File'),
        ),
      ),
    );
  }
}
