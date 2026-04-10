import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/provider/weather_repository.dart';

class WeatherApiProvider implements IWeatherRepository {
  String get _baseUrl => dotenv.env['BASE_URL'] ?? "";
  String get _apiKey => dotenv.env['WEATHER_API_KEY'] ?? "";

  @override
  Future<WeatherModel> fetchWeatherByCity(String cityName) async {
    // encodeComponent handles spaces in city names like "New York"
    final url = Uri.parse(
      '$_baseUrl?key=$_apiKey&q=${Uri.encodeComponent(cityName)}&aqi=no',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('City not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeatherModel> fetchWeatherByLocation(double lat, double lon) async {
    final url = Uri.parse('$_baseUrl?key=$_apiKey&q=$lat,$lon&aqi=no');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('Location fetch failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
