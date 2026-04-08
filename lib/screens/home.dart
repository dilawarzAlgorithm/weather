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
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              width: double.infinity,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sunny, color: Colors.orange),
                      SizedBox(width: 10),
                      Text(
                        'Weather App',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'v1.0',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, thickness: 1),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              tileColor: Theme.of(context).colorScheme.secondaryFixed,
              textColor: Theme.of(context).colorScheme.onSecondaryFixed,
              iconColor: Theme.of(context).colorScheme.onSecondaryFixed,
            ),
            Divider(height: 1, thickness: 1),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (cntx) => SearchScreen()));
              },
              leading: Icon(Icons.search),
              title: Text('Search'),
              tileColor: Theme.of(context).colorScheme.secondaryFixed,
              textColor: Theme.of(context).colorScheme.onSecondaryFixed,
              iconColor: Theme.of(context).colorScheme.onSecondaryFixed,
            ),
            Divider(height: 1, thickness: 1),
          ],
        ),
      ),
      body: Text('Home screen'),
    );
  }
}
