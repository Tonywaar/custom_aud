import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:custom_aod/app/services/settings_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/battery_services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentTimeH = 0;
  int _currentTimeM = 0;
  int _currentTimeS = 0;
  double _offsetX = 0;
  double _offsetY = 0;
  bool _showSettings = true;
  Timer? _hideTimer;

  double batteryPercentage = 0.0;
  bool isCharging = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
    _startHideTimer();
  }

  void _startHideTimer() {
    if (_hideTimer != null) {
      _hideTimer!.cancel();
    }
    setState(() {
      _showSettings = true;
    });
    _hideTimer = Timer(const Duration(seconds: 15), () {
      setState(() {
        _showSettings = false;
      });
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour12 = now.hour == 0 ? 12 : (now.hour > 12 ? now.hour - 12 : now.hour);

    setState(() {
      // Update position every minute if saveOled is true
      if (settings.value.saveOled && _currentTimeM != now.minute) {
        if (settings.value.overProtect) {
          // Calculate safe bounds based on screen size and clock size
          // We assume the clock area is roughly clockSize*2 wide and clockSize*3.5 tall
          final double safeMarginX = (Get.width / 2) - (settings.value.clockSize * 1.2);
          final double safeMarginY = (Get.height / 2) - (settings.value.clockSize * 2.5);

          // Ensure margins are at least 0
          final double rangeX = max(0.0, safeMarginX);
          final double rangeY = max(0.0, safeMarginY);

          _offsetX = (Random().nextDouble() * 2 - 1) * rangeX;
          _offsetY = (Random().nextDouble() * 2 - 1) * rangeY;
        } else {
          _offsetX = (DateTime.now().second % 10 - 5).toDouble();
          _offsetY = (DateTime.now().microsecond % 10 - 5).toDouble();
        }
      } else if (!settings.value.saveOled) {
        _offsetX = 0;
        _offsetY = 0;
      }

      _currentTimeH = hour12;
      _currentTimeM = now.minute;
      _currentTimeS = now.second;

      if (now.second % 15 == 0) {
        _updateBatteryInfo();
      }
    });
  }

  _updateBatteryInfo() async {
    batteryPercentage = await BatteryService.getBatteryLevel();
    isCharging = await BatteryService.isCharging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _startHideTimer,
        onDoubleTap: () => exit(0),
        child: Stack(
          children: [
            Obx(() => Opacity(
                  opacity: settings.value.clockOpacity / 100,
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(_offsetX, _offsetY),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedFlipCounter(
                            value: _currentTimeH,
                            prefix: _currentTimeH < 10 ? "0" : "",
                            textStyle: TextStyle(
                              color: Colors.white54.withValues(alpha: settings.value.isBorderedHours ? .0 : .50),
                              fontSize: settings.value.clockSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                              height: 1.3,
                              shadows: settings.value.isBorderedHours
                                  ? [
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(0, -1)),
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(0, 1)),
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(1, 0)),
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(-1, 0)),
                                      const Shadow(color: Colors.black, blurRadius: .20, offset: Offset(0, 0)),
                                    ]
                                  : [],
                            ),
                          ),
                          AnimatedFlipCounter(
                            value: _currentTimeM,
                            prefix: _currentTimeM < 10 ? "0" : "",
                            textStyle: TextStyle(
                              color: Colors.white54.withValues(alpha: settings.value.isBorderedMinutes ? .0 : .50),
                              fontSize: settings.value.clockSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                              height: 1.3,
                              shadows: settings.value.isBorderedMinutes
                                  ? [
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(0, -1)),
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(0, 1)),
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(1, 0)),
                                      Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(-1, 0)),
                                      const Shadow(color: Colors.black, blurRadius: .20, offset: Offset(0, 0)),
                                    ]
                                  : [],
                            ),
                          ),
                          Obx(() {
                            return Visibility(
                              visible: settings.value.withSeconds,
                              child: AnimatedFlipCounter(
                                value: _currentTimeS,
                                prefix: _currentTimeS < 10 ? "0" : "",
                                textStyle: TextStyle(
                                  color: Colors.white54.withValues(alpha: settings.value.isBorderedSeconds ? .0 : .50),
                                  fontSize: settings.value.clockSize,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                  height: 1.3,
                                  shadows: settings.value.isBorderedSeconds
                                      ? [
                                          Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(0, -1)),
                                          Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(0, 1)),
                                          Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(1, 0)),
                                          Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: const Offset(-1, 0)),
                                          const Shadow(color: Colors.black, blurRadius: .20, offset: Offset(0, 0)),
                                        ]
                                      : [],
                                ),
                              ),
                            );
                          }),
                          if (batteryPercentage > 0)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isCharging) const Icon(CupertinoIcons.bolt, size: 10, color: Colors.white54),
                                Text(
                                  "${(batteryPercentage * 100).toStringAsFixed(0)}%",
                                  style: context.textTheme.bodySmall?.copyWith(color: Colors.white54),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                )),
            AnimatedOpacity(
              opacity: _showSettings ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: !_showSettings,
                child: IconButton(
                  onPressed: () {
                    Get.toNamed("/settings");
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}