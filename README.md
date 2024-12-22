# Flutter Weather App

## 📋 Task Overview

The **Flutter Weather App** provides users with real-time weather information for any city and location-based weather data. It fetches weather data from the **OpenWeatherMap API**, handles location permissions using **Geolocator**, and displays a 5-day weather forecast. The app also allows users to search for weather by city name and provides a list of matching city suggestions.

## 🚀 Features Implemented

### 1. **Current Weather Data**
   - **Temperature**: Displays the current temperature for the selected city or the user's current location.
   - **Weather Conditions**: Displays weather conditions like sunny, cloudy, rainy, etc.
   - **Additional Information**: Shows humidity, wind speed, and atmospheric pressure.

### 2. **City Search**
   - Allows users to search for weather data by entering a city name.
   - Provides suggestions for city names as the user types (optional feature for better UX).

### 3. **Location-Based Weather**
   - Uses the **Geolocator** package to fetch and display weather data based on the user's current location (GPS).
   - Handles location permissions for both Android and iOS, prompting the user for location access.

### 4. **5-Day Forecast**
   - Displays a 5-day forecast using the OpenWeatherMap API's free subscription, showing the temperature and weather conditions for each of the next 5 days.
   - Displays a summary for each day, including the temperature range and conditions (e.g., sunny, cloudy, etc.).

## 🛠️ Technical Requirements

### 1. **Weather API**
   - The app fetches weather data from **OpenWeatherMap**.
   - Weather data includes:
     - Current temperature, humidity, wind speed, and pressure.
     - A 5-day forecast with weather summaries for each day (temperature range, conditions, etc.).

### 2. **State Management**
   - **BLoC** (Business Logic Component) is used for managing app states such as loading, success, and error states during API calls.

### 3. **Location Functionality**
   - The **Geolocator** package is used to retrieve the user’s current GPS location and fetch weather data for that location.
   - The app gracefully handles location permissions on both Android and iOS.

### 4. **API Requests with Dio**
   - **Dio** package is used for making HTTP requests to the OpenWeatherMap API.
   - Dio handles error responses, retries, and parsing of the weather data in JSON format.
   - The weather data is parsed and displayed in the app.
   - Errors such as failed API requests, invalid city names, or missing permissions are handled appropriately.

### 5. **Error Handling**
   - Clear error messages are shown in case of errors like invalid city names, missing location permissions, or API failures.

## 🔧 Dependencies Used

- **dio**: For making HTTP requests to the OpenWeatherMap API.
- **geolocator**: To fetch the user’s current GPS location.
- **bloc**: For managing the app’s state using the BLoC pattern.
- **flutter**: The main framework used to build the app.

## 📝 Steps to Set Up and Run the App

### 1. **Clone the Repository**

Clone the repository to your local machine:

```bash
git clone https://github.com/vagish1/weather-app.git

### 1. **Clone the Repository**


