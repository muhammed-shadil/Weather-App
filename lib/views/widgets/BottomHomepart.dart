import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controller/Data_fetch_bloc/current_weather/weather_data_bloc.dart';
import 'package:weather_app/views/widgets/bottom_card.dart';
import 'package:weather_app/views/widgets/shimmers/bottomHomeshimmer.dart';

class BottomPartHome extends StatelessWidget {
  const BottomPartHome({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: BlocBuilder<WeatheDataBloc, WeatheDataState>(
        builder: (context, state) {
          if (state is LoadingFetchingWeather) {
            return BottomHomeshimmer(
                screenWidth: screenWidth, screenHeight: screenHeight);
          } else if (state is SuccessfullyFetchedWeather) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeatherDetails(
                        title: "Windspeed",
                        value: "${state.weatherdata.wind.speed}",
                        icon: "assets/images-removebg-preview.png"),
                    WeatherDetails(
                        title: "Humidity",
                        value: "${state.weatherdata.main.humidity}",
                        icon: "assets/dd-removebg-preview.png"),
                    WeatherDetails(
                        title: "Pressure",
                        value: "${state.weatherdata.main.pressure}",
                        icon: "assets/images__1_-removebg-preview.png"),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
