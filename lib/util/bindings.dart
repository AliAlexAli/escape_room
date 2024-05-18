import 'package:escape_room/service/geolocation_service.dart';
import 'package:escape_room/service/nfc_service.dart';
import 'package:escape_room/service/notification_service.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GeolocationService());
    Get.put(NotificationService());
    Get.put(NfcService());
  }
}