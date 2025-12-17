import 'package:get_storage/get_storage.dart';

class AppSettings {
  final bool isBorders;
  final bool withSeconds;

  AppSettings({this.isBorders = false, this.withSeconds = false});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isBorders: json['isBorders'] ?? false,
      withSeconds: json['withSeconds'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isBorders': isBorders,
      'withSeconds': withSeconds,
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