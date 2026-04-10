import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/provider/weather_notifier.dart';
import 'package:weather/widgets/home_widget.dart';
import 'package:weather/screens/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  bool _isSyncing = false;

  Future<void> _refresh() async {
    setState(() {
      _isSyncing = true;
    });

    try {
      // Use ref.read for actions, and await the future
      await ref.read(savedWeatherProvider.notifier).syncAllWeather();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All locations updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to sync data. Check connection.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  void _openLocationMap() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (cntx) => LocationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var lists = ref.watch(savedWeatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _openLocationMap();
            },
            icon: Icon(Icons.location_on),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          IconButton(
            onPressed: _isSyncing ? null : _refresh,
            icon: _isSyncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh_sharp),
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
          : ReorderableListView.builder(
              onReorder: (oldIndex, newIndex) {
                ref
                    .read(savedWeatherProvider.notifier)
                    .reorderCities(oldIndex, newIndex);
              },
              itemCount: lists.length,
              itemBuilder: (cntx, index) {
                final list = lists[index];
                return Dismissible(
                  key: ValueKey(list.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ref.read(savedWeatherProvider.notifier).removeCity(list.id);
                  },
                  child: Card(
                    key: ValueKey(list.id),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    margin: EdgeInsets.all(12),
                    child: ListTile(
                      onTap: () => Home(),
                      title: Text(list.city),
                      subtitle: Text(
                        '${list.city}\n${DateFormat("EE, dd MMMM 'at' hh:mm a").format(list.lastUpdated)}',
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
                  ),
                );
              },
            ),
    );
  }
}
