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
    try {
      final weather = await ref
          .read(weatherRepositoryProvider)
          .fetchWeatherByCity(cityName);

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

  Future<void> addCityByLocation(double lat, double lon) async {
    try {
      final weather = await ref
          .read(weatherRepositoryProvider)
          .fetchWeatherByLocation(lat, lon);

      final exists = state.any(
        (w) => w.city.toLowerCase() == weather.city.toLowerCase(),
      );
      if (exists) {
        throw Exception('Your location already added');
      }

      state = [weather, ...state];
    } catch (e) {
      rethrow;
    }
  }

  void removeCity(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  Future<void> syncAllWeather() async {
    if (state.isEmpty) return;
    final List<WeatherModel> updatedList = [];
    for (final s in state) {
      try {
        final weather = await ref
            .read(weatherRepositoryProvider)
            .fetchWeatherByCity(s.city);
        updatedList.add(weather);
      } catch (e) {
        updatedList.add(s);
      }
    }
    state = updatedList;
  }

  void reorderCities(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final List<WeatherModel> newList = List.from(state);

    final WeatherModel item = newList.removeAt(oldIndex);
    newList.insert(newIndex, item);

    state = newList;
  }
}

final savedWeatherProvider =
    NotifierProvider<SavedWeatherNotifier, List<WeatherModel>>(() {
      return SavedWeatherNotifier();
    });
