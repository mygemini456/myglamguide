import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreTestScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add a sample user
  void _addUser() {
    _firestore.collection("users").add({
      "name": "John Doe",
      "email": "johndoe@example.com",
      "age": 25,
    }).then((value) {
      print("User added successfully!");
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  // Function to read users
  void _readUsers() {
    _firestore.collection("users").get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print("User: ${doc.data()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _addUser,
              child: Text("Add User"),
            ),
            ElevatedButton(
              onPressed: _readUsers,
              child: Text("Read Users"),
            ),
          ],
        ),
      ),
    );
  }
}
