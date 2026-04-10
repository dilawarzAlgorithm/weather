import 'package:weather/models/weather.dart';

abstract class IWeatherRepository {
  Future<WeatherModel> fetchWeatherByCity(String cityName);
  Future<WeatherModel> fetchWeatherByLocation(double lat, double lon);
}
