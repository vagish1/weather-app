import 'package:dartz/dartz.dart'; // Required for Either.
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/core/utils/app_utils.dart';
import 'package:weather/features/weather/data/entity/latlng_model.dart';
import 'package:weather/features/weather/data/entity/today_hourly_forecast_model.dart';
import 'package:weather/features/weather/domain/usecase/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_state.dart';

class HourlyForecastCubit extends Cubit<HourlyForeCastState> {
  // Use case for fetching weather data.

  String? selectedCityName;
  LatlngModel? selectedLatLng;

  final GetCurrentWeather currentWeather;
  HourlyForecastCubit({required this.currentWeather})
      : super(HourlyForecastLoading());

  // Method to fetch weather data by city name.
  Future<void> fetchHourlyForecast(
      {String? cityName, LatlngModel? latLng}) async {
    if ((await AppUtils.instance.isConnectedToInternet()) == false) {
      emit(HourlyForecastError(ServerFailure(
          exception: DioException(
              requestOptions: RequestOptions(),
              message: "Not Connected to internet"))));
      return;
    }
    selectedCityName = cityName;
    emit(HourlyForecastLoading()); // Emit loading state initially.
    Logger().d(latLng.toString());
    // Fetch the weather data using the use case.
    final Either<Failures, List<ListM>> result =
        await currentWeather.getHourlyForeCast(city: cityName, latlng: latLng);

    // Handle the result using fold for success and failure.
    result.fold(
      (failure) {
        emit(HourlyForecastError(
            failure as ServerFailure)); // Emit error state in case of failure.
      },
      (weatherData) {
        emit(HourlyForecastLoaded(
            weatherData)); // Emit loaded state with weather data.
      },
    );
  }
}
