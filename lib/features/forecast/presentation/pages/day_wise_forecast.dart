import 'package:flutter/material.dart';
import 'package:weather/features/forecast/presentation/widgets/current_weather_card.dart';
import 'package:weather/features/forecast/presentation/widgets/forecast_list.dart';
import 'package:weather/features/weather/data/entity/current_weather_data.dart';
import 'package:weather/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_state.dart';

class DayWiseForecast extends StatefulWidget {
  final TodayWeatherDataModel todayWeatherDataModel;
  final HourlyForeCastState foreCastState;
  const DayWiseForecast(
      {super.key,
      required this.todayWeatherDataModel,
      required this.foreCastState});

  @override
  State<DayWiseForecast> createState() => _DayWiseForecastState();
}

class _DayWiseForecastState extends State<DayWiseForecast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Forecasts",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double height = constraints.maxHeight;
          final double width = constraints.maxWidth;
          final double padding = width * 0.04; // Padding based on screen width

          return Stack(
            children: [
              // Background color
              Container(
                width: double.infinity,
                color: Colors.blueAccent,
              ),
              // White rounded background
              Positioned(
                top: MediaQuery.of(context).padding.top * 2,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                ),
              ),
              // Safe Area with responsive padding
              SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: padding, vertical: 16),
                  child: Column(
                    spacing: 24,
                    children: [
                      // Current Weather Card
                      CurrentWeatherCard(
                        todayWeatherDataModel: widget.todayWeatherDataModel,
                      ),

                      // Forecast List
                      Expanded(
                        child: Container(
                          child: widget.foreCastState is HourlyForecastLoading
                              ? CircularProgressIndicator()
                              : widget.foreCastState is HourlyForecastError
                                  ? SizedBox()
                                  : ForecastList(state: widget.foreCastState),
                        ),
                      ),
                      SizedBox(height: height * 0.02), // Bottom spacing
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
