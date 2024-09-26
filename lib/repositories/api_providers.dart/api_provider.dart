import 'package:http/http.dart' as http;
import 'package:weather_app/secretfile.dart';

class Apiprovider {
  Future<http.Response> weatherdatas(String cityname) async {
    final response = await http.get(
      Uri.parse(
          "${Secrets.currentBaseUrl}$cityname&appid=${Secrets.apikey}&units=metric"),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<http.Response> forcastweatherdatas(String cityname) async {
    final response = await http.get(
      Uri.parse(
          "${Secrets.forecastBaseUrl}$cityname&appid=${Secrets.apikey}&units=metric"),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
