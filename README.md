Flutter Weather App
📋 Task Overview
The Flutter Weather App provides users with real-time weather information for any city and location-based weather data. It fetches weather data from the OpenWeatherMap API, handles location permissions using Geolocator, and displays a 5-day weather forecast. The app also allows users to search for weather by city name and provides a list of matching city suggestions.

🚀 Features Implemented
1. Current Weather Data
Temperature: Displays the current temperature for the selected city or the user's current location.
Weather Conditions: Displays weather conditions like sunny, cloudy, rainy, etc.
Additional Information: Shows humidity, wind speed, and atmospheric pressure.
2. City Search
Allows users to search for weather data by entering a city name.
Provides suggestions for city names as the user types (optional feature for better UX).
3. Location-Based Weather
Uses the Geolocator package to fetch and display weather data based on the user's current location (GPS).
Handles location permissions for both Android and iOS, prompting the user for location access.
4. 5-Day Forecast
Displays a 5-day forecast using the OpenWeatherMap API's free subscription, showing the temperature and weather conditions for each of the next 5 days.
Displays a summary for each day, including the temperature range and conditions (e.g., sunny, cloudy, etc.).
🛠️ Technical Requirements
1. Weather API
The app fetches weather data from OpenWeatherMap.
Weather data includes:
Current temperature, humidity, wind speed, and pressure.
A 5-day forecast with weather summaries for each day (temperature range, conditions, etc.).
2. State Management
BLoC (Business Logic Component) is used for managing app states such as loading, success, and error states during API calls.
3. Location Functionality
The Geolocator package is used to retrieve the user’s current GPS location and fetch weather data for that location.
The app gracefully handles location permissions on both Android and iOS.
4. API Requests with Dio
Dio package is used for making HTTP requests to the OpenWeatherMap API.
Dio handles error responses, retries, and parsing of the weather data in JSON format.
The weather data is parsed and displayed in the app.
Errors such as failed API requests, invalid city names, or missing permissions are handled appropriately.
5. Error Handling
Clear error messages are shown in case of errors like invalid city names, missing location permissions, or API failures.
🔧 Dependencies Used
dio: For making HTTP requests to the OpenWeatherMap API.
geolocator: To fetch the user’s current GPS location.
bloc: For managing the app’s state using the BLoC pattern.
flutter: The main framework used to build the app.
📝 Steps to Set Up and Run the App
1. Clone the Repository
Clone the repository to your local machine:

bash
Copy code
git clone https://github.com/yourusername/flutter_weather_app.git
2. Install Dependencies
Run the following command to install the dependencies:

bash
Copy code
flutter pub get
3. Set Up API Key
To fetch weather data from the OpenWeatherMap API, you need to sign up for an API key from OpenWeatherMap.

Once you have the API key, add it to your lib/config.dart file:

dart
Copy code
const String apiKey = 'YOUR_API_KEY';
4. Handle Location Permissions
Make sure to handle location permissions for both Android and iOS.

For Android:

Open your AndroidManifest.xml file and add the following permissions:
xml
Copy code
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
For iOS:

In Info.plist, add:
xml
Copy code
<key>NSLocationWhenInUseUsageDescription</key>
<string>Your location is needed for weather updates</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Your location is needed for weather updates</string>
5. Run the App
Once you’ve set up the API key and permissions, run the app using:

bash
Copy code
flutter run
This will launch the app, and you can start using the weather features such as searching for cities or getting weather data based on your current location.

🧹 Clean and Modular Code
The code is structured for clarity, modularity, and maintainability. Features are divided into different components:

State Management: Using the BLoC pattern to handle app states effectively.
Location Handling: Geolocator package is used to handle location retrieval and permissions.
UI Components: Designed with Material Design principles to ensure a responsive and user-friendly interface.
🎨 User Interface
The UI is built using Flutter’s Material Design components. It features:

A search bar for entering city names.
A button to fetch weather data based on the user’s current location.
Displays current weather along with hourly and 5-day forecasts.
Clear layout with consistent design, which adjusts to different screen sizes.
⚙️ API Integration Details
Here is an example of how to fetch weather data using the Dio package:

1. Config.dart (API Key)
dart
Copy code
const String apiKey = 'YOUR_API_KEY';
const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
2. Weather API Service with Dio
dart
Copy code
import 'package:dio/dio.dart';

class WeatherApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final response = await _dio.get(
        '${baseUrl}weather',
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric', // For Celsius temperature
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchForecast(String city) async {
    try {
      final response = await _dio.get(
        '${baseUrl}forecast',
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric',
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load weather forecast: $e');
    }
  }
}
3. State Management with BLoC
3.1 Search City Bloc
dart
Copy code
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCityCubit extends Cubit<List<String>> {
  final WeatherApiService weatherApiService;

  SearchCityCubit(this.weatherApiService) : super([]);

  void searchCity(String query) async {
    try {
      if (query.isNotEmpty) {
        final weatherData = await weatherApiService.fetchWeather(query);
        emit([weatherData['name']]);
      }
    } catch (e) {
      emit([]);
    }
  }
}
3.2 Location Bloc
dart
Copy code
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<Map<String, dynamic>> {
  final WeatherApiService weatherApiService;

  LocationCubit(this.weatherApiService) : super({});

  void fetchLocationWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final weatherData = await weatherApiService.fetchWeather(position.latitude.toString() + "," + position.longitude.toString());
      emit(weatherData);
    } catch (e) {
      emit({});
    }
  }
}
Happy Coding! 🎉
