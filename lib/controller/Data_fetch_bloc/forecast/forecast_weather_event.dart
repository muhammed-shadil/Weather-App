part of 'forecast_weather_bloc.dart';

@immutable
sealed class ForecastWeatherEvent {}

class ForcastWeather extends ForecastWeatherEvent {
  final String cityname;

  ForcastWeather({required this.cityname});
}
