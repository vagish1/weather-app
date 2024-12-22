class WeatherForecast {
  final String day;
  final String condition;
  final num minTemp;
  final num maxTemp;
  final num humidity;
  final num windSpeed;
  final String id;

  WeatherForecast({
    required this.day,
    required this.id,
    required this.condition,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.windSpeed,
  });
}
