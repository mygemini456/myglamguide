import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart'; // For Web
import 'package:image_picker/image_picker.dart';
import 'dart:ui'; // Add this to use 'Size'

class AIModelHelper {
  FaceDetector? _faceDetector;

  AIModelHelper() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(enableContours: true, enableLandmarks: true),
    );
  }

  Future<List<String>> analyzeImage(Uint8List imageBytes) async {
    try {
      final InputImage image = InputImage.fromBytes(
        bytes: imageBytes,
        metadata: InputImageMetadata(
          size: Size(300, 300), // Change based on your requirements
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          bytesPerRow: 300,
        ),
      );

      final faces = await _faceDetector!.processImage(image);

      if (faces.isNotEmpty) {
        return ["Face Detected ✅", "Number of faces: ${faces.length}"];
      } else {
        return ["No Face Detected ❌"];
      }
    } catch (e) {
      return ["Error Processing Image: $e"];
    }
  }

  Future<void> dispose() async {
    await _faceDetector!.close();
  }
}
