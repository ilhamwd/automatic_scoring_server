import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polling_server/presentation/controllers/home_controller.dart';
import 'package:polling_server/utils/system.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Center(
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Running as ${System.instance.broadcast.service.name}"),
              const SizedBox(height: 10),
              Text("Total clients: ${controller.numOfClients}"),
              const SizedBox(height: 10),
              Text(
                  "Total received packets: ${controller.numOfPackets} (${controller.sizeOfPackets} bytes)"),
              const SizedBox(height: 10),
              StreamBuilder(
                  stream: System.instance.broadcast.eventStream,
                  builder: (context, snapshot) {
                    return Text(snapshot.data?.type.name ?? "MT");
                  }),
              const SizedBox(height: 15),
              FilledButton(
                  onPressed: System.instance.broadcast.stop,
                  child: const Icon(Icons.stop_rounded)),
            ],
          );
        }),
      )),
    );
  }
}
