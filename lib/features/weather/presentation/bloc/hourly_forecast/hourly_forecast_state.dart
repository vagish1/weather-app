import 'package:equatable/equatable.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/features/weather/data/entity/today_hourly_forecast_model.dart';

abstract class HourlyForeCastState extends Equatable {
  const HourlyForeCastState();

  @override
  List<Object> get props => [];
}

class HourlyForecastError extends HourlyForeCastState {
  final ServerFailure failure;

  const HourlyForecastError(this.failure);

  @override
  List<Object> get props => [failure];
}

class HourlyForecastLoading extends HourlyForeCastState {}

class HourlyForecastLoaded extends HourlyForeCastState {
  final List<ListM> weather;

  const HourlyForecastLoaded(this.weather);

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
