import 'dart:math';

import 'package:escape_room/direction_arrow/direction_arrow_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectionArrow extends GetView<DirectionArrowController> {
  const DirectionArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Obx(
          () {
            if (controller.permission.value != PermissionStatus.granted) {
              return const Center(
                  child: Text(
                'Engedélyezze az alkalmazásnak a helyzet meghatározást!',
                textAlign: TextAlign.center,
              ));
            }
            if (controller.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Obx(
                    () => Transform.rotate(
                      angle: controller.angle.value ?? 0,
                      child: Image.asset('assets/compass.png'),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
