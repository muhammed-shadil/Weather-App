part of 'forecast_weather_bloc.dart';

@immutable
sealed class ForecastWeatherState {}

final class ForecastWeatherInitial extends ForecastWeatherState {}

class SuccessfullyForecastWeather extends ForecastWeatherState {
  final ForecastWeatherModel forecastdata;

  SuccessfullyForecastWeather({required this.forecastdata});
}

class LoadingForecastWeather extends ForecastWeatherState {}

class ErrorForecastWeather extends ForecastWeatherState {
  final String message;

  ErrorForecastWeather({required this.message});
}
