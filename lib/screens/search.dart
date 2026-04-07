import 'package:flutter/material.dart';
import 'package:weather/screens/location.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (cntx) => Location()));
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: Text('Search screen'),
    );
  }
}
