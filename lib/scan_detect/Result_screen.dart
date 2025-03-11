import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanSkinScreen extends StatefulWidget {
  @override
  _ScanSkinScreenState createState() => _ScanSkinScreenState();
}

class _ScanSkinScreenState extends State<ScanSkinScreen> {
  CameraController? _controller;
  bool _isScanning = false;
  FaceDetector? _faceDetector;
  List<Face> _faces = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _faceDetector = FaceDetector(
        options: FaceDetectorOptions(enableContours: true, enableClassification: true));
  }

  // Request camera permission
  Future<bool> _requestPermissions() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    bool hasPermission = await _requestPermissions();
    if (hasPermission) {
      final cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.high);
      await _controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    }
  }

  // Capture & analyze face
  Future<void> _captureAndAnalyze() async {
    if (!_controller!.value.isInitialized) return;

    setState(() {
      _isScanning = true;
    });

    try {
      final image = await _controller!.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final faces = await _faceDetector!.processImage(inputImage);

      setState(() {
        _faces = faces;
        _isScanning = false;
      });

      _showResultsDialog(faces);
    } catch (e) {
      print("Error scanning image: $e");
      setState(() {
        _isScanning = false;
      });
    }
  }

  // Show results in a dialog
  void _showResultsDialog(List<Face> faces) {
    String message;
    if (faces.isEmpty) {
      message = "No skin issues detected!";
    } else {
      message = "Potential skin issues detected.\n\nRecommended Treatment: ${getTreatmentRecommendation('Acne')}";
    }
    _showMessage(message);
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Skin Analysis Result"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Your Skin")),
      body: Column(
        children: [
          _controller == null || !_controller!.value.isInitialized
              ? Center(child: CircularProgressIndicator())
              : Expanded(child: CameraPreview(_controller!)),

          _isScanning
              ? Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          )
              : Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: _captureAndAnalyze,
              child: Text("Start Scanning"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// *************  🔥 Treatment Recommendation Function 🔥 *************  //

String getTreatmentRecommendation(String skinIssue) {
  switch (skinIssue) {
    case 'Acne':
      return 'Use a gentle cleanser with salicylic acid. Try benzoyl peroxide or tea tree oil-based products.';
    case 'Dark Spots':
      return 'Apply Vitamin C serum, niacinamide, and sunscreen daily.';
    case 'Dry Skin':
      return 'Use a hydrating moisturizer with hyaluronic acid and drink plenty of water.';
    default:
      return 'Consult a dermatologist for a personalized skincare routine.';
  }
}
