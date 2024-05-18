import 'dart:math';

import 'package:escape_room/service/geolocation_service.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectionArrowController extends GetxController {
  final permission = Rxn<PermissionStatus>();
  final _deviceAngle = Rxn<double>();
  final _positionAngle = Rxn<double>();
  final angle = Rxn<double>();
  final geoService = Get.find<GeolocationService>();

  bool get loading => _deviceAngle.value == null || _positionAngle.value == null;

  @override
  void onInit() {
    super.onInit();
    _getLocationPermission();
    ever(geoService.currentPosition, (p0) {
      if (p0 == null) {
        return;
      }

      _positionAngle.value = _calculateAngle(p0.latitude, p0.longitude, geoService.lan.value, geoService.lon.value);
      angle.value = _positionAngle.value! + (_deviceAngle.value ?? 0);
    });

    FlutterCompass.events?.listen((event) {
      if (event.heading == null) {
        return;
      }
      _deviceAngle.value = event.heading! * (pi / 180) * -1;
      angle.value = (_positionAngle.value ?? 0) + _deviceAngle.value!;
    });
  }

  double _calculateAngle(double latitude1, double longitude1, double latitude2, double longitude2) {
    double lat1Rad = latitude1 * (pi / 180);
    double lon1Rad = longitude1 * (pi / 180);
    double lat2Rad = latitude2 * (pi / 180);
    double lon2Rad = longitude2 * (pi / 180);

    double deltaLon = lon2Rad - lon1Rad;

    double y = sin(deltaLon) * cos(lat2Rad);
    double x = cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(deltaLon);
    double angleRad = atan2(y, x);

    angleRad = (angleRad + 2 * pi) % (2 * pi);

    return angleRad;
  }

  Future<void> _getLocationPermission() async {
    permission.value = await Permission.locationWhenInUse.status;
    if (permission.value != PermissionStatus.granted) {
      permission.value = await Permission.locationWhenInUse.request();
    }
  }
}
