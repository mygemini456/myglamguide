import 'package:flutter/material.dart';

class RecommendationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.pink.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Personalized Treatments",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              _buildRecommendationCard("Medicinal Treatments", "Benzoyl Peroxide, Retinol, Salicylic Acid"),
              SizedBox(height: 15),
              _buildRecommendationCard("Home Remedies", "Aloe Vera, Honey, Green Tea"),
              SizedBox(height: 15),
              _buildRecommendationCard("Natural Treatments", "Turmeric, Tea Tree Oil, Lemon"),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple.shade300,
                  ),
                  child: Text("Back to Home", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String details) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 5),
          Text(details, style: TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }
}
