import 'package:get/get.dart';
import 'package:polling_server/utils/system.dart';

class HomeController extends GetxController {
  RxInt numOfClients = 0.obs;
  RxInt numOfPackets = 0.obs;
  RxInt sizeOfPackets = 0.obs;

  @override
  void onInit() {
    super.onInit();

    System.instance.server.listen((client) {
      numOfClients++;

      client.listen((event) {
        numOfPackets++;
        sizeOfPackets += event.length;

        client.write(1);
      });
    });
  }
}
