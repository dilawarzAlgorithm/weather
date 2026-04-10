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
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            '${weather.region}, India',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Text(
                '${weather.tempC.round()}°',
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const Spacer(),
              Image.network(weather.iconUrl, width: 80, fit: BoxFit.contain),
            ],
          ),
          Text(
            weather.condition,
            style: Theme.of(context).textTheme.headlineSmall,
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
