import 'package:flutter/material.dart';

class AppConstants {
  static const String apiKey =
      'YOUR_API_KEY'; // Replace with your weather API key
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String unitCelsius = 'metric';
  static const String unitFahrenheit = 'imperial';
}

class AppSpaces {
  // Common SizedBox instances
  static const SizedBox h5 = SizedBox(height: 5);
  static const SizedBox h10 = SizedBox(height: 10);
  static const SizedBox h20 = SizedBox(height: 20);
  static const SizedBox h30 = SizedBox(height: 30);
  static const SizedBox h40 = SizedBox(height: 40);
  static const SizedBox w10 = SizedBox(width: 10);
}
