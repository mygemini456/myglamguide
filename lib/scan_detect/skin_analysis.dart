import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:image_picker/image_picker.dart';

class SkinAnalysisScreen extends StatelessWidget {
  final String imagePath;

  SkinAnalysisScreen({required this.imagePath});

  Future<Uint8List> _loadImageBytes() async {
    if (kIsWeb) {
      // Read the image as bytes for Web compatibility
      final XFile file = XFile(imagePath);
      return await file.readAsBytes();
    } else {
      // Load image as File for Android/iOS
      return File(imagePath).readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String skinCondition = "Acne & Dark Spots Detected";
    String treatmentSuggestion = "Use Salicylic Acid-based cleansers and Vitamin C serum daily.";

    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis Results"),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),

            // Load Image in a FutureBuilder to handle async data loading
            FutureBuilder<Uint8List>(
              future: _loadImageBytes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: Colors.white);
                } else if (snapshot.hasError) {
                  return Text("Error loading image", style: TextStyle(color: Colors.white));
                } else {
                  return Container(
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: kIsWeb
                          ? Image.memory(snapshot.data!, fit: BoxFit.cover) // Use Image.memory for Web
                          : Image.file(File(imagePath), fit: BoxFit.cover),
                    ),
                  );
                }
              },
            ),

            SizedBox(height: screenHeight * 0.04),

            // Analysis Results
            Text(
              skinCondition,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                treatmentSuggestion,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: screenWidth * 0.2),
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                "Scan Again",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
