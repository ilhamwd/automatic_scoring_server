import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polling_server/presentation/controllers/splash_controller.dart';
import 'package:polling_server/utils/system.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: InkWell(
      onTap: () => System.instance.broadcast.stop(),
      child: const FlutterLogo(
        size: 150,
      ),
    )));
  }
}
