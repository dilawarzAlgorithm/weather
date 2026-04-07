import 'package:flutter/material.dart';
import 'package:weather/screens/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (cntx) => SearchScreen()));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
      ),
      body: Text('Home screen'),
    );
  }
}
