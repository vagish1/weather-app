import 'package:dartz/dartz.dart'; // Required for Either.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';
import 'package:weather/features/weather/data/entity/latlng_model.dart';
import 'package:weather/features/weather/domain/usecase/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  // Use case for fetching weather data.

  String? selectedCityName;
  LatlngModel? selectedLatLng;

  final GetCurrentWeather currentWeather;
  WeatherCubit({required this.currentWeather}) : super(WeatherLoading());

  // Method to fetch weather data by city name.
  Future<void> fetchWeatherByCityName(String cityName) async {
    selectedCityName = cityName;
    emit(WeatherLoading()); // Emit loading state initially.

    // Fetch the weather data using the use case.
    final Either<Failures, TodayWeatherDataModel> result =
        await currentWeather.getTodaysWeatherDataByCityName(cityName: cityName);

    // Handle the result using fold for success and failure.
    result.fold(
      (failure) {
        emit(WeatherErrorOccured(
            failure as ServerFailure)); // Emit error state in case of failure.
      },
      (weatherData) {
        emit(
            WeatherLoaded(weatherData)); // Emit loaded state with weather data.
      },
    );
  }

  Future<void> fetchWeatherByCoordinate(LatlngModel latLng) async {
    selectedLatLng = latLng;
    emit(WeatherLoading()); // Emit loading state initially.

    // Fetch the weather data using the use case.
    final Either<Failures, TodayWeatherDataModel> result =
        await currentWeather.getTodaysWeatherDataByCoord(latlng: latLng);

    // Handle the result using fold for success and failure.
    result.fold(
      (failure) {
        emit(WeatherErrorOccured(
            failure as ServerFailure)); // Emit error state in case of failure.
      },
      (weatherData) {
        emit(
            WeatherLoaded(weatherData)); // Emit loaded state with weather data.
      },
    );
  }
}
