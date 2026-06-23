import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../shared/presentation/glass_card.dart';

class ResumeViewerScreen extends StatefulWidget {
  const ResumeViewerScreen({super.key});

  @override
  State<ResumeViewerScreen> createState() => _ResumeViewerScreenState();
}

class _ResumeViewerScreenState extends State<ResumeViewerScreen> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  double _zoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resume', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Controls header
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mohammed Musharraf',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'PDF Viewer',
                        style: TextStyle(fontSize: 10, color: Colors.white60, letterSpacing: 1.1),
                      ),
                    ],
                  ),
                  
                  // Zoom Level controls
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.zoom_out, size: 18),
                        onPressed: () {
                          setState(() {
                            _zoomLevel = (_zoomLevel - 0.25).clamp(0.5, 3.0);
                            _pdfViewerController.zoomLevel = _zoomLevel;
                          });
                        },
                      ),
                      Text(
                        '${(_zoomLevel * 100).round()}%',
                        style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_in, size: 18),
                        onPressed: () {
                          setState(() {
                            _zoomLevel = (_zoomLevel + 0.25).clamp(0.5, 3.0);
                            _pdfViewerController.zoomLevel = _zoomLevel;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // PDF Render Area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0x1FFFFFFF) : const Color(0x14000000),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SfPdfViewer.asset(
                    'assets/Mohammed Musharraf Resume.pdf',
                    key: _pdfViewerKey,
                    controller: _pdfViewerController,
                    canShowScrollHead: true,
                    canShowScrollStatus: true,
                    onDocumentLoadFailed: (details) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to load PDF resume: ${details.description}'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
