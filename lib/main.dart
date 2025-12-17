import 'package:custom_aod/app/services/settings_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize storage
  await GetStorage.init();

  settings.value = SettingsService.load();
  // Hide all system UI
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // The following line will enable the Android and iOS wakelock.
  WakelockPlus.enable();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    GetMaterialApp(
      title: "AOD",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Cairo',
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.grey[900],
          surfaceTintColor: Colors.transparent,
          margin: EdgeInsets.all(15),
        ),
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          color: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        dividerColor: Colors.grey[700],
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}