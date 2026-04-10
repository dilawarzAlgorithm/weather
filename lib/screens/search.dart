import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/provider/weather_notifier.dart';
import 'package:weather/widgets/home_widget.dart';
import 'package:weather/screens/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<WeatherModel> lists = ref.watch(savedWeatherProvider);

    void openLocationMap() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (cntx) => LocationScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              openLocationMap();
            },
            icon: Icon(Icons.location_on),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh_sharp),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
      body: (lists.isEmpty)
          ? Center(
              child: Text(
                'No saved places.',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            )
          : ListView.builder(
              itemCount: lists.length,
              itemBuilder: (cntx, index) {
                final list = lists[index];
                return Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  margin: EdgeInsets.all(12),
                  child: ListTile(
                    onTap: () => Home(),
                    title: Text(list.city),
                    subtitle: Text(
                      '${list.city}\n${DateFormat('EE').format(list.dateTime)}, ${DateFormat('dd MMMM').format(list.dateTime)} at ${DateFormat('hh:mm a').format(list.dateTime)}',
                    ),
                    trailing: SizedBox(
                      width: 90,
                      child: Row(
                        children: [
                          Image.network(list.iconUrl, width: 40),
                          SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${list.tempC.round().toString()}°',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                      fontSize: 17,
                                    ),
                              ),
                              Text(
                                '${list.tempC.round()}° / ${list.tempC.round()}°',
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
                );
              },
            ),
    );
  }
}
