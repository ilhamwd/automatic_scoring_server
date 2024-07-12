import 'dart:developer';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Socket connection test", () async {
    log("Initiating connection");
    final socket = await Socket.connect("localhost", 3065);

    for (int i = 0; i < 100; i++) {
      socket.writeln(String.fromCharCodes([29, i, 39, 102, 13, 255, 0]));

      await Future.delayed(const Duration(milliseconds: 100));
    }

    log("Connected (${socket.address}:${socket.port})");
    await socket.close();
  });
}
