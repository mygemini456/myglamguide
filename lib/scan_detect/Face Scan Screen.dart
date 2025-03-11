import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceScanScreen extends StatefulWidget {
  @override
  _FaceScanScreenState createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  FaceDetector? _faceDetector;
  List<Face> _faces = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _faceDetector = FaceDetector(
        options: FaceDetectorOptions(enableContours: true, enableLandmarks: true));
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
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  // Capture & analyze face
  Future<void> _captureAndAnalyze() async {
    if (!_isCameraInitialized || _cameraController == null) return;
    try {
      final image = await _cameraController!.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final faces = await _faceDetector!.processImage(inputImage);
      setState(() {
        _faces = faces;
      });
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Face Scan")),
      body: Column(
        children: [
          // Show camera preview
          _isCameraInitialized
              ? Expanded(
            child: Stack(
              children: [
                CameraPreview(_cameraController!),
                ..._faces.map((face) {
                  return Positioned(
                    left: face.boundingBox.left,
                    top: face.boundingBox.top,
                    width: face.boundingBox.width,
                    height: face.boundingBox.height,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          )
              : Center(child: CircularProgressIndicator()),

          // Scan Button
          Padding(
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
