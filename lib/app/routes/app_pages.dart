import 'package:get/get.dart';

import '../screens/home_view.dart';
import '../screens/settings_view.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/home';

  static final routes = [
    GetPage(name: '/home', page: () => const HomeView()),
    GetPage(name: '/settings', page: () => const SettingsView()),
  ];
}