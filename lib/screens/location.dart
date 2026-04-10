import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/provider/weather_notifier.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key});

  @override
  ConsumerState<LocationScreen> createState() {
    return _LocationState();
  }
}

class _LocationState extends ConsumerState<LocationScreen> {
  late TextEditingController _cityController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  // Logic to handle adding the city
  Future<void> _onAddLocation() async {
    final cityName = _cityController.text.trim();
    if (cityName.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Calling our Riverpod Notifier
      await ref.read(savedWeatherProvider.notifier).addCity(cityName);

      if (mounted) {
        Navigator.of(context).pop(); // Close modal on success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: Could not find "$cityName". Please check spelling.',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        color: Theme.of(context).colorScheme.surface,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.keyboard_arrow_left),
                    iconSize: 40,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      onSubmitted: (_) =>
                          _onAddLocation(), // Search on Enter key
                      decoration: InputDecoration(
                        hintText: 'Search city...',
                        labelText: 'Search City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.gps_fixed),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Expanded(
                child: Center(child: Text('Map View will be here')),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _onAddLocation,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Add this Location'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
