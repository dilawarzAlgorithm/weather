class WeatherModel {
  final String id;
  final String city;
  final String region;
  final DateTime lastUpdated;
  final double tempC;
  final double tempF;
  final double feelsLikeC;
  final double feelsLikeF;
  final String condition;
  final String iconUrl;
  final double windMph;
  final double windKph;
  final String windDir;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int isDay;
  final double uv;

  WeatherModel({
    required this.id,
    required this.city,
    required this.region,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.condition,
    required this.iconUrl,
    required this.windMph,
    required this.windKph,
    required this.windDir,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.isDay,
    required this.uv,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final location = json['location'];

    // Create a stable ID using city and region to avoid duplicates
    final cityId = '${location['name']}_${location['region']}'
        .toLowerCase()
        .replaceAll(' ', '_');

    return WeatherModel(
      id: cityId,
      city: location['name'],
      region: location['region'],
      lastUpdated: DateTime.now(),
      tempC: (current['temp_c'] as num).toDouble(),
      tempF: (current['temp_f'] as num).toDouble(),
      feelsLikeC: (current['feelslike_c'] as num).toDouble(),
      feelsLikeF: (current['feelslike_f'] as num).toDouble(),
      condition: current['condition']['text'],
      iconUrl: 'https:${current['condition']['icon']}',
      windMph: (current['wind_mph'] as num).toDouble(),
      windKph: (current['wind_kph'] as num).toDouble(),
      windDir: current['wind_dir'],
      precipMm: (current['precip_mm'] as num).toDouble(),
      precipIn: (current['precip_in'] as num).toDouble(),
      humidity: current['humidity'],
      isDay: current['is_day'],
      uv: (current['uv'] as num).toDouble(),
    );
  }
}
