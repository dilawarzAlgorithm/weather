class WeatherModel {
  final String id;
  final String city;
  final String region;
  final String country;
  final DateTime lastUpdated;
  final double tempC;
  final double tempF;
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
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
    required this.country,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': city,
      'region': region,
      'country': country,
      'temp_c': tempC,
      'temp_f': tempF,
      'maxtemp_c': maxTempC,
      'maxtemp_f': maxTempF,
      'mintemp_c': minTempC,
      'mintemp_f': minTempF,
      'feelslike_c': feelsLikeC,
      'feelslike_f': feelsLikeF,
      'condition_text': condition,
      'icon': iconUrl,
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_dir': windDir,
      'precip_mm': precipMm,
      'precip_in': precipIn,
      'humidity': humidity,
      'is_day': isDay,
      'uv': uv,
    };
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final bool isFromApi = json.containsKey('current');

    final current = isFromApi ? json['current'] : json;
    final location = isFromApi ? json['location'] : json;
    final dayForecast = isFromApi
        ? json['forecast']['forecastday'][0]['day']
        : json;

    return WeatherModel(
      id: isFromApi
          ? '${location['name']}_${location['region']}'
                .toLowerCase()
                .replaceAll(' ', '_')
          : json['id'],
      city: isFromApi ? location['name'] : json['name'],
      region: isFromApi ? location['region'] : json['region'],
      country: isFromApi ? location['country'] : json['country'],
      lastUpdated: DateTime.now(),
      tempC: (current['temp_c'] as num).toDouble(),
      tempF: (current['temp_f'] as num).toDouble(),
      maxTempC: (dayForecast['maxtemp_c'] as num).toDouble(),
      maxTempF: (dayForecast['maxtemp_f'] as num).toDouble(),
      minTempC: (dayForecast['mintemp_c'] as num).toDouble(),
      minTempF: (dayForecast['mintemp_f'] as num).toDouble(),
      feelsLikeC: (current['feelslike_c'] as num).toDouble(),
      feelsLikeF: (current['feelslike_f'] as num).toDouble(),
      condition: isFromApi
          ? current['condition']['text']
          : json['condition_text'],
      iconUrl: isFromApi
          ? 'https:${current['condition']['icon']}'
          : json['icon'],
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
