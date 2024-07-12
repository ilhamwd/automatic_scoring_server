import 'dart:io';
import 'dart:math';

import 'package:bonsoir/bonsoir.dart';

class System {
  System._();

  static final _instance = System._();

  static System get instance => _instance;

  late final ServerSocket server;
  late final BonsoirBroadcast broadcast;
  late final String address;
  final int discoveryServicePort = 3065;
  final int serverPort = 1249;
  final serverIdentifier = Random().nextInt(100).toString().padLeft(2, "0");

  Future<void> init() async {
    NetworkInterface.list();

    try {
      final interfaces = await NetworkInterface.list();

      address = interfaces.first.addresses.first.address;
    } catch (e) {
      throw InitException.networkError;
    }

    final service = BonsoirService(
        name: "Polling Server $serverIdentifier",
        port: 3065,
        type: "_pollingdiscovery._tcp",
        attributes: {"ip_address": address, "port": serverPort.toString()});

    broadcast = BonsoirBroadcast(service: service);
    await broadcast.ready;

    await broadcast.start();

    server = await ServerSocket.bind(address, serverPort);
  }
}

enum InitException { networkError }
