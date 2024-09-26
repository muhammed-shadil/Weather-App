import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/Data_fetch_bloc/forecast/forecast_weather_bloc.dart';
import 'package:weather_app/utils/icons.dart';
import 'package:weather_app/views/widgets/glass_card.dart';

class ForecastHomePart extends StatelessWidget {
  const ForecastHomePart({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.15,
      child: BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
        builder: (context, state) {
          if (state is LoadingForecastWeather) {
            return const CircularProgressIndicator();
          } else if (state is SuccessfullyForecastWeather) {
            final list = state.forecastdata.list;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                DateTime dateTime = DateTime.parse(list[index].dtTxt);
                String formattedTime = DateFormat.jm().format(dateTime);

                return GlassForecastCard(
                  time: formattedTime,
                  temp: "${list[index].main.temp.toStringAsFixed(0)}°",
                  icon: AppIcons.icons[list[index].weather[0].main] ??
                      "assets/icons/clear.png",
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
