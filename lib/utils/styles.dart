import 'package:flutter/material.dart';

class AppStyles {
  // Common TextStyles used throughout the app
  static const TextStyle tempTextStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle cityTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle weatherDescTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle smallDetailTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.white70,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle forecastTemperature = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  // Container gradient for background
  static const BoxDecoration gradientBackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 132, 154, 240),
        Color.fromARGB(255, 125, 146, 232),
        Color.fromARGB(255, 79, 109, 207),
        Color.fromARGB(255, 62, 90, 179),
        Color.fromARGB(255, 62, 90, 179),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  // Card decoration for displaying weather details
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(15),
    border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
  );

  static const double forecastIconSize = 32.0;
}
