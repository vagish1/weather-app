import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:weather/core/constants/type_defs.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';
import 'package:weather/features/weather/data/entity/latlng_model.dart';
import 'package:weather/features/weather/data/entity/today_hourly_forecast_model.dart';
import 'package:weather/features/weather/data/source/weather_api_service.dart';
import 'package:weather/features/weather/domain/respository/weather_info_repo.dart';

class GetCurrentWeather extends WeatherInfoRepo {
  final WeatherApiService service;

  GetCurrentWeather({required this.service});
  @override
  Future<WeatherResponse> getTodaysWeatherDataByCityName(
      {required String cityName}) async {
    final ResultOrError response =
        await service.getWeatherByCityName(cityName: cityName);

    return await response.fold((failure) {
      return left(failure);
    }, (data) {
      final TodayWeatherDataModel weatherDataModel =
          TodayWeatherDataModel.fromJson(data.data);

      return right(weatherDataModel);
    });
  }

  @override
  Future<WeatherResponse> getTodaysWeatherDataByCoord(
      {required LatlngModel latlng}) async {
    final ResultOrError response =
        await service.getWeatherByCoordinat(latLng: latlng);

    return await response.fold((failure) {
      return left(failure);
    }, (data) {
      final TodayWeatherDataModel weatherDataModel =
          TodayWeatherDataModel.fromJson(data.data);

      return right(weatherDataModel);
    });
  }

  @override
  Future<HourlyForecastResponse> getHourlyForeCast(
      {LatlngModel? latlng, String? city}) async {
    final ResultOrError response = await service
        .getTodayHourlyForeCastByNameOrLatLng(latLng: latlng, cityName: city);

    return await response.fold((failure) {
      return left(failure);
    }, (data) {
      final TodayHourlyForecastModel weatherDataModel =
          TodayHourlyForecastModel.fromJson(data.data);
      Logger logger = Logger();
      logger.d(weatherDataModel.toJson());
      logger.d(data.data);
      return right(weatherDataModel.list ?? []);
    });
  }
}
