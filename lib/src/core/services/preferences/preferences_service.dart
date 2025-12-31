import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService {
  Future<bool> hasCompletedOnboarding();
  Future<void> setOnboardingCompleted();
  Future<String> getLocale();
  Future<void> setLocale(String locale);

  // Location caching for sunrise/sunset calculation
  Future<double?> getCachedLatitude();
  Future<double?> getCachedLongitude();
  Future<void> cacheLocation(double latitude, double longitude);
}

@LazySingleton(as: PreferencesService)
class PreferencesServiceImpl implements PreferencesService {
  PreferencesServiceImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _keyOnboardingCompleted = 'onboarding_completed';
  static const _keyLocale = 'locale';
  static const _keyLatitude = 'cached_latitude';
  static const _keyLongitude = 'cached_longitude';

  @override
  Future<bool> hasCompletedOnboarding() async {
    return _prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  @override
  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(_keyOnboardingCompleted, true);
  }

  @override
  Future<String> getLocale() async {
    return _prefs.getString(_keyLocale) ?? 'kk';
  }

  @override
  Future<void> setLocale(String locale) async {
    await _prefs.setString(_keyLocale, locale);
  }

  @override
  Future<double?> getCachedLatitude() async {
    return _prefs.getDouble(_keyLatitude);
  }

  @override
  Future<double?> getCachedLongitude() async {
    return _prefs.getDouble(_keyLongitude);
  }

  @override
  Future<void> cacheLocation(double latitude, double longitude) async {
    await _prefs.setDouble(_keyLatitude, latitude);
    await _prefs.setDouble(_keyLongitude, longitude);
  }
}
