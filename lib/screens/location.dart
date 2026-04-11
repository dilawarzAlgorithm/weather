import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/provider/weather_notifier.dart';
import 'package:location/location.dart' as loc;

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

  Future<void> _onAddLocation() async {
    final cityName = _cityController.text.trim();
    if (cityName.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(savedWeatherProvider.notifier).addCity(cityName);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      _showError('Error: Could not find "$cityName".');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      loc.Location location = loc.Location();

      bool serviceEnabled = await location.serviceEnabled().timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw Exception('Location service check timed out.'),
      );

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) throw Exception('Location service is disabled.');
      }

      loc.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          throw Exception('Location permission denied.');
        }
      }

      final locationData = await location.getLocation().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception(
          'Simulator did not return coordinates. Change Features > Location.',
        ),
      );

      if (locationData.latitude != null && locationData.longitude != null) {
        await ref
            .read(savedWeatherProvider.notifier)
            .addCityByLocation(locationData.latitude!, locationData.longitude!);

        if (mounted) Navigator.of(context).pop();
      } else {
        throw Exception('Location data is empty.');
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.keyboard_arrow_left, size: 40),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      onSubmitted: (_) => _onAddLocation(),
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
                    onPressed: _isLoading ? null : _getCurrentLocation,
                    icon: const Icon(Icons.gps_fixed),
                  ),
                ],
              ),
              const Spacer(),
              const Center(child: Text('Map View will be here')),
              const Spacer(),
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
