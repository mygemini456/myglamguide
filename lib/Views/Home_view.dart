import 'package:flutter/material.dart';
import '../Authentication/auth_services.dart';
import '../Components/mediaQuery.dart';
import '../Routes/Route_name.dart';


class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.logoutUser();
    Navigator.pushNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQueryHelper.height(context, 0.18); // 🔥 All Containers Same Height
    double containerWidth = MediaQueryHelper.width(context, 0.9); // 🔥 All Containers Same Width

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade200, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQueryHelper.width(context, 0.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQueryHelper.height(context, 0.08)), // 🔥 Adjust Top Spacing
              _buildHeader(context),
              SizedBox(height: MediaQueryHelper.height(context, 0.04)),
              _buildFeatureCard(context, "Scan Your Face", Icons.camera_alt, RouteNames.faceScan, containerHeight, containerWidth),
              SizedBox(height: MediaQueryHelper.height(context, 0.02)),
              _buildFeatureCard(context, "Your Skincare Routine", Icons.spa, RouteNames.routine, containerHeight, containerWidth),
              SizedBox(height: MediaQueryHelper.height(context, 0.02)),
              _buildFeatureCard(context, "Personalized Treatments", Icons.favorite, RouteNames.recommendations, containerHeight, containerWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Welcome, Beautiful! 🌸",
          style: TextStyle(fontSize: MediaQueryHelper.fontSize(context, 24), fontWeight: FontWeight.bold, color: Colors.white),
        ),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.white, size: MediaQueryHelper.fontSize(context, 22)),
          onPressed: () => _logout(context),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, String route, double height, double width) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        height: height, // ✅ Same Height for All
        width: width,   // ✅ Same Width for All
        decoration: _boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: MediaQueryHelper.fontSize(context, 32)), // 🔥 Icon Size Responsive
            SizedBox(width: MediaQueryHelper.width(context, 0.03)),
            Text(
              title,
              style: TextStyle(fontSize: MediaQueryHelper.fontSize(context, 18), fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white.withOpacity(0.3),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
    );
  }
}
