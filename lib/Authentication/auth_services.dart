import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register User
  Future<String?> registerUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user details in Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "name": name,
        "email": email,
        "uid": userCredential.user!.uid,
      });

      return null; // No error
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  // Login User
  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // No error
    } catch (e) {
      return e.toString();
    }
  }

  // Logout User
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  // Get Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
