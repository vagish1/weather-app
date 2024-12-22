// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/service/location_service.dart';
import 'package:weather/features/weather/data/entity/latlng_model.dart';
import 'package:weather/features/weather/data/source/weather_api_service.dart';
import 'package:weather/features/weather/domain/usecase/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_cubit.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_cubit.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_state.dart';
import 'package:weather/features/weather/presentation/widgets/hourly_forecast_widget.dart';
import 'package:weather/features/weather/presentation/widgets/today_weather_card.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  @override
  void initState() {
    getCurrentLocationAndFetchWeather();

    super.initState();
  }

  Future<void> getCurrentLocationAndFetchWeather() async {
    Position currentPos;
    try {
      currentPos = await LocationService().getCurrentPosition();
    } catch (err) {
      // Making current location to mumbai;
      currentPos = Position(
          latitude: 19.0760,
          longitude: 72.8777,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0);
    }

    context.read<WeatherCubit>().selectedLatLng =
        LatlngModel(lat: currentPos.latitude, lng: currentPos.longitude);

    Connectivity().onConnectivityChanged.listen((e) {
      if (e.contains(ConnectivityResult.mobile) ||
          e.contains(ConnectivityResult.wifi)) {
        context.read<WeatherCubit>().fetchWeatherByCoordinate(
            LatlngModel(lat: currentPos.latitude, lng: currentPos.longitude));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (BuildContext context, state) {
            if (state is WeatherLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is WeatherErrorOccured) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Column(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Something Went Wrong",
                        style: Theme.of(context).textTheme.titleLarge!.merge(
                              TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                      ),
                      Text(
                        "We encountered an error while loading api, please try again later",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      Text((state).failure.exception.message ?? ""),
                      ElevatedButton(
                          onPressed: () {
                            getCurrentLocationAndFetchWeather();
                          },
                          child: Text("Retry"))
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [
                // Current Weather Card
                TodayWeatherCard(data: (state as WeatherLoaded).weather),
                // Hourly Forecast
                BlocProvider<HourlyForecastCubit>(
                  create: (context) => HourlyForecastCubit(
                      currentWeather:
                          GetCurrentWeather(service: WeatherApiService())),
                  child: HourlyForecastWidget(
                    todayWeatherDataModel: state.weather,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
