import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather/core/constants/app_constants.dart';
import 'package:weather/core/constants/type_defs.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/features/weather/data/entity/latlng_model.dart';

class WeatherApiService {
  final Dio ins = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  ApiResponse getWeatherByCityName({required String cityName}) async {
    try {
      final Response response = await ins.get(AppConstants.todayWeather,
          queryParameters: {
            "q": cityName,
            "appId": AppConstants.apiKey,
            "units": "metric"
          });
      return right(response);
    } on DioException catch (e) {
      Logger().d(e.response?.data);

      return left(ServerFailure(exception: e));
    }
  }

  ApiResponse getWeatherByCoordinat({required LatlngModel latLng}) async {
    try {
      final Response response =
          await ins.get(AppConstants.todayWeather, queryParameters: {
        "lat": latLng.lat,
        "lon": latLng.lng,
        "appId": AppConstants.apiKey,
        "units": "metric"
      });
      return right(response);
    } on DioException catch (e) {
      return left(ServerFailure(exception: e));
    }
  }

  ApiResponse getTodayHourlyForeCastByNameOrLatLng(
      {LatlngModel? latLng, String? cityName}) async {
    try {
      final Map<String, dynamic> query = {
        "appId": AppConstants.apiKey,
        "units": "metric"
      };
      if (latLng != null) {
        query.addAll({
          "lat": latLng.lat,
          "lon": latLng.lng,
        });
      } else {
        query.addAll({"q": cityName});
      }
      final Response response =
          await ins.get(AppConstants.hourlyBased, queryParameters: query);
      return right(response);
    } on DioException catch (e) {
      Logger().d(e.response?.data);
      return left(ServerFailure(exception: e));
    }
  }
}
