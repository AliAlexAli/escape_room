import 'package:escape_room/proximity/proximity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Proximity extends GetView<ProximityController> {
  const Proximity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AnimatedContainer(
          color: controller.color.value,
          curve: Curves.linear,
          constraints: const BoxConstraints.expand(),
          duration: Duration.zero,
        ),
      ),
    );
  }
}
