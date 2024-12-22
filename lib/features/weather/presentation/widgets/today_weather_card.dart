// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/service/location_service.dart';
import 'package:weather/core/utils/app_utils.dart';
import 'package:weather/features/forecast/presentation/widgets/weather_info.dart';
import 'package:weather/features/search/presentation/bloc/search_city_cubit.dart';
import 'package:weather/features/search/presentation/page/search_location.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';
import 'package:weather/features/weather/data/entity/latlng_model.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_cubit.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_state.dart';

/// A widget that displays the current weather information in a styled card.

class TodayWeatherCard extends StatefulWidget {
  final TodayWeatherDataModel data;
  const TodayWeatherCard({super.key, required this.data});

  @override
  State<TodayWeatherCard> createState() => _TodayWeatherCardState();
}

class _TodayWeatherCardState extends State<TodayWeatherCard> {
  Future<void> getCurrentLocationAndFetchWeather() async {
    Position currentPos;
    try {
      currentPos = await LocationService().getCurrentPosition();
      context.read<WeatherCubit>().selectedLatLng =
          LatlngModel(lat: currentPos.latitude, lng: currentPos.longitude);
      context.read<WeatherCubit>().fetchWeatherByCoordinate(
          LatlngModel(lat: currentPos.latitude, lng: currentPos.longitude));
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF73ABFF), Color(0xFF5471E4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        getCurrentLocationAndFetchWeather();
                      },
                      child: Icon(Icons.location_pin, color: Colors.white)),
                  InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) {
                      //   return SearchLocation();
                      // }));

                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (_) {
                          return BlocProvider<SearchCityCubit>(
                            create: (context) => SearchCityCubit(),
                            child: SearchLocation(
                              weatherCubit: context.read<WeatherCubit>(),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      spacing: 4,
                      children: [
                        Text(
                          widget.data.name ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  )
                ],
              ), // Widget to show current location or to change the location
              const SizedBox(height: 16),
              AppUtils.instance
                  .getWeatherIcon(widget.data.weather?.first.icon ?? ""),
              const SizedBox(height: 16),
              Text(
                "${widget.data.main?.temp}°", //Current temperature
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.data.weather?.first.description ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppUtils.instance.formatCurrentDate(), // current Date
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.7)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WeatherInfo(
                    icon: Icons.wind_power,
                    label: "${widget.data.wind?.speed} KM/h",
                  ),
                  WeatherInfo(
                    icon: Icons.water_drop,
                    label: "${widget.data.main?.humidity}%",
                  ),
                  WeatherInfo(
                    icon: Icons.cloud,
                    label: "${widget.data.clouds?.all}%",
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
