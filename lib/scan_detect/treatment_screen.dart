import 'package:flutter/material.dart';

class TreatmentScreen extends StatelessWidget {
  final String issue;

  TreatmentScreen({required this.issue});

  @override
  Widget build(BuildContext context) {
    Map<String, String> treatments = {
      "Acne & Dark Spots": "✅ Use Salicylic Acid & Vitamin C Serum",
      "Wrinkles": "✅ Try Retinol & Hyaluronic Acid",
      "Dry Skin": "✅ Moisturize with Aloe Vera & Hyaluronic Acid"
    };

    return Scaffold(
      appBar: AppBar(title: Text("Treatment Plan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Detected Issue: $issue", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(treatments[issue] ?? "No specific treatment available", style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
