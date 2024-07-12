import 'package:polling_server/presentation/bindings/home_binding.dart';
import 'package:polling_server/presentation/views/home_screen.dart';
import 'package:polling_server/presentation/bindings/splash_binding.dart';
import 'package:polling_server/presentation/views/splash_screen.dart';
import 'package:get/get.dart';
import 'package:polling_server/utils/routes.dart';

abstract class Navigation {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
  ];
}
