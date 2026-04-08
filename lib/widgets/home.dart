import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _weather = Weather(
    latitude: 22.25,
    longitude: 122.98,
    city: 'Pune',
    location: 'Maharahtra, India',
    weather: WeatherList.sunny,
    minTemperature: 22.23,
    maxTemperature: 32.89,
    humidity: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _weather.city,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '${_weather.maxTemperature}°',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 70,
            ),
          ),
          // SizedBox(height: 3),
          Text(
            '${_weather.weather.name.substring(0, 1).toUpperCase()}${_weather.weather.name.substring(1)}',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '${_weather.maxTemperature}° / ${_weather.minTemperature}°',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${DateFormat('EE').format(_weather.dateTime)}, ${DateFormat('hh:mm a').format(_weather.dateTime)}',
          ),
        ],
      ),
    );
  }
}
