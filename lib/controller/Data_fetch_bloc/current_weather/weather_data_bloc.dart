import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/currentWeather.dart';
import 'package:weather_app/repositories/api_repository/api_repository.dart';

part 'weather_data_event.dart';
part 'weather_data_state.dart';

Apirepository apirepository = Apirepository();

class WeatheDataBloc extends Bloc<WeatherDataEvent, WeatheDataState> {
  WeatheDataBloc() : super(WeatheDataInitial()) {
    on<WeatherDatas>(weatherdata);
  }

  FutureOr<void> weatherdata(
      WeatherDatas event, Emitter<WeatheDataState> emit) async {
    emit(LoadingFetchingWeather());
    CurrentWeather weatherdata;
    try {
      final Response response = await apirepository.weatherdata(event.cityname);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        weatherdata = CurrentWeather.fromMap(result);

        emit(SuccessfullyFetchedWeather(weatherdata: weatherdata));
      } else {
        emit(ErrorfetchingWeather(message: "message"));
      }
    } catch (e) {
      emit(ErrorfetchingWeather(message: "message"));
    }
  }
}
