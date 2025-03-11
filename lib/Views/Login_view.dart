import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Authentication/auth_services.dart';
import '../Components/mediaQuery.dart';
import '../Routes/Route_name.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    String? error = await _authService.loginUser(
      emailController.text,
      passwordController.text,
    );

    if (error == null) {
      Navigator.pushNamed(context, RouteNames.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQueryHelper.width(context, 1), // ✅ Responsive Width
        height: MediaQueryHelper.height(context, 1), // ✅ Responsive Height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade300, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQueryHelper.width(context, 0.1)), // ✅ Responsive Padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Glam Guide",
                  style: GoogleFonts.poppins(
                    fontSize: MediaQueryHelper.fontSize(context, 32), // ✅ Responsive Font Size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: MediaQueryHelper.height(context, 0.02)), // ✅ Responsive Spacing
                _buildTextField(emailController, "Email", Icons.email),
                SizedBox(height: MediaQueryHelper.height(context, 0.015)),
                _buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
                SizedBox(height: MediaQueryHelper.height(context, 0.02)),
                _buildButton("Login", _login),
                SizedBox(height: MediaQueryHelper.height(context, 0.015)),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, RouteNames.register),
                  child: Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: Colors.white, fontSize: MediaQueryHelper.fontSize(context, 14)), // ✅ Responsive Text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: MediaQueryHelper.fontSize(context, 16)), // ✅ Responsive Font
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: MediaQueryHelper.height(context, 0.02), // ✅ Responsive Button Size
          horizontal: MediaQueryHelper.width(context, 0.3),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.pink.shade300,
      ),
      child: Text(text, style: GoogleFonts.poppins(fontSize: MediaQueryHelper.fontSize(context, 18), fontWeight: FontWeight.bold)),
    );
  }
}
