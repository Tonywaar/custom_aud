import 'package:battery_plus/battery_plus.dart';

class BatteryService {
  static Battery battery = Battery();

  static Future<double> getBatteryLevel() async {
    return (await battery.batteryLevel) / 100; // 0.0–1.0
  }

  // BatteryState.charging
  // BatteryState.discharging
  // BatteryState.full
  // BatteryState.unknown
  static Future<BatteryState> getBatteryState() async {
    return await battery.batteryState;
  }

  static Future<bool> isCharging() async {
    return await BatteryService.getBatteryState() == BatteryState.charging;
  }
}