import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather/provider/weather_notifier.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherList = ref.watch(savedWeatherProvider);

    if (weatherList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No weather data available.\nTap search to add a city.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    final weather = weatherList.first;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weather.city,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            '${weather.region}, ${weather.country}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.tempC.round()}°',
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w200,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    weather.condition,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const Spacer(),
              Image.network(weather.iconUrl, width: 70, fit: BoxFit.contain),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '↓${weather.minTempC.round()}° /↑${weather.maxTempC.round()}°\nFeels like: ${weather.feelsLikeC.round().toString()}°\n${DateFormat('EE, hh:mm a').format(DateTime.now())}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [Icon(Icons.sunny, size: 15), Text('UV index')],
                    ),
                    SizedBox(height: 20),
                    Text(
                      weather.uv.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.water_drop, size: 15),
                        Text('Humidity'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${weather.humidity.toString()}%',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.water_drop_outlined, size: 15),
                        Text('Precipitation'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      weather.precipMm.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [Icon(Icons.air, size: 15), Text('Wind Speed')],
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${weather.windKph.toString()}%',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 40),
          Text(
            'Last updated: ${DateFormat('h:mm a').format(weather.lastUpdated)}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
