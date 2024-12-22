import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class AppUtils {
  AppUtils.init();
  static final AppUtils instance = AppUtils.init();
  String formatCurrentDate() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE, MMMM d').format(now);
    return formattedDate;
  }

  String convertUnixToReadableTime(int unixTimestamp, {String? format}) {
    // Convert the Unix timestamp (in seconds) to a DateTime object
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000, isUtc: true);

    // Format the DateTime object to a readable time format
    String formattedTime = DateFormat(format ?? 'HH:mm').format(dateTime);

    return formattedTime;
  }

  Widget getWeatherIcon(String iconCode, {double size = 135}) {
    // Mapping icon code to a corresponding weather icon or image
    switch (iconCode) {
      case '01d':
      case '01n':
        return Icon(Icons.wb_sunny,
            size: size, color: Colors.yellow); // Clear sky
      case '02d':
      case '02n':
        return Icon(Icons.cloud,
            size: size, color: Colors.blueGrey); // Few clouds
      case '03d':
      case '03n':
        return Icon(Icons.cloud,
            size: size, color: Colors.blueGrey); // Scattered clouds
      case '04d':
      case '04n':
        return Icon(Icons.cloud,
            size: size, color: Colors.blueGrey); // Broken clouds
      case '09d':
      case '09n':
        return Icon(Icons.grain, size: size, color: Colors.blue); // Shower rain
      case '10d':
      case '10n':
        return Icon(Icons.grain, size: size, color: Colors.blue); // Rain
      case '11d':
      case '11n':
        return Icon(Icons.flash_on,
            size: size, color: Colors.yellow); // Thunderstorm
      case '13d':
      case '13n':
        return Icon(Icons.ac_unit, size: size, color: Colors.white); // Snow
      case '50d':
      case '50n':
        return Icon(Icons.filter_drama,
            size: size, color: Colors.white); // Mist
      default:
        return Icon(Icons.help_outline,
            size: size, color: Colors.black); // Unknown weather
    }
  }

  Future<bool> isConnectedToInternet() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    Logger().d(result.toList());
    // Check if the connection is either WiFi or mobile data
    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }
}
