import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/provider/page_notifier.dart';
import 'package:weather/provider/setting_notifier.dart';
import 'package:weather/provider/weather_notifier.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherList = ref.watch(savedWeatherProvider);
    final settings = ref.watch(savedSettingProvider);
    final currentPage = ref.watch(pageProvider);

    ref.listen<int>(pageProvider, (previous, next) {
      if (_pageController.hasClients && _pageController.page?.round() != next) {
        _pageController.jumpToPage(next);
      }
    });

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

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            ref.read(pageProvider.notifier).setPage(index);
          },
          itemCount: weatherList.length,
          itemBuilder: (context, index) {
            return _WeatherPage(
              weather: weatherList[index],
              settings: settings,
            );
          },
        ),
        if (weatherList.length > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                weatherList.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _WeatherPage extends StatelessWidget {
  final WeatherModel weather;
  final SettingsState settings;

  const _WeatherPage({required this.weather, required this.settings});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 60),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (settings.isCelsius)
                        ? '${weather.tempC.round()}°'
                        : '${weather.tempF.round()}°',
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
              Image.network(weather.iconUrl, width: 90, fit: BoxFit.contain),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '↓${(settings.isCelsius) ? weather.minTempC.round() : weather.minTempF.round()}° / ↑${(settings.isCelsius) ? weather.maxTempC.round() : weather.maxTempF.round()}°\nFeels like: ${(settings.isCelsius) ? weather.feelsLikeC.round() : weather.feelsLikeF.round()}°\n${DateFormat('EEEE, hh:mm a').format(weather.lastUpdated)}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 30),

          // Grids...
          Wrap(
            spacing: 30,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _DetailTile(
                label: 'UV INDEX',
                value: weather.uv.toString(),
                icon: Icons.sunny,
              ),
              _DetailTile(
                label: 'HUMIDITY',
                value: '${weather.humidity}%',
                icon: Icons.water_drop,
              ),
              _DetailTile(
                label: 'PRECIPITATION',
                value: '${weather.precipMm} mm',
                icon: Icons.umbrella_outlined,
              ),
              _DetailTile(
                label: 'WIND SPEED',
                value: (settings.isMph)
                    ? '${weather.windMph.round()} mp/h'
                    : '${weather.windKph.round()} km/h',
                icon: Icons.air,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(),
          Center(
            child: Text(
              'Last synced at ${DateFormat('h:mm a').format(weather.lastUpdated)}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DetailTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
