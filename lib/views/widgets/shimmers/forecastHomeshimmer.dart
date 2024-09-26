import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/utils/constants.dart';

class ForecastHomeshimmer extends StatelessWidget {
  const ForecastHomeshimmer({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Appconstants.basecolor,
      highlightColor: Appconstants.highlightColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 218, 218, 217),
            ),
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            width: screenWidth * 0.18,
          );
        },
      ),
    );
  }
}
