import 'package:flutter/material.dart';
import 'package:weather/core/utils/app_utils.dart';
import 'package:weather/features/forecast/domain/weather_forecast_model.dart';
import 'package:weather/features/weather/data/entity/today_hourly_forecast_model.dart';
import 'package:weather/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_state.dart';

class ForecastList extends StatefulWidget {
  final HourlyForeCastState state;
  const ForecastList({super.key, required this.state});

  @override
  State<ForecastList> createState() => _ForecastListState();
}

class _ForecastListState extends State<ForecastList> {
  final List<WeatherForecast> forecasts = [];
  @override
  void initState() {
    final List<ListM> forecastData =
        (widget.state as HourlyForecastLoaded).weather;

    for (var data in forecastData) {
      String day = AppUtils.instance.convertUnixToReadableTime(data.dt!.toInt(),
          format: "EEEE, MMM d, yyyy");

      final dayForecast = WeatherForecast(
        day: day,
        condition: data.weather?.first.description ?? "",
        minTemp: data.main?.tempMin ?? 0,
        maxTemp: data.main?.tempMax ?? 0,
        humidity: data.main?.humidity ?? 0,
        windSpeed: data.wind?.speed ?? 0,
        id: data.weather?.first.icon ?? "",
      );

      try {
        forecasts.firstWhere((e) => dayForecast.day == e.day);
      } catch (err) {
        forecasts.add(dayForecast);
      }
    }

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: forecasts.length,
      itemBuilder: (context, index) {
        final forecast = forecasts[index];
        return Card(
          margin: EdgeInsets.zero,
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      forecast.day,
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                            TextStyle(color: Colors.blueAccent, fontSize: 18),
                          ),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        AppUtils.instance.getWeatherIcon(forecast.id, size: 24),
                        Text(forecast.condition,
                            style: Theme.of(context).textTheme.titleMedium!)
                      ],
                    )
                  ],
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Text(
                      "${forecast.minTemp.toStringAsFixed(1)}° / ${forecast.maxTemp.toStringAsFixed(1)}°",
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                            TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text("${forecast.humidity}%"),
                        Icon(
                          Icons.water_drop,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 16,
        );
      },
    );
  }
}
