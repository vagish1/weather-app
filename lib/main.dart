import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/data/source/weather_api_service.dart';
import 'package:weather/features/weather/domain/usecase/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_cubit.dart';
import 'package:weather/features/weather/presentation/pages/weather_forecast_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<WeatherCubit>(
        create: (context) => WeatherCubit(
            currentWeather: GetCurrentWeather(service: WeatherApiService())),
        child: WeatherForecastScreen(),
      ),
    );
  }
}
