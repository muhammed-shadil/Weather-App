import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/secretfile.dart';

// String cityname = "kozhikode";

class Apiprovider {
  Future<http.Response> weatherdatas(String cityname) async {
    final response = await http.post(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=${Secrets.apikey}&units=metric"),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<http.Response> forcastweatherdatas(String cityname) async {
    final response = await http.post(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=${Secrets.apikey}&units=metric"),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
