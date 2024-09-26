import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/utils/constants.dart';

class startHomeshimmer extends StatelessWidget {
  const startHomeshimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
          baseColor: Appconstants.basecolor,
          highlightColor: Appconstants.highlightColor,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 143, 143, 142),
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}
