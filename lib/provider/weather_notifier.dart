import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/provider/weather_api_provider.dart';

final weatherRepositoryProvider = Provider((ref) => WeatherApiProvider());

class SavedWeatherNotifier extends Notifier<List<WeatherModel>> {
  @override
  List<WeatherModel> build() {
    return [];
  }

  Future<void> addCity(String cityName) async {
    // We re-throw the error so the UI can catch it and show a SnackBar
    try {
      final weather = await ref
          .read(weatherRepositoryProvider)
          .fetchWeatherByCity(cityName);

      // Check if city already exists to avoid duplicates
      final exists = state.any(
        (w) => w.city.toLowerCase() == weather.city.toLowerCase(),
      );
      if (exists) {
        throw Exception('City already added');
      }

      state = [...state, weather];
    } catch (e) {
      rethrow;
    }
  }

  void removeCity(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final savedWeatherProvider =
    NotifierProvider<SavedWeatherNotifier, List<WeatherModel>>(() {
      return SavedWeatherNotifier();
    });
