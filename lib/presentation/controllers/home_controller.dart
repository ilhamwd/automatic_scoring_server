import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

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

        generateRandomImage(100, 100).then((value) => client.add(value));
      });
    });
  }

  Future<Uint8List> generateRandomImage(int width, int height) async {
    final Random random = Random();
    final Uint8List pixels = Uint8List(width * height * 4);

    for (int i = 0; i < pixels.length; i += 4) {
      pixels[i] = random.nextInt(256); // Red
      pixels[i + 1] = random.nextInt(256); // Green
      pixels[i + 2] = random.nextInt(256); // Blue
      pixels[i + 3] = 255; // Alpha (fully opaque)
    }

    final Image image = await createImageFromPixels(pixels, width, height);
    final ByteData? byteData =
        await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Image> createImageFromPixels(
      Uint8List pixels, int width, int height) async {
    final Completer<Image> completer = Completer();
    decodeImageFromPixels(
      pixels,
      width,
      height,
      PixelFormat.rgba8888,
      (Image img) {
        completer.complete(img);
      },
    );
    return completer.future;
  }
}
