import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controller/Data_fetch_bloc/cubit/temperature_converter_cubit.dart';
import 'package:weather_app/controller/Data_fetch_bloc/current_weather/weather_data_bloc.dart';
import 'package:weather_app/utils/commen_functions.dart';
import 'package:weather_app/utils/icons.dart';
import 'package:weather_app/utils/styles.dart';
import 'package:weather_app/views/widgets/shimmers/startHomeshimmer.dart';

class StartHomepart extends StatelessWidget {
  const StartHomepart({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureConverterCubit, TempUnit>(
      builder: (context, unit) {
        return BlocBuilder<WeatheDataBloc, WeatheDataState>(
          builder: (context, state) {
            if (state is LoadingFetchingWeather) {
              return const startHomeshimmer();
            } else if (state is SuccessfullyFetchedWeather) {
              double currentTemp = CommenFunctions.convertTemp(
                  state.weatherdata.main.temp, unit);
              return Center(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Image(
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AppIcons.icons[state.weatherdata.weather[0].main],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => context
                              .read<TemperatureConverterCubit>()
                              .toggleUnit(),
                          child: Text(
                            "${currentTemp.toStringAsFixed(0)}°${unit == TempUnit.celsius ? 'C' : 'F'}",
                            style: AppStyles.tempTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "${state.weatherdata.weather[0].description}- H:${state.weatherdata.main.tempMax.toStringAsFixed(2)}° L:${state.weatherdata.main.tempMin.toStringAsFixed(2)}°",
                      style: AppStyles.weatherDescTextStyle,
                    ),
                    Text(
                      state.weatherdata.name,
                      style: AppStyles.weatherDescTextStyle,
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
