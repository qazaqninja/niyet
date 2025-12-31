import 'package:daylight/daylight.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../preferences/preferences_service.dart';

/// Sunrise and sunset times for a given day
class SunTimes {
  const SunTimes({
    required this.sunrise,
    required this.sunset,
  });

  /// Default times when location is unavailable (6am/6pm)
  factory SunTimes.defaults() {
    final now = DateTime.now();
    return SunTimes(
      sunrise: DateTime(now.year, now.month, now.day, 6, 0),
      sunset: DateTime(now.year, now.month, now.day, 18, 0),
    );
  }

  final DateTime sunrise;
  final DateTime sunset;
}

abstract class SunTimesService {
  Future<SunTimes> getTodaySunTimes();
  Future<bool> requestLocationPermission();
}

@LazySingleton(as: SunTimesService)
class SunTimesServiceImpl implements SunTimesService {
  SunTimesServiceImpl(this._preferencesService);

  final PreferencesService _preferencesService;

  SunTimes? _cachedTimes;
  DateTime? _cachedDate;

  @override
  Future<SunTimes> getTodaySunTimes() async {
    final today = DateTime.now();

    // Return cached times if still valid for today
    if (_cachedTimes != null &&
        _cachedDate != null &&
        _isSameDay(_cachedDate!, today)) {
      return _cachedTimes!;
    }

    // Try to get location
    final position = await _getPosition();

    if (position == null) {
      _cachedTimes = SunTimes.defaults();
      _cachedDate = today;
      return _cachedTimes!;
    }

    // Calculate sun times using daylight package
    final location = DaylightLocation(position.latitude, position.longitude);
    final calculator = DaylightCalculator(location);
    final result = calculator.calculateForDay(today);

    _cachedTimes = SunTimes(
      sunrise: result.sunrise ?? _defaultSunrise(today),
      sunset: result.sunset ?? _defaultSunset(today),
    );
    _cachedDate = today;

    return _cachedTimes!;
  }

  @override
  Future<bool> requestLocationPermission() async {
    // Check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Check current permission status
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> _getPosition() async {
    // Check cached location first
    final cachedLat = await _preferencesService.getCachedLatitude();
    final cachedLng = await _preferencesService.getCachedLongitude();

    if (cachedLat != null && cachedLng != null) {
      return Position(
        latitude: cachedLat,
        longitude: cachedLng,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );
    }

    // Try to get fresh location
    try {
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low, // City-level is enough
          timeLimit: Duration(seconds: 10),
        ),
      );

      // Cache the location
      await _preferencesService.cacheLocation(
        position.latitude,
        position.longitude,
      );

      return position;
    } catch (e) {
      return null;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime _defaultSunrise(DateTime date) {
    return DateTime(date.year, date.month, date.day, 6, 0);
  }

  DateTime _defaultSunset(DateTime date) {
    return DateTime(date.year, date.month, date.day, 18, 0);
  }
}
