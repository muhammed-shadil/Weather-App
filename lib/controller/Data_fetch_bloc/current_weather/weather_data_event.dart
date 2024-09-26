part of 'weather_data_bloc.dart';

@immutable
sealed class WeatherDataEvent {}

class WeatherDatas extends WeatherDataEvent {
  final String cityname;

  WeatherDatas({required this.cityname});
}
