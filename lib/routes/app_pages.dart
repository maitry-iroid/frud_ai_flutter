import 'package:Freud_AI_app/modules/auth/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../modules/main/main_binding.dart';
import '../modules/main/main_tab.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => MainTab(),
      binding: MainBindings(),
      children: [],
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      //binding: MainBindings(),
      children: [],
    ),
  ];
}
