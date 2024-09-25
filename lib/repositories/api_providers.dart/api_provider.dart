import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/secretfile.dart';

String cityname = "kozhikode";

class Apiprovider {
  Future<http.Response> weatherdatas() async {
    final response = await http.post(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=${Secrets.apikey}"),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
