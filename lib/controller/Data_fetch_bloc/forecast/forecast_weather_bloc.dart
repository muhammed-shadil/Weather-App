import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/controller/Data_fetch_bloc/current_weather/weather_data_bloc.dart';
import 'package:weather_app/models/forecastWeather.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc
    extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {
  ForecastWeatherBloc() : super(ForecastWeatherInitial()) {
    on<ForcastWeather>(forcastweather);
  }

  FutureOr<void> forcastweather(
      ForcastWeather event, Emitter<ForecastWeatherState> emit) async {
    emit(LoadingForecastWeather());
    ForecastWeatherModel forecastWeather;
    try {
      final Response response =
          await apirepository.forcastWeather(event.cityname);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        forecastWeather = ForecastWeatherModel.fromMap(result);

        emit(SuccessfullyForecastWeather(forecastdata: forecastWeather));
      } else {
        emit(ErrorForecastWeather(message: "message"));
      }
    } catch (e) {
      emit(ErrorForecastWeather(message: "message"));
    }
  }
}
