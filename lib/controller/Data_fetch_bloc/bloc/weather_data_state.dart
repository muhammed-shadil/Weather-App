part of 'weather_data_bloc.dart';

@immutable
sealed class WeatheDataState {}

final class WeatheDataInitial extends WeatheDataState {}

class SuccessfullyFetchedWeather extends WeatheDataState {}

class LoadingFetchingWeather extends WeatheDataState {}

class ErrorfetchingWeather extends WeatheDataState {
  final String message;

  ErrorfetchingWeather({required this.message});
}
