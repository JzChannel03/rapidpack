import 'package:shared_preferences/shared_preferences.dart';

enum AppMode { simple, complete }

enum Handedness { right, left }

class PreferencesService {
  static const _keyOnboardingDone = 'onboarding_done';
  static const _keyAppMode = 'app_mode';
  static const _keyHandedness = 'handedness';

  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingDone) ?? false;
  }

  static Future<void> saveOnboarding({
    required AppMode mode,
    required Handedness handedness,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingDone, true);
    await prefs.setString(_keyAppMode, mode.name);
    await prefs.setString(_keyHandedness, handedness.name);
  }

  static Future<AppMode> getAppMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_keyAppMode);
    return value == 'simple' ? AppMode.simple : AppMode.complete;
  }

  static Future<Handedness> getHandedness() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_keyHandedness);
    return value == 'left' ? Handedness.left : Handedness.right;
  }
}
