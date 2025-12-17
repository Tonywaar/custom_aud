import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final settings = AppSettings().obs;

class AppSettings {
  bool isBorderedHours;
  bool isBorderedMinutes;
  bool isBorderedSeconds;
  bool withSeconds;
  double clockOpacity;
  double clockSize;

  AppSettings({
    this.isBorderedHours = false,
    this.isBorderedMinutes = false,
    this.isBorderedSeconds = false,
    this.withSeconds = false,
    this.clockOpacity = 80,
    this.clockSize = 80,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isBorderedHours: json['isBorderedHours'] ?? false,
      isBorderedMinutes: json['isBorderedMinutes'] ?? false,
      isBorderedSeconds: json['isBorderedSeconds'] ?? false,
      withSeconds: json['withSeconds'] ?? false,
      clockOpacity: json['clockOpacity'] ?? 80,
      clockSize: json['clockSize'] ?? 80,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isBorderedHours': isBorderedHours,
      'isBorderedMinutes': isBorderedMinutes,
      'isBorderedSeconds': isBorderedSeconds,
      'withSeconds': withSeconds,
      'clockOpacity': clockOpacity,
      'clockSize': clockSize,
    };
  }
}

class SettingsService {
  static final _box = GetStorage();
  static const _key = "app_settings";

  static AppSettings load() {
    final data = _box.read(_key);
    if (data != null) {
      return AppSettings.fromJson(Map<String, dynamic>.from(data));
    }
    return AppSettings(); // default
  }

  static Future<void> save(AppSettings settings) async {
    await _box.write(_key, settings.toJson());
  }
}