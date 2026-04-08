import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() {
    return _LocationState();
  }
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (cntx, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        return SizedBox(
          height: screenHeight,
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Search city...'),
                ),
                SizedBox(height: 20),
                const SizedBox(height: 20),
                Expanded(child: Center(child: Text('Map View will be here'))),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Add this Location'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
