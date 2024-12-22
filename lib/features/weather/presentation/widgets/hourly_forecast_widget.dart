import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/utils/app_utils.dart';
import 'package:weather/features/forecast/presentation/pages/day_wise_forecast.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';
import 'package:weather/features/weather/data/entity/today_hourly_forecast_model.dart';
import 'package:weather/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_cubit.dart';
import 'package:weather/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_state.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_cubit.dart';
import 'package:weather/features/weather/presentation/widgets/hourly_forecast_item.dart';

class HourlyForecastWidget extends StatefulWidget {
  final TodayWeatherDataModel todayWeatherDataModel;
  const HourlyForecastWidget({super.key, required this.todayWeatherDataModel});

  @override
  State<HourlyForecastWidget> createState() => _HourlyForecastWidgetState();
}

class _HourlyForecastWidgetState extends State<HourlyForecastWidget> {
  @override
  void initState() {
    context.read<HourlyForecastCubit>().fetchHourlyForecast(
        latLng: context.read<WeatherCubit>().selectedLatLng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyForecastCubit, HourlyForeCastState>(
      builder: (context, state) {
        if (state is HourlyForecastLoading) {
          return CircularProgressIndicator();
        }

        if (state is HourlyForecastError) {
          return Text((state).failure.exception.message ?? "");
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return DayWiseForecast(
                              foreCastState: state,
                              todayWeatherDataModel:
                                  widget.todayWeatherDataModel,
                            );
                          }),
                        );
                      },
                      child: Text(
                        "Forecasts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (state as HourlyForecastLoaded).weather.length,
                itemBuilder: (context, index) {
                  final ListM hourlyBased = (state).weather.elementAt(index);
                  return HourlyForecastItem(
                    time: AppUtils.instance.convertUnixToReadableTime(
                        hourlyBased.dt?.toInt() ?? 0),
                    icon: AppUtils.instance.getWeatherIcon(
                        hourlyBased.weather?.first.icon ?? "",
                        size: 28),
                    temperature:
                        "${hourlyBased.main?.temp?.toStringAsFixed(1)}°",
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
