
import 'package:flutter/material.dart';

class MediaQueryHelper {
  static double width(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  static double height(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }

  static double fontSize(BuildContext context, double baseSize) {
    double scaleFactor = MediaQuery.of(context).size.width / 375;
    return baseSize * scaleFactor;
  }
}
