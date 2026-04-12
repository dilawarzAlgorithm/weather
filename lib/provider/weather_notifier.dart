import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/provider/weather_api_provider.dart';

final weatherRepositoryProvider = Provider((ref) => WeatherApiProvider());

class SavedWeatherNotifier extends Notifier<List<WeatherModel>> {
  static const _storageKey = 'saved_weather_list';

  @override
  List<WeatherModel> build() {
    _loadFromStorage();
    return [];
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = state
        .map((item) => json.encode(item.toJson()))
        .toList();
    await prefs.setStringList(_storageKey, jsonList);
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_storageKey);

    if (jsonList != null) {
      state = jsonList.map((item) {
        return WeatherModel.fromJson(json.decode(item));
      }).toList();
      syncAllWeather();
    }
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
      await _saveToStorage();
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
      await _saveToStorage();
    } catch (e) {
      rethrow;
    }
  }

  void removeCity(String id) {
    state = state.where((item) => item.id != id).toList();
    _saveToStorage();
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
    _saveToStorage();
  }
}

final savedWeatherProvider =
    NotifierProvider<SavedWeatherNotifier, List<WeatherModel>>(() {
      return SavedWeatherNotifier();
    });
