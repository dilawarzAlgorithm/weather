import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/widgets/location.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final List<Weather> _lists = [
    Weather(
      latitude: 21,
      longitude: 22,
      city: 'Pune',
      location: 'Maharashtra, India',
      weather: WeatherList.sunny,
      minTemperature: 24,
      maxTemperature: 30,
      humidity: 10,
    ),
    Weather(
      latitude: -122,
      longitude: 84,
      city: 'Dharwad',
      location: 'Karnataka, India',
      weather: WeatherList.rainy,
      minTemperature: 10,
      maxTemperature: 24,
      humidity: 100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void openLocationMap() {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        constraints: const BoxConstraints(maxWidth: double.infinity),
        builder: (cntx) => Location(),
      );
    }

    Widget content = ListView(
      children: [
        for (final list in _lists)
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            margin: EdgeInsets.all(12),
            child: ListTile(
              title: Text(list.city),
              subtitle: Text(
                '${list.location}\n${DateFormat('EE').format(list.dateTime)}, ${DateFormat('dd MMMM').format(list.dateTime)} at ${DateFormat('hh:mm a').format(list.dateTime)}',
              ),
              trailing: SizedBox(
                width: 80,
                child: Row(
                  children: [
                    weatherIcon[list.weather]!,
                    SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${list.maxTemperature.round().toString()}°',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 17,
                              ),
                        ),
                        Text(
                          '${list.minTemperature.round()}° / ${list.maxTemperature.round()}°',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );

    if (_lists.isEmpty) {
      content = Center(
        child: Text(
          'No saved places.',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Widget'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              openLocationMap();
            },
            icon: Icon(Icons.location_on),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_sharp)),
        ],
      ),
      body: content,
    );
  }
}
