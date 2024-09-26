import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/utils/constants.dart';

class BottomHomeshimmer extends StatelessWidget {
  const BottomHomeshimmer({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Appconstants.basecolor,
      highlightColor: Appconstants.highlightColor,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 235, 230, 217)),
        width: screenWidth,
        height: screenHeight * 0.13,
      ),
    );
  }
}
