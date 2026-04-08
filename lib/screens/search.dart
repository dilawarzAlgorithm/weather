import 'package:flutter/material.dart';
import 'package:weather/widgets/location.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final _lists = [];

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

    Widget content = Column(
      children: [for (final list in _lists) ListTile(title: Text('New list'))],
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
        actions: [
          IconButton(
            onPressed: () {
              openLocationMap();
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: content,
    );
  }
}
