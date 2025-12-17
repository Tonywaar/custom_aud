import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentTimeH = 0;
  int _currentTimeM = 0;
  int _currentTimeS = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedFlipCounter(
                value: _currentTimeH,
                prefix: _currentTimeH < 10 ? "0" : "",
                textStyle: TextStyle(
                  color: Colors.white54.withValues(alpha: .0),
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                  height: 1.3,
                  shadows: [
                    // Shadow(color: Colors.white54.withValues(alpha: .01), blurRadius: 1.0, offset: Offset(01, 01)),
                    // Shadow(color: Colors.white54.withValues(alpha: .01), blurRadius: 1.0, offset: Offset(-01, -01)),
                    Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: Offset(0, -1)),
                    Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: Offset(0, 1)),
                    Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: Offset(1, 0)),
                    Shadow(color: Colors.white54.withValues(alpha: .25), blurRadius: .5, offset: Offset(-1, 0)),
                    Shadow(color: Colors.black, blurRadius: .20, offset: Offset(0, 0)),
                  ],
                ),
              ),
              AnimatedFlipCounter(
                value: _currentTimeM,
                prefix: _currentTimeM < 10 ? "0" : "",
                textStyle: TextStyle(
                  color: Colors.white54.withValues(alpha: .25),
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                  height: 1.3,
                ),
              ),
              AnimatedFlipCounter(
                value: _currentTimeS,
                prefix: _currentTimeS < 10 ? "0" : "",
                textStyle: TextStyle(
                  color: Colors.white54.withValues(alpha: .25),
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}