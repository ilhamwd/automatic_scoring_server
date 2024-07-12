import 'package:get/get.dart';
import 'package:polling_server/utils/system.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    System.instance.init().then((value) {
      Get.back();
    });
  }
}
