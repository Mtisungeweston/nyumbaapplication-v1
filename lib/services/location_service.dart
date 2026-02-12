import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/location_model.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  /// Request location permissions for Android and iOS
  Future<bool> requestLocationPermission() async {
    final status = await Geolocator.requestPermission();

    if (status == LocationPermission.denied) {
      return false;
    } else if (status == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
      return false;
    }
    return true;
  }

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Get the user's current location
  Future<LocationModel?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled. Please enable them in settings.';
      }

      // Request permission
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        throw 'Location permission is required to use this feature.';
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // Convert coordinates to address
      final address = await _getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address['address'],
        city: address['city'],
        district: address['district'],
        country: address['country'],
      );
    } catch (e) {
      print('[LocationService] Error getting current location: $e');
      return null;
    }
  }

  /// Stream location updates in real-time
  Stream<LocationModel> getLocationStream() async* {
    try {
      // Check if location services are enabled
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      // Request permission
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        throw 'Location permission is required.';
      }

      final locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
        intervalDuration: const Duration(seconds: 5),
      );

      await for (final position
          in Geolocator.getPositionStream(locationSettings: locationSettings)) {
        final address = await _getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );

        yield LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address['address'],
          city: address['city'],
          district: address['district'],
          country: address['country'],
        );
      }
    } catch (e) {
      print('[LocationService] Error in location stream: $e');
    }
  }

  /// Convert coordinates to human-readable address
  Future<Map<String, String?>> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        return {
          'address': '$latitude, $longitude',
          'city': null,
          'district': null,
          'country': null,
        };
      }

      final place = placemarks.first;

      // Build address string
      final addressParts = [
        place.thoroughfare,
        place.subLocality,
        place.locality,
        place.administrativeArea,
      ].where((part) => part != null && part.isNotEmpty).toList();

      final address = addressParts.join(', ');

      return {
        'address': address.isNotEmpty ? address : '$latitude, $longitude',
        'city': place.locality,
        'district': place.administrativeArea,
        'country': place.country,
      };
    } catch (e) {
      print('[LocationService] Error converting coordinates to address: $e');
      return {
        'address': '$latitude, $longitude',
        'city': null,
        'district': null,
        'country': null,
      };
    }
  }

  /// Calculate distance between two locations (in kilometers)
  double calculateDistance(
    double latitude1,
    double longitude1,
    double latitude2,
    double longitude2,
  ) {
    return Geolocator.distanceBetween(
      latitude1,
      longitude1,
      latitude2,
      longitude2,
    ) / 1000; // Convert meters to kilometers
  }

  /// Filter properties by distance (radius in kilometers)
  List<T> filterByDistance<T extends Object>(
    List<T> properties,
    double userLatitude,
    double userLongitude,
    double radiusKm, {
    required double Function(T) getPropertyLatitude,
    required double Function(T) getPropertyLongitude,
  }) {
    return properties.where((property) {
      final distance = calculateDistance(
        userLatitude,
        userLongitude,
        getPropertyLatitude(property),
        getPropertyLongitude(property),
      );
      return distance <= radiusKm;
    }).toList();
  }
}
