import 'package:flutter/material.dart';

enum WeatherList { sunny, rainy }

final Map<WeatherList, Icon> weatherIcon = {
  WeatherList.sunny: Icon(Icons.sunny, color: Colors.orange),
  WeatherList.rainy: Icon(Icons.water_drop, color: Colors.blue[900]),
};

class Weather {
  Weather({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.location,
    required this.weather,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
  }) : dateTime = DateTime.now();

  final DateTime dateTime;
  final int latitude;
  final int longitude;
  final String city;
  final String location;
  final WeatherList weather;
  final double minTemperature;
  final double maxTemperature;
  final double humidity;
}
