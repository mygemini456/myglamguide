import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Routes/Route_name.dart';
import 'Routes/routes.dart';
import 'Views/Login_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glam Guide',
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: RouteNames.login, // Start from login screen
      routes: AppRoutes.getRoutes(),
    );
  }
}
