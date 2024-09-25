import 'package:http/http.dart' as http;
import 'package:weather_app/repositories/api_providers.dart/api_provider.dart';

class Apirepository {
  final Apiprovider apiprovider = Apiprovider();

  Future<http.Response> weatherdata() async {
    return apiprovider.weatherdatas();
  }
}
