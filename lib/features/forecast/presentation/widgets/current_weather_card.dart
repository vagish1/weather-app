import 'package:flutter/material.dart';
import 'package:weather/core/utils/app_utils.dart';
import 'package:weather/features/forecast/presentation/widgets/weather_info.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';

class CurrentWeatherCard extends StatelessWidget {
  final TodayWeatherDataModel todayWeatherDataModel;
  const CurrentWeatherCard({super.key, required this.todayWeatherDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding:
            const EdgeInsets.all(24.0), // Increased padding for breathing room
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUtils.instance.getWeatherIcon(
                      todayWeatherDataModel.weather?.first.icon ?? "",
                      size: 80,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${todayWeatherDataModel.weather?.first.description}",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .merge(TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white, // Contrasts with gradient
                          )),
                    ),
                  ],
                ),
                Text(
                  '${todayWeatherDataModel.main?.temp}°',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Matches the gradient theme
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.white.withOpacity(0.4),
              thickness: 1,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherInfo(
                  icon: Icons.wind_power,
                  label: "${todayWeatherDataModel.wind?.speed} KM/h",
                ),
                WeatherInfo(
                  icon: Icons.water_drop,
                  label: "${todayWeatherDataModel.main?.humidity}%",
                ),
                WeatherInfo(
                  icon: Icons.cloud,
                  label: "${todayWeatherDataModel.clouds?.all}%",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
