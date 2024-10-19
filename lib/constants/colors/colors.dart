import 'package:flutter/material.dart';

class AdminColors {
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color headingblue = Color.fromARGB(255, 31, 19, 249);
  static const Color primerybuttoncolor = Color(0xFF1E91B6);

  static const LinearGradient primarybuttongradient = LinearGradient(
    colors: [
      Color(0xFF5435FF),
      Color(0xFF36C8F6),
      Color(0xFFA0FBCD),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient bookingcardcolor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.blue[50]!,
      Colors.blue[100]!,
    ],
  );
  static LinearGradient availablecardcolor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.red[50]!,
      Colors.red[100]!,
    ],
  );
  static LinearGradient revenuecardcolor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.green[50]!,
      Colors.green[100]!,
    ],
  );
  static LinearGradient occcupancycardcolor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange[50]!,
      Colors.orange[100]!,
    ],
  );
}
