import 'package:equatable/equatable.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherErrorOccured extends WeatherState {
  final ServerFailure failure;

  const WeatherErrorOccured(this.failure);

  @override
  List<Object> get props => [failure];
}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final TodayWeatherDataModel weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

// class WeeklyForecastLoaded extends WeatherState {
//   final List<ForecastModel> forecast;

//   const WeeklyForecastLoaded(this.forecast);

//   @override
//   List<Object> get props => [forecast];
// }

// class WeatherError extends WeatherState {
//   final String message;

//   const WeatherError(this.message);

//   @override
//   List<Object> get props => [message];
// }
