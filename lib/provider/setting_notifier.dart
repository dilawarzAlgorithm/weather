import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  SettingsState({required this.isCelsius, required this.isMph});

  final bool isCelsius; // true = Celsius, false = Fahrenheit
  final bool isMph; // true = Mph, false = Kph

  Map<String, dynamic> toMap() => {'isCelsius': isCelsius, 'isMph': isMph};

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      isCelsius: map['isCelsius'] ?? true,
      isMph: map['isMph'] ?? true,
    );
  }
}

class SavedSettingNotifier extends Notifier<SettingsState> {
  static const _storageKey = 'user_settings';

  @override
  SettingsState build() {
    _loadSettings();
    return SettingsState(isCelsius: true, isMph: true);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      state = SettingsState.fromMap(json.decode(jsonString));
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, json.encode(state.toMap()));
  }

  void toggleTemperature(int index) {
    state = SettingsState(isCelsius: index == 0, isMph: state.isMph);
    _saveSettings();
  }

  void toggleSpeed(int index) {
    state = SettingsState(isCelsius: state.isCelsius, isMph: index == 0);
    _saveSettings();
  }
}

final savedSettingProvider =
    NotifierProvider<SavedSettingNotifier, SettingsState>(() {
      return SavedSettingNotifier();
    });
