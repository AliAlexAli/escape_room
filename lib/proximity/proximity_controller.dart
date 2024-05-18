import 'dart:async';
import 'dart:math';

import 'package:escape_room/service/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProximityController extends GetxController {
  final color = Colors.black.obs;
  Timer? _timer;
  final _geoService = Get.find<GeolocationService>();

  @override
  void onInit() {
    super.onInit();

    final distance = _geoService.getDistance();
    _startFlickerTimer(distance);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startFlickerTimer(double distance) {
    _timer?.cancel();

    int delay = distance.round();

    _timer = Timer.periodic(Duration(milliseconds: delay), (timer) {
      if (color.value == Colors.black) {
        color.value = Color.lerp(Colors.green, Colors.white, distance / 100)!;
      } else {
        color.value = Colors.black;
      }
    });
  }
}
