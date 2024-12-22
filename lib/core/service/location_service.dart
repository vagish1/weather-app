import 'package:geolocator/geolocator.dart';
import 'package:weather/core/error/exception.dart';

class LocationService {
  /// Checks the location permission status.
  Future<bool> isLocationPermissionGranted() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Requests location permission from the user.
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionException(
        'Location permissions are permanently denied. Enable them in settings.',
      );
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Retrieves the current position of the device.
  Future<Position> getCurrentPosition() async {
    // Check if location services are enabled
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceException(
          'Location services are disabled. Enable them in settings.');
    }

    // Ensure permissions are granted
    final bool permissionGranted = await isLocationPermissionGranted();
    if (!permissionGranted) {
      final bool requested = await requestLocationPermission();
      if (!requested) {
        throw LocationPermissionException(
            'Location permissions are not granted.');
      }
    }

    // Get the current location
    return await Geolocator.getCurrentPosition();
  }

  /// Checks if the location service is enabled.
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}

/// Custom exception for location service issues
