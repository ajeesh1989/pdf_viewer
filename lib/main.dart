import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(const PdfViewerApp());
}

class PdfViewerApp extends StatelessWidget {
  const PdfViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PdfViewerPage(),
      theme: ThemeData.dark(),
    );
  }
}

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  File? selectedPdf;

  Future<void> pickAndDisplayPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedPdf = File(result.files.single.path!);
      });
    }
  }

  void resetPdfViewer() {
    setState(() {
      selectedPdf = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetPdfViewer, // Call the reset function
          ),
        ],
      ),
      body: Center(
        child: selectedPdf != null
            ? PDFView(
                filePath: selectedPdf!.path,
                enableSwipe: true, // Add other PDFView properties as needed
                onPageChanged: (page, total) {},
              )
            : const Text(
                'No PDF selected.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAndDisplayPdf,
        tooltip: 'Pick PDF',
        child: const Icon(
          Icons.picture_as_pdf,
        ),
      ),
    );
  }
}
