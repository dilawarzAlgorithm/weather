import 'package:flutter/material.dart';

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
              ).push(MaterialPageRoute(builder: (cntx) => Text('Map')));
            },
            icon: Icon(Icons.map),
          ),
        ],
      ),
      body: Text('Search screen'),
    );
  }
}
