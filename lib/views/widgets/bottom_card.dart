import 'package:flutter/material.dart';
import 'package:weather_app/utils/styles.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.02), // 2% of screen width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
        color: const Color.fromARGB(255, 71, 99, 191),
      ),
      child: Column(
        children: [
          SizedBox(width: 30, height: 30, child: Image.asset(icon)),
          SizedBox(height: screenWidth * 0.01),
          Text(
            title,
            style: AppStyles.smallDetailTextStyle,
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
