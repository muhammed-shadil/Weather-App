import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/utils/styles.dart';

class GlassForecastCard extends StatelessWidget {
  const GlassForecastCard({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  final String time;
  final String temp;
  final String icon;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: screenWidth * 0.18, // Card width is 18% of screen width
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), // Frosted glass effect
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(time, style: AppStyles.subtitle.copyWith(fontSize: 14)),
                  Image.asset(
                    icon,
                    scale: 1.3,
                  ),
                  Text(temp, style: AppStyles.forecastTemperature),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
