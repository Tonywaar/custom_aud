import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:custom_aod/app/services/settings_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentTimeH = 0;
  int _currentTimeM = 0;
  int _currentTimeS = 0;
  bool _showSettings = true;
  Timer? _hideTimer;

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
      _currentTimeH = hour12;
      _currentTimeM = now.minute;
      _currentTimeS = now.second;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _startHideTimer,
        child: Stack(
          children: [
            Opacity(
              opacity: settings.value.clockOpacity / 100,
              child: Center(
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
                  ],
                ),
              ),
            ),
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