import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';
import 'package:weather/features/weather/data/entity/today_hourly_forecast_model.dart';

typedef WeatherResponse = Either<Failures, TodayWeatherDataModel>;
typedef HourlyForecastResponse = Either<Failures, List<ListM>>;

typedef ApiResponse = Future<Either<Failures, Response<dynamic>>>;
typedef ResultOrError = Either<Failures, Response<dynamic>>;
