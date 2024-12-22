import 'package:weather/core/constants/type_defs.dart';
import 'package:weather/features/weather/data/entity/latlng_model.dart';

abstract class WeatherInfoRepo {
  Future<WeatherResponse> getTodaysWeatherDataByCityName(
      {required String cityName});
  Future<WeatherResponse> getTodaysWeatherDataByCoord(
      {required LatlngModel latlng});

  Future<HourlyForecastResponse> getHourlyForeCast(
      {LatlngModel? latlng, String? city});
}
