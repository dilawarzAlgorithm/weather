import 'package:flutter/material.dart';
import 'package:weather/widgets/location.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
      body: Text('Search screen'),
    );
  }
}
