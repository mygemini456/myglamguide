import 'package:flutter/material.dart';

import '../scan_detect/Face Scan Screen.dart';
import '../Views/Face_Recm.dart';
import '../Views/Home_view.dart';
import '../Views/Login_view.dart';
import '../Views/Register_Screen.dart';
import '../Views/Routine_Screen.dart';
import 'Route_name.dart';


class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RouteNames.login: (context) => LoginScreen(),
      RouteNames.register: (context) => RegisterScreen(),
      RouteNames.home: (context) => HomeScreen(),
      RouteNames.faceScan: (context) => FaceScanScreen(),
      RouteNames.recommendations: (context) => RecommendationsScreen(),
      RouteNames.routine: (context) => RoutineScreen(),
    };
  }
}
