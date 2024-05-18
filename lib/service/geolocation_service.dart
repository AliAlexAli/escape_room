import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocationService extends GetxService {
  final currentPosition = Rxn<Position>();
  final lan = Rx<double>(47.550038405160166);
  final lon = Rx<double>(19.07270729222041);

  // NOTE(mate): important! currentPosition still can be null even if isLocationEnabled is true
  final isLocationEnabled = false.obs;
  LocationPermission? permission;

  StreamSubscription? _positionSub;
  late final LocationSettings _settings;

  @override
  void onInit() async {
    await _requestPermission(openSettingsIfDeniedForever: false);
    _trackPosition();
    super.onInit();
  }

  @override
  void onClose() {
    _positionSub?.cancel();
    super.onClose();
  }

  Future<void> _requestPermission({required bool openSettingsIfDeniedForever}) async {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      isLocationEnabled.value = false;
      currentPosition.value = null;
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      isLocationEnabled.value = false;
      currentPosition.value = null;

      if (openSettingsIfDeniedForever == true) {
        await Geolocator.openAppSettings();
      }
      return;
    }

    isLocationEnabled.value = true;
  }

  void _trackPosition() {
    _settings = _getLocationSettings();
    _positionSub = Geolocator.getPositionStream(locationSettings: _settings).listen((position) {
      currentPosition.value = position;
    });
  }

  LocationSettings _getLocationSettings() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: LocationAccuracy.best,
        intervalDuration: const Duration(seconds: 1),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return AppleSettings(
        accuracy: LocationAccuracy.best,
        activityType: ActivityType.other,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    }
    return const LocationSettings(
      accuracy: LocationAccuracy.high,
    );
  }

  Future<void> recheckPermission() async {
    await _requestPermission(openSettingsIfDeniedForever: true);
    if (isLocationEnabled.isFalse) {
      _positionSub?.pause();
    } else {
      _positionSub?.resume();
      currentPosition.value = await Geolocator.getCurrentPosition(desiredAccuracy: _settings.accuracy);
    }
  }

  double getDistance() {
    double lat1 = currentPosition.value!.latitude;
    double lon1 = currentPosition.value!.longitude;
    double lat2 = lan.value;
    double lon2 = lon.value;

    double toRadians(double degrees) {
      return degrees * pi / 180;
    }

    const double R = 6371000; // Radius of the Earth in meters

    // Convert latitude and longitude from degrees to radians
    double dLat = toRadians(lat2 - lat1);
    double dLon = toRadians(lon2 - lon1);
    lat1 = toRadians(lat1);
    lat2 = toRadians(lat2);

    // Haversine formula
    double a = pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = R * c;
    return distance;
  }
}
