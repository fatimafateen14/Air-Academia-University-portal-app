import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart'; // For loading PDF from assets

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseBooksPage(),
    );
  }
}

class CourseBooksPage extends StatefulWidget {
  @override
  _CourseBooksPageState createState() => _CourseBooksPageState();
}

class _CourseBooksPageState extends State<CourseBooksPage> {
  String? _pdfAssetPath; // Path to the selected PDF file in assets

  // Function to load PDF from assets
  Future<void> _loadPDFFromAssets() async {
    // PDF file path in assets
    const assetPath = 'assets/pdf/sample.pdf';

    setState(() {
      _pdfAssetPath = assetPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF036AA4),
        title: const Text('Course Books'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to trigger loading the PDF from assets
            ElevatedButton(
              onPressed: _loadPDFFromAssets,
              child: const Text('Load PDF from Assets'),
            ),
            const SizedBox(height: 20),
            // If a PDF file is selected, show the PDF viewer
            if (_pdfAssetPath != null)
              Expanded(
                child: PDFView(
                  filePath: _pdfAssetPath, // Path to the PDF file in assets
                ),
              ),
            // If no PDF is selected, show a message
            if (_pdfAssetPath == null)
              const Text(
                'No PDF selected. Please load a PDF from assets.',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
